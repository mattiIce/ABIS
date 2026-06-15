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

    /// <summary>Merge two anonymous parameter objects into one Dapper parameter bag.</summary>
    private static DynamicParameters Merge(object a, object b)
    {
        var p = new DynamicParameters();
        p.AddDynamicParams(a);
        p.AddDynamicParams(b);
        return p;
    }
}
