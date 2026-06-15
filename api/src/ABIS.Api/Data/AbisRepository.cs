using System.Data.Common;
using Abis.Api.Models;
using Dapper;

namespace Abis.Api.Data;

/// <summary>
/// Dapper-backed repository. SQL is written to be portable across the two
/// supported engines: parameters use the <c>:name</c> prefix (accepted by both
/// Microsoft.Data.Sqlite via Dapper and Oracle natively), and every column is
/// aliased to its model property name (Dapper matches case-insensitively, so
/// Oracle's upper-cased aliases still bind correctly). Each parameter is used
/// exactly once and in source order, so Oracle's default positional binding is
/// also satisfied. The dialect-specific paging clause comes from the factory.
/// </summary>
public sealed class AbisRepository : IAbisRepository
{
    private readonly IDbConnectionFactory _factory;

    public AbisRepository(IDbConnectionFactory factory) => _factory = factory;

    private const string JobCols = """
        ab_job_num AS AbJobNum, order_abc_num AS OrderAbcNum, order_item_num AS OrderItemNum,
        line_num AS LineNum, job_status AS JobStatus, material_yield AS MaterialYield,
        number_of_men_used AS NumberOfMenUsed, sketch_id AS SketchId, create_date AS CreateDate,
        due_date AS DueDate, time_date_started AS TimeDateStarted, time_date_finished AS TimeDateFinished,
        job_notes AS JobNotes, sketch_job_note AS SketchJobNote
        """;

    private const string CoilCols = """
        coil_abc_num AS CoilAbcNum, coil_alloy2 AS CoilAlloy2, coil_temper AS CoilTemper,
        coil_gauge AS CoilGauge, coil_width AS CoilWidth, coil_line_num AS CoilLineNum,
        coil_location AS CoilLocation, coil_mid_num AS CoilMidNum, coil_org_num AS CoilOrgNum,
        coil_status AS CoilStatus, coil_notes AS CoilNotes, coil_entry_date AS CoilEntryDate,
        customer_id AS CustomerId, coil_from_cust_id AS CoilFromCustId, date_received AS DateReceived,
        icra AS Icra, lot_num AS LotNum, net_wt AS NetWt, net_wt_balance AS NetWtBalance,
        pieces_per_case AS PiecesPerCase
        """;

    private const string OrderCols = """
        order_abc_num AS OrderAbcNum, orig_customer_id AS OrigCustomerId,
        orig_customer_po AS OrigCustomerPo, enduser_po AS EnduserPo, scrap_handing_type AS ScrapHandingType
        """;

    private const string OrderItemCols = """
        order_item_num AS OrderItemNum, enduser_part_num AS EnduserPartNum, alloy2 AS Alloy2,
        temper AS Temper, gauge AS Gauge, gauge_p AS GaugeP, gauge_m AS GaugeM, surface AS Surface,
        flatness AS Flatness, sheet_type AS SheetType, material_end_use AS MaterialEndUse,
        order_item_desc AS OrderItemDesc, pieces_skid AS PiecesSkid,
        theoretical_unit_wt AS TheoreticalUnitWt, unit_price AS UnitPrice, item_created_dttm AS ItemCreatedDttm
        """;

    private const string TestCols = """
        created_date AS CreatedDate, test_type AS TestType, position AS Position, yts_val AS YtsVal,
        uts_val AS UtsVal, elong_val AS ElongVal, n_val AS NVal, r_val AS RVal,
        thickness AS Thickness, width AS Width
        """;

    private const string CustomerCols = """
        customer_id AS CustomerId, customer_name AS CustomerName, customer_short_name AS CustomerShortName,
        enduser_name AS EnduserName, shipto_customer_zip AS ShiptoCustomerZip
        """;

    private const string SheetSkidCols = """
        sheet_skid_num AS SheetSkidNum, ab_job_num AS AbJobNum, sheet_skid_display_num AS SheetSkidDisplayNum,
        sheet_net_wt AS SheetNetWt, sheet_tare_wt AS SheetTareWt, skid_pieces AS SkidPieces, skid_date AS SkidDate
        """;

    private const string ScrapSkidCols = """
        scrap_skid_num AS ScrapSkidNum, scrap_ab_job_num AS ScrapAbJobNum, scrap_alloy2 AS ScrapAlloy2,
        scrap_temper AS ScrapTemper, scrap_type AS ScrapType, scrap_net_wt AS ScrapNetWt, scrap_tare_wt AS ScrapTareWt,
        scrap_location AS ScrapLocation, scrap_notes AS ScrapNotes, skid_scrap_status AS SkidScrapStatus, scrap_date AS ScrapDate
        """;

    private const string AuditCols = """
        opc_log_id AS OpcLogId, time_stamp AS TimeStamp, source AS Source, success AS Success, notes AS Notes
        """;

    private async Task<DbConnection> OpenAsync(CancellationToken ct)
    {
        var conn = _factory.Create();
        await conn.OpenAsync(ct);
        return conn;
    }

    private async Task<PagedResult<T>> PageAsync<T>(
        string columns, string from, string orderBy, string? where,
        object pageArgs, int page, int pageSize, CancellationToken ct)
    {
        page = Math.Max(1, page);
        pageSize = Math.Clamp(pageSize, 1, 200);
        var whereSql = string.IsNullOrEmpty(where) ? "" : $" WHERE {where}";

        await using var conn = await OpenAsync(ct);

        var total = await conn.ExecuteScalarAsync<long>(
            new CommandDefinition($"SELECT COUNT(*) FROM {from}{whereSql}", pageArgs, cancellationToken: ct));

        var sql = _factory.Paginate($"SELECT {columns} FROM {from}{whereSql} ORDER BY {orderBy}");
        var args = Merge(pageArgs, new { limit = pageSize, offset = (page - 1) * pageSize });
        var rows = await conn.QueryAsync<T>(new CommandDefinition(sql, args, cancellationToken: ct));

        return new PagedResult<T>
        {
            Items = rows.AsList(),
            Page = page,
            PageSize = pageSize,
            TotalCount = total
        };
    }

    public Task<PagedResult<AbJob>> GetJobsAsync(int page, int pageSize, int? status, CancellationToken ct) =>
        PageAsync<AbJob>(JobCols, "ab_job", "ab_job_num",
            status is null ? null : "job_status = :status",
            new { status }, page, pageSize, ct);

    public async Task<AbJob?> GetJobAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<AbJob>(new CommandDefinition(
            $"SELECT {JobCols} FROM ab_job WHERE ab_job_num = :id", new { id = abJobNum }, cancellationToken: ct));
    }

    public async Task<IReadOnlyList<ProcessCoil>> GetJobCoilsAsync(long abJobNum, CancellationToken ct)
    {
        const string sql = """
            SELECT pc.ab_job_num AS AbJobNum, pc.coil_abc_num AS CoilAbcNum,
                   pc.process_coil_status AS ProcessCoilStatus, pc.process_date AS ProcessDate,
                   pc.process_end_wt AS ProcessEndWt, pc.process_quantity AS ProcessQuantity,
                   c.coil_alloy2 AS CoilAlloy2, c.coil_gauge AS CoilGauge, c.coil_width AS CoilWidth
            FROM process_coil pc
            LEFT JOIN coil c ON c.coil_abc_num = pc.coil_abc_num
            WHERE pc.ab_job_num = :id
            ORDER BY pc.coil_abc_num
            """;
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<ProcessCoil>(new CommandDefinition(sql, new { id = abJobNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public Task<PagedResult<Coil>> GetCoilsAsync(int page, int pageSize, int? status, CancellationToken ct) =>
        PageAsync<Coil>(CoilCols, "coil", "coil_abc_num",
            status is null ? null : "coil_status = :status",
            new { status }, page, pageSize, ct);

    public async Task<Coil?> GetCoilAsync(long coilAbcNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Coil>(new CommandDefinition(
            $"SELECT {CoilCols} FROM coil WHERE coil_abc_num = :id", new { id = coilAbcNum }, cancellationToken: ct));
    }

    public Task<PagedResult<CustomerOrder>> GetOrdersAsync(int page, int pageSize, CancellationToken ct) =>
        PageAsync<CustomerOrder>(OrderCols, "customer_order", "order_abc_num", null,
            new { }, page, pageSize, ct);

    public async Task<CustomerOrder?> GetOrderAsync(long orderAbcNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<CustomerOrder>(new CommandDefinition(
            $"SELECT {OrderCols} FROM customer_order WHERE order_abc_num = :id", new { id = orderAbcNum }, cancellationToken: ct));
    }

    public Task<PagedResult<OrderItem>> GetOrderItemsAsync(int page, int pageSize, string? alloy, CancellationToken ct) =>
        PageAsync<OrderItem>(OrderItemCols, "order_item", "order_item_num",
            alloy is null ? null : "alloy2 = :alloy",
            new { alloy }, page, pageSize, ct);

    public async Task<OrderItem?> GetOrderItemAsync(long orderItemNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<OrderItem>(new CommandDefinition(
            $"SELECT {OrderItemCols} FROM order_item WHERE order_item_num = :id", new { id = orderItemNum }, cancellationToken: ct));
    }

    public Task<PagedResult<TestResult>> GetTestResultsAsync(int page, int pageSize, int? testType, CancellationToken ct) =>
        PageAsync<TestResult>(TestCols, "pst_test_result", "created_date DESC",
            testType is null ? null : "test_type = :testType",
            new { testType }, page, pageSize, ct);

    public async Task<IReadOnlyList<SheetSkid>> GetJobSheetSkidsAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<SheetSkid>(new CommandDefinition(
            $"SELECT {SheetSkidCols} FROM sheet_skid WHERE ab_job_num = :id ORDER BY sheet_skid_num",
            new { id = abJobNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public Task<PagedResult<SheetSkid>> GetSheetSkidsAsync(int page, int pageSize, CancellationToken ct) =>
        PageAsync<SheetSkid>(SheetSkidCols, "sheet_skid", "sheet_skid_num", null, new { }, page, pageSize, ct);

    public async Task<IReadOnlyList<ScrapSkid>> GetJobScrapAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // scrap_ab_job_num is char(18) in the legacy schema, so match the string form.
        var rows = await conn.QueryAsync<ScrapSkid>(new CommandDefinition(
            $"SELECT {ScrapSkidCols} FROM scrap_skid WHERE scrap_ab_job_num = :id ORDER BY scrap_skid_num",
            new { id = abJobNum.ToString() }, cancellationToken: ct));
        return rows.AsList();
    }

    public Task<PagedResult<ScrapSkid>> GetScrapSkidsAsync(int page, int pageSize, CancellationToken ct) =>
        PageAsync<ScrapSkid>(ScrapSkidCols, "scrap_skid", "scrap_skid_num", null, new { }, page, pageSize, ct);

    public Task<PagedResult<Customer>> GetCustomersAsync(int page, int pageSize, string? name, CancellationToken ct) =>
        PageAsync<Customer>(CustomerCols, "customer", "customer_id",
            name is null ? null : "customer_name LIKE :name",
            new { name = name is null ? null : $"%{name}%" }, page, pageSize, ct);

    public async Task<Customer?> GetCustomerAsync(long customerId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Customer>(new CommandDefinition(
            $"SELECT {CustomerCols} FROM customer WHERE customer_id = :id", new { id = customerId }, cancellationToken: ct));
    }

    public async Task<Customer> CreateCustomerAsync(CustomerWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);

        var id = await NextIdAsync(conn, tx, "customer", "customer_id", ct);

        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO customer (customer_id, customer_name, customer_short_name, enduser_name, shipto_customer_zip)
            VALUES (:id, :name, :shortName, :enduser, :zip)
            """,
            new { id, name = body.CustomerName, shortName = body.CustomerShortName, enduser = body.EnduserName, zip = body.ShiptoCustomerZip },
            transaction: tx, cancellationToken: ct));

        await tx.CommitAsync(ct);
        return (await GetCustomerAsync(id, ct))!;
    }

    public async Task<Customer?> UpdateCustomerAsync(long customerId, CustomerWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE customer SET customer_name = :name, customer_short_name = :shortName,
                   enduser_name = :enduser, shipto_customer_zip = :zip
            WHERE customer_id = :id
            """,
            new { name = body.CustomerName, shortName = body.CustomerShortName, enduser = body.EnduserName, zip = body.ShiptoCustomerZip, id = customerId },
            cancellationToken: ct));
        return n == 0 ? null : await GetCustomerAsync(customerId, ct);
    }

    public async Task<AbJob?> PatchJobAsync(long abJobNum, JobPatch patch, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // COALESCE(:new, col) keeps the existing value when the field is omitted.
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE ab_job SET
                job_status = COALESCE(:status, job_status),
                job_notes = COALESCE(:notes, job_notes),
                number_of_men_used = COALESCE(:men, number_of_men_used),
                time_date_finished = COALESCE(:finished, time_date_finished)
            WHERE ab_job_num = :id
            """,
            new { status = patch.JobStatus, notes = patch.JobNotes, men = patch.NumberOfMenUsed, finished = patch.TimeDateFinished, id = abJobNum },
            cancellationToken: ct));
        return n == 0 ? null : await GetJobAsync(abJobNum, ct);
    }

    public async Task<Coil?> PatchCoilAsync(long coilAbcNum, CoilPatch patch, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE coil SET
                coil_status = COALESCE(:status, coil_status),
                coil_location = COALESCE(:location, coil_location),
                coil_notes = COALESCE(:notes, coil_notes)
            WHERE coil_abc_num = :id
            """,
            new { status = patch.CoilStatus, location = patch.CoilLocation, notes = patch.CoilNotes, id = coilAbcNum },
            cancellationToken: ct));
        return n == 0 ? null : await GetCoilAsync(coilAbcNum, ct);
    }

    public async Task<CustomerOrder> CreateOrderAsync(CustomerOrderWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "customer_order", "order_abc_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO customer_order (order_abc_num, orig_customer_id, orig_customer_po, enduser_po, scrap_handing_type)
            VALUES (:id, :cust, :po, :epo, :scrap)
            """,
            new { id, cust = body.OrigCustomerId, po = body.OrigCustomerPo, epo = body.EnduserPo, scrap = body.ScrapHandingType },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetOrderAsync(id, ct))!;
    }

    public async Task<CustomerOrder?> UpdateOrderAsync(long orderAbcNum, CustomerOrderWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE customer_order SET orig_customer_id = :cust, orig_customer_po = :po,
                   enduser_po = :epo, scrap_handing_type = :scrap
            WHERE order_abc_num = :id
            """,
            new { cust = body.OrigCustomerId, po = body.OrigCustomerPo, epo = body.EnduserPo, scrap = body.ScrapHandingType, id = orderAbcNum },
            cancellationToken: ct));
        return n == 0 ? null : await GetOrderAsync(orderAbcNum, ct);
    }

    public async Task<OrderItem> CreateOrderItemAsync(OrderItemWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "order_item", "order_item_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO order_item (order_item_num, enduser_part_num, alloy2, temper, gauge, gauge_p, gauge_m,
                surface, flatness, sheet_type, material_end_use, order_item_desc, pieces_skid,
                theoretical_unit_wt, unit_price, item_created_dttm)
            VALUES (:id, :part, :alloy, :temper, :gauge, :gp, :gm, :surface, :flatness, :sheet, :enduse,
                :desc, :pieces, :tuw, :price, :created)
            """,
            new
            {
                id, part = body.EnduserPartNum, alloy = body.Alloy2, temper = body.Temper, gauge = body.Gauge,
                gp = body.GaugeP, gm = body.GaugeM, surface = body.Surface, flatness = body.Flatness,
                sheet = body.SheetType, enduse = body.MaterialEndUse, desc = body.OrderItemDesc,
                pieces = body.PiecesSkid, tuw = body.TheoreticalUnitWt, price = body.UnitPrice,
                created = (DateTime?)DateTime.UtcNow
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetOrderItemAsync(id, ct))!;
    }

    public async Task<OrderItem?> UpdateOrderItemAsync(long orderItemNum, OrderItemWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE order_item SET enduser_part_num = :part, alloy2 = :alloy, temper = :temper, gauge = :gauge,
                gauge_p = :gp, gauge_m = :gm, surface = :surface, flatness = :flatness, sheet_type = :sheet,
                material_end_use = :enduse, order_item_desc = :desc, pieces_skid = :pieces,
                theoretical_unit_wt = :tuw, unit_price = :price
            WHERE order_item_num = :id
            """,
            new
            {
                part = body.EnduserPartNum, alloy = body.Alloy2, temper = body.Temper, gauge = body.Gauge,
                gp = body.GaugeP, gm = body.GaugeM, surface = body.Surface, flatness = body.Flatness,
                sheet = body.SheetType, enduse = body.MaterialEndUse, desc = body.OrderItemDesc,
                pieces = body.PiecesSkid, tuw = body.TheoreticalUnitWt, price = body.UnitPrice, id = orderItemNum
            },
            cancellationToken: ct));
        return n == 0 ? null : await GetOrderItemAsync(orderItemNum, ct);
    }

    public async Task WriteAuditAsync(string source, bool success, string? notes, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // INSERT...SELECT (portable to Oracle, which disallows subqueries in VALUES)
        // assigns the next id atomically. Production should use a sequence.
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO opc_action_log (opc_log_id, time_stamp, source, success, notes)
            SELECT COALESCE(MAX(opc_log_id), 0) + 1, :ts, :source, :success, :notes FROM opc_action_log
            """,
            new { ts = (DateTime?)DateTime.UtcNow, source, success = success ? 1 : 0, notes },
            cancellationToken: ct));
    }

    public Task<PagedResult<AuditEntry>> GetAuditLogAsync(int page, int pageSize, string? source, CancellationToken ct) =>
        PageAsync<AuditEntry>(AuditCols, "opc_action_log", "opc_log_id DESC",
            source is null ? null : "source LIKE :source",
            new { source = source is null ? null : $"%{source}%" }, page, pageSize, ct);

    /// <summary>Next id via MAX+1, run inside the caller's transaction. Table/column
    /// are internal constants (not user input). Production Oracle should use a sequence.</summary>
    private static Task<long> NextIdAsync(DbConnection conn, DbTransaction tx, string table, string idColumn, CancellationToken ct) =>
        conn.ExecuteScalarAsync<long>(new CommandDefinition(
            $"SELECT COALESCE(MAX({idColumn}), 0) + 1 FROM {table}", transaction: tx, cancellationToken: ct));

    /// <summary>Merge two anonymous parameter objects into one Dapper parameter bag.</summary>
    private static DynamicParameters Merge(object a, object b)
    {
        var p = new DynamicParameters();
        p.AddDynamicParams(a);
        p.AddDynamicParams(b);
        return p;
    }
}
