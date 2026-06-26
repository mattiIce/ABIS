using System.Data;
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
        order_item_num AS OrderItemNum, order_abc_num AS OrderAbcNum, enduser_part_num AS EnduserPartNum,
        alloy2 AS Alloy2, temper AS Temper, gauge AS Gauge, gauge_p AS GaugeP, gauge_m AS GaugeM,
        surface AS Surface, flatness AS Flatness, sheet_type AS SheetType, material_end_use AS MaterialEndUse,
        order_item_desc AS OrderItemDesc, pieces_skid AS PiecesSkid,
        theoretical_unit_wt AS TheoreticalUnitWt, unit_price AS UnitPrice, item_created_dttm AS ItemCreatedDttm
        """;

    private const string TestCols = """
        coil_abc_num AS CoilAbcNum, source_id AS SourceId,
        created_date AS CreatedDate, test_type AS TestType, position AS Position, yts_val AS YtsVal,
        uts_val AS UtsVal, elong_val AS ElongVal, n_val AS NVal, r_val AS RVal,
        thickness AS Thickness, width AS Width
        """;

    private const string TempTestCols = """
        coil_org_num AS CoilOrgNum,
        created_date AS CreatedDate, test_type AS TestType, position AS Position, yts AS Yts,
        uts AS Uts, elongation AS Elongation, n AS N, r AS R, thickness AS Thickness, width AS Width
        """;

    private const string PartialSkidCols = """
        ab_job_num AS AbJobNum, partial_skid_ab_job_num AS PartialSkidAbJobNum, sheet_skid_num AS SheetSkidNum,
        partial_sheet_net_wt AS PartialSheetNetWt, partial_skid_pieces AS PartialSkidPieces,
        partial_skid_location AS PartialSkidLocation, partial_skid_date AS PartialSkidDate
        """;

    private const string CustomerCols = """
        customer_id AS CustomerId, customer_full_name AS CustomerName, customer_short_name AS CustomerShortName,
        customer_city AS CustomerCity, customer_state AS CustomerState, customer_zip AS CustomerZip
        """;

    private const string SheetSkidCols = """
        sheet_skid_num AS SheetSkidNum, ab_job_num AS AbJobNum, sheet_skid_display_num AS SheetSkidDisplayNum,
        sheet_net_wt AS SheetNetWt, sheet_tare_wt AS SheetTareWt, skid_pieces AS SkidPieces, skid_date AS SkidDate,
        skid_location AS SkidLocation, skid_sheet_status AS SkidSheetStatus,
        skid_ticket_if_whed AS SkidTicketIfWhed, skid_from_if_whed AS SkidFromIfWhed
        """;

    private const string ScrapSkidCols = """
        scrap_skid_num AS ScrapSkidNum, scrap_ab_job_num AS ScrapAbJobNum, scrap_alloy2 AS ScrapAlloy2,
        scrap_temper AS ScrapTemper, scrap_type AS ScrapType, scrap_net_wt AS ScrapNetWt, scrap_tare_wt AS ScrapTareWt,
        scrap_location AS ScrapLocation, scrap_notes AS ScrapNotes, skid_scrap_status AS SkidScrapStatus, scrap_date AS ScrapDate
        """;

    private const string AuditCols = """
        opc_log_id AS OpcLogId, time_stamp AS TimeStamp, source AS Source, success AS Success, notes AS Notes
        """;

    private const string PartCols = """
        part_num_id AS PartNumId, customer_id AS CustomerId, enduser_id AS EnduserId,
        enduser_part_num AS EnduserPartNum, sheet_type AS SheetType, alloy AS Alloy,
        temper AS Temper, gauge AS Gauge, item_status AS ItemStatus
        """;

    private const string DieCols = """
        die_id AS DieId, die_name AS DieName, status AS Status, tool_num AS ToolNum,
        part_name AS PartName, gross_weight AS GrossWeight, location AS Location, description AS Description
        """;

    private const string ShipmentCols = """
        packing_list AS PackingList, bill_of_lading AS BillOfLading, carrier_id AS CarrierId,
        customer_id AS CustomerId, des_sh_cust_id AS DesShCustId, vehicle_id AS VehicleId,
        vehicle_status AS VehicleStatus, shipment_status AS ShipmentStatus,
        shipment_scheduled_date_time AS ShipmentScheduledDateTime, date_sent AS DateSent,
        shipment_actualed_date_time AS ShipmentActualedDateTime, shipment_notes AS ShipmentNotes
        """;

    private const string ReceivingBolCols = """
        receiving_bol_id AS ReceivingBolId, bol AS Bol, customer_id AS CustomerId,
        created_by AS CreatedBy, created_date AS CreatedDate, received_date AS ReceivedDate, status AS Status
        """;

    private const string ScanLogCols = """
        scan_id AS ScanId, scan_datetime AS ScanDatetime, ab_job_num AS AbJobNum,
        scan_station AS ScanStation, note AS Note
        """;

    // edi_file_raw (LONG RAW binary payload) is intentionally excluded.
    private const string EdiTransactionCols = """
        edi_file_id AS EdiFileId, duns_from AS DunsFrom, duns_to AS DunsTo,
        interchange_control_number AS InterchangeControlNumber, group_control_number AS GroupControlNumber,
        transaction_time AS TransactionTime, customer_sent_to AS CustomerSentTo, edi_file_name AS EdiFileName,
        fa_receive_status AS FaReceiveStatus, customer_id AS CustomerId, set_control_num AS SetControlNum,
        transaction_type_id AS TransactionTypeId, fa_received_time AS FaReceivedTime, fa_received_file_name AS FaReceivedFileName
        """;

    private const string EdiLogCols = """
        edi_log_timestamp AS EdiLogTimestamp, customer_id AS CustomerId, customer_edi_name AS CustomerEdiName,
        edi_log_contents AS EdiLogContents, edi_log_flag AS EdiLogFlag, edi_file_id AS EdiFileId,
        isa_seq AS IsaSeq, gs_seq AS GsSeq, edi_text AS EdiText
        """;

    private const string ContactCols = """
        contact_id AS ContactId, customer_id AS CustomerId, first_name AS FirstName, last_name AS LastName,
        department AS Department, city AS City, state AS State, phone1 AS Phone1, email1 AS Email1
        """;

    private const string SketchCols = """
        sketch_id AS SketchId, sketch_name AS SketchName, sketch_notes AS SketchNotes,
        sketch_sys_note AS SketchSysNote, sketch_status AS SketchStatus
        """;

    private const string CarrierCols = """
        carrier_id AS CarrierId, scac AS Scac, carrier_full_name AS CarrierFullName,
        carrier_type_code AS CarrierTypeCode, carrier_city AS CarrierCity, carrier_state AS CarrierState,
        carrier_phone_number AS CarrierPhoneNumber, status AS Status
        """;

    private const string ShiftCols = """
        shift_num AS ShiftNum, start_time AS StartTime, end_time AS EndTime, line_num AS LineNum,
        schedule_type AS ScheduleType, dt_total AS DtTotal, operator_initial AS OperatorInitial,
        shift_data_status AS ShiftDataStatus, note AS Note
        """;

    private const string DowntimeCols = """
        instance_num AS InstanceNum, ab_job_num AS AbJobNum, line_num AS LineNum,
        starting_time AS StartingTime, ending_time AS EndingTime, note AS Note, shift_num AS ShiftNum
        """;

    private const string MaintLogCols = """
        maint_log_id AS MaintLogId, maint_log_status AS MaintLogStatus, groupdepartment_id AS GroupDepartmentId,
        systemequipment AS SystemEquipment, subsystemequipment AS SubsystemEquipment, itemdevice AS ItemDevice,
        probdatetime AS ProbDateTime, prob_details AS ProbDetails, actions AS Actions, author AS Author,
        reportedby AS ReportedBy, entereddatetime AS EnteredDateTime, assignedto AS AssignedTo,
        completeddatetime AS CompletedDateTime, completedby AS CompletedBy, laborhours AS LaborHours, prob_cost AS ProbCost
        """;

    private async Task<DbConnection> OpenAsync(CancellationToken ct)
    {
        var conn = _factory.Create();
        await conn.OpenAsync(ct);
        return conn;
    }

    public async Task<bool> PingAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // Dialect-specific probe from the factory (Oracle requires a FROM clause:
        // a bare "SELECT 1" raises ORA-00923, so the Oracle branch uses FROM dual).
        return await conn.ExecuteScalarAsync<long>(new CommandDefinition(_factory.PingQuery, cancellationToken: ct)) == 1;
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
        var offset = (page - 1) * pageSize;
        // Pagination params are appended AFTER pageArgs so the overall source order
        // matches Oracle's positional binding (ODP.NET BindByName defaults to false);
        // SQLite binds by name, so order is irrelevant there. The two engines also use
        // different clauses (and so different params):
        //   Oracle (ROWNUM form): :maxRow (offset + pageSize) then :minRow (offset)
        //   SQLite:               :limit then :offset
        object pageParams = _factory.Dialect == SqlDialect.Oracle
            ? new { maxRow = offset + pageSize, minRow = offset }
            : new { limit = pageSize, offset };
        var args = Merge(pageArgs, pageParams);
        var rows = await conn.QueryAsync<T>(new CommandDefinition(sql, args, cancellationToken: ct));

        return new PagedResult<T>
        {
            Items = rows.AsList(),
            Page = page,
            PageSize = pageSize,
            TotalCount = total
        };
    }

    public Task<PagedResult<AbJob>> GetJobsAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct) =>
        PageAsync<AbJob>(JobCols, "ab_job", orderBy ?? "ab_job_num",
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

    public Task<PagedResult<Coil>> GetCoilsAsync(int page, int pageSize, int? status, string? alloy, string? location, long? customerId, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (status is not null) { conditions.Add("coil_status = :status"); p.Add("status", status); }
        if (alloy is not null) { conditions.Add("coil_alloy2 = :alloy"); p.Add("alloy", alloy); }
        if (location is not null) { conditions.Add("coil_location LIKE :location"); p.Add("location", $"%{location}%"); }
        if (customerId is not null) { conditions.Add("customer_id = :customerId"); p.Add("customerId", customerId); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<Coil>(CoilCols, "coil", orderBy ?? "coil_abc_num", where, p, page, pageSize, ct);
    }

    public async Task<IReadOnlyList<CoilProcessing>> GetCoilProcessingAsync(long coilAbcNum, CancellationToken ct)
    {
        const string sql = """
            SELECT pc.ab_job_num AS AbJobNum, pc.coil_abc_num AS CoilAbcNum, pc.process_coil_status AS ProcessCoilStatus,
                   pc.process_date AS ProcessDate, pc.process_end_wt AS ProcessEndWt, pc.process_quantity AS ProcessQuantity,
                   j.job_status AS JobStatus, j.line_num AS JobLineNum
            FROM process_coil pc
            LEFT JOIN ab_job j ON j.ab_job_num = pc.ab_job_num
            WHERE pc.coil_abc_num = :id
            ORDER BY pc.process_date
            """;
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<CoilProcessing>(new CommandDefinition(sql, new { id = coilAbcNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<CoilInventoryGroup>> GetCoilInventorySummaryAsync(string groupBy, CancellationToken ct)
    {
        // groupBy maps to a fixed column via an allowlist — never interpolated raw.
        var col = groupBy.ToLowerInvariant() switch
        {
            "alloy" => "coil_alloy2",
            "location" => "coil_location",
            _ => throw new ArgumentException($"Unsupported groupBy '{groupBy}'. Use 'alloy' or 'location'.", nameof(groupBy))
        };
        var sql = $"""
            SELECT {col} AS "Key", COUNT(*) AS Count, SUM(net_wt) AS TotalNetWt, SUM(net_wt_balance) AS TotalBalance
            FROM coil
            GROUP BY {col}
            ORDER BY {col}
            """;
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<CoilInventoryGroup>(new CommandDefinition(sql, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<Coil?> GetCoilAsync(long coilAbcNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Coil>(new CommandDefinition(
            $"SELECT {CoilCols} FROM coil WHERE coil_abc_num = :id", new { id = coilAbcNum }, cancellationToken: ct));
    }

    public Task<PagedResult<CustomerOrder>> GetOrdersAsync(int page, int pageSize, long? customerId, string? po, string? orderBy, CancellationToken ct)
    {
        // Build only the conditions/params actually used, so the count query
        // carries no unreferenced parameters (keeps Oracle positional binding happy).
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (customerId is not null) { conditions.Add("orig_customer_id = :customerId"); p.Add("customerId", customerId); }
        if (po is not null) { conditions.Add("orig_customer_po LIKE :po"); p.Add("po", $"%{po}%"); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<CustomerOrder>(OrderCols, "customer_order", orderBy ?? "order_abc_num", where, p, page, pageSize, ct);
    }

    public async Task<CustomerOrder?> GetOrderAsync(long orderAbcNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<CustomerOrder>(new CommandDefinition(
            $"SELECT {OrderCols} FROM customer_order WHERE order_abc_num = :id", new { id = orderAbcNum }, cancellationToken: ct));
    }

    public Task<PagedResult<OrderItem>> GetOrderItemsAsync(int page, int pageSize, string? alloy, string? orderBy, CancellationToken ct) =>
        PageAsync<OrderItem>(OrderItemCols, "order_item", orderBy ?? "order_item_num",
            alloy is null ? null : "alloy2 = :alloy",
            new { alloy }, page, pageSize, ct);

    public async Task<OrderItem?> GetOrderItemAsync(long orderAbcNum, long orderItemNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // Composite key: order_item_num is unique only within its order_abc_num.
        return await conn.QuerySingleOrDefaultAsync<OrderItem>(new CommandDefinition(
            $"SELECT {OrderItemCols} FROM order_item WHERE order_abc_num = :ord AND order_item_num = :id",
            new { ord = orderAbcNum, id = orderItemNum }, cancellationToken: ct));
    }

    public Task<PagedResult<TestResult>> GetTestResultsAsync(int page, int pageSize, int? testType, string? position, DateTime? from, DateTime? to, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (testType is not null) { conditions.Add("test_type = :testType"); p.Add("testType", testType); }
        if (position is not null) { conditions.Add("position = :position"); p.Add("position", position); }
        if (from is not null) { conditions.Add("created_date >= :fromDate"); p.Add("fromDate", from); }
        if (to is not null) { conditions.Add("created_date <= :toDate"); p.Add("toDate", to); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<TestResult>(TestCols, "pst_test_result", orderBy ?? "created_date DESC", where, p, page, pageSize, ct);
    }

    public Task<PagedResult<TempTestResult>> GetTempTestResultsAsync(int page, int pageSize, int? testType, string? position, DateTime? from, DateTime? to, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (testType is not null) { conditions.Add("test_type = :testType"); p.Add("testType", testType); }
        if (position is not null) { conditions.Add("position = :position"); p.Add("position", position); }
        if (from is not null) { conditions.Add("created_date >= :fromDate"); p.Add("fromDate", from); }
        if (to is not null) { conditions.Add("created_date <= :toDate"); p.Add("toDate", to); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<TempTestResult>(TempTestCols, "temp_test_result", orderBy ?? "created_date DESC", where, p, page, pageSize, ct);
    }

    public async Task<IReadOnlyList<SheetSkid>> GetJobSheetSkidsAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<SheetSkid>(new CommandDefinition(
            $"SELECT {SheetSkidCols} FROM sheet_skid WHERE ab_job_num = :id ORDER BY sheet_skid_num",
            new { id = abJobNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public Task<PagedResult<SheetSkid>> GetSheetSkidsAsync(int page, int pageSize, string? orderBy, CancellationToken ct) =>
        PageAsync<SheetSkid>(SheetSkidCols, "sheet_skid", orderBy ?? "sheet_skid_num", null, new { }, page, pageSize, ct);

    public async Task<IReadOnlyList<ScrapSkid>> GetJobScrapAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // scrap_ab_job_num is char(18) in the legacy schema, so match the string form.
        var rows = await conn.QueryAsync<ScrapSkid>(new CommandDefinition(
            $"SELECT {ScrapSkidCols} FROM scrap_skid WHERE scrap_ab_job_num = :id ORDER BY scrap_skid_num",
            new { id = abJobNum.ToString() }, cancellationToken: ct));
        return rows.AsList();
    }

    public Task<PagedResult<ScrapSkid>> GetScrapSkidsAsync(int page, int pageSize, string? orderBy, CancellationToken ct) =>
        PageAsync<ScrapSkid>(ScrapSkidCols, "scrap_skid", orderBy ?? "scrap_skid_num", null, new { }, page, pageSize, ct);

    public Task<PagedResult<PartialSkid>> GetPartialSkidsAsync(int page, int pageSize, string? orderBy, CancellationToken ct) =>
        PageAsync<PartialSkid>(PartialSkidCols, "process_partial_skid", orderBy ?? "sheet_skid_num", null, new { }, page, pageSize, ct);

    public async Task<IReadOnlyList<PartialSkid>> GetJobPartialSkidsAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<PartialSkid>(new CommandDefinition(
            $"SELECT {PartialSkidCols} FROM process_partial_skid WHERE ab_job_num = :id ORDER BY sheet_skid_num",
            new { id = abJobNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public Task<PagedResult<Customer>> GetCustomersAsync(int page, int pageSize, string? name, string? orderBy, CancellationToken ct) =>
        PageAsync<Customer>(CustomerCols, "customer", orderBy ?? "customer_id",
            name is null ? null : "customer_full_name LIKE :name",
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
            INSERT INTO customer (customer_id, customer_full_name, customer_short_name, customer_city, customer_state, customer_zip)
            VALUES (:id, :name, :shortName, :city, :state, :zip)
            """,
            new { id, name = body.CustomerName, shortName = body.CustomerShortName, city = body.CustomerCity, state = body.CustomerState, zip = body.CustomerZip },
            transaction: tx, cancellationToken: ct));

        await tx.CommitAsync(ct);
        return (await GetCustomerAsync(id, ct))!;
    }

    public async Task<Customer?> UpdateCustomerAsync(long customerId, CustomerWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE customer SET customer_full_name = :name, customer_short_name = :shortName,
                   customer_city = :city, customer_state = :state, customer_zip = :zip
            WHERE customer_id = :id
            """,
            new { name = body.CustomerName, shortName = body.CustomerShortName, city = body.CustomerCity, state = body.CustomerState, zip = body.CustomerZip, id = customerId },
            cancellationToken: ct));
        return n == 0 ? null : await GetCustomerAsync(customerId, ct);
    }

    public async Task<AbJob?> PatchJobAsync(long abJobNum, JobPatch patch, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // COALESCE(:new, col) keeps the existing value when the field is omitted.
        // Nullable non-string params must carry an explicit DbType: ODP.NET binds a
        // null as CHAR otherwise, and COALESCE(charNull, numericOrDateCol) raises
        // ORA-00932 on Oracle (SQLite is typeless, so CI never sees it).
        var p = new DynamicParameters();
        p.Add("status", patch.JobStatus, DbType.Int32);
        p.Add("notes", patch.JobNotes);
        p.Add("men", patch.NumberOfMenUsed, DbType.Int32);
        p.Add("finished", patch.TimeDateFinished, DbType.DateTime);
        p.Add("id", abJobNum);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE ab_job SET
                job_status = COALESCE(:status, job_status),
                job_notes = COALESCE(:notes, job_notes),
                number_of_men_used = COALESCE(:men, number_of_men_used),
                time_date_finished = COALESCE(:finished, time_date_finished)
            WHERE ab_job_num = :id
            """,
            p, cancellationToken: ct));
        return n == 0 ? null : await GetJobAsync(abJobNum, ct);
    }

    public async Task<Coil?> PatchCoilAsync(long coilAbcNum, CoilPatch patch, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // :status is nullable NUMBER — type it explicitly (see PatchJobAsync) so a
        // null binds as NUMBER, not CHAR, avoiding ORA-00932 in the COALESCE.
        var p = new DynamicParameters();
        p.Add("status", patch.CoilStatus, DbType.Int32);
        p.Add("location", patch.CoilLocation);
        p.Add("notes", patch.CoilNotes);
        p.Add("id", coilAbcNum);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE coil SET
                coil_status = COALESCE(:status, coil_status),
                coil_location = COALESCE(:location, coil_location),
                coil_notes = COALESCE(:notes, coil_notes)
            WHERE coil_abc_num = :id
            """,
            p, cancellationToken: ct));
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

    public async Task<OrderItem> CreateOrderItemAsync(long orderAbcNum, OrderItemWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        // order_item_num is a per-order line number (no sequence): MAX within the order + 1.
        var id = await NextOrderItemNumAsync(conn, tx, orderAbcNum, ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO order_item (order_item_num, order_abc_num, enduser_part_num, alloy2, temper, gauge, gauge_p, gauge_m,
                surface, flatness, sheet_type, material_end_use, order_item_desc, pieces_skid,
                theoretical_unit_wt, unit_price, item_created_dttm)
            VALUES (:id, :ord, :part, :alloy, :temper, :gauge, :gp, :gm, :surface, :flatness, :sheet, :enduse,
                :idesc, :pieces, :tuw, :price, :created)
            """,
            new
            {
                id, ord = orderAbcNum, part = body.EnduserPartNum, alloy = body.Alloy2, temper = body.Temper, gauge = body.Gauge,
                gp = body.GaugeP, gm = body.GaugeM, surface = body.Surface, flatness = body.Flatness,
                sheet = body.SheetType, enduse = body.MaterialEndUse, idesc = body.OrderItemDesc,
                pieces = body.PiecesSkid, tuw = body.TheoreticalUnitWt, price = body.UnitPrice,
                created = (DateTime?)DateTime.UtcNow
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetOrderItemAsync(orderAbcNum, id, ct))!;
    }

    public async Task<OrderItem?> UpdateOrderItemAsync(long orderAbcNum, long orderItemNum, OrderItemWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // order_abc_num + order_item_num are the key, so they're matched in WHERE, never SET.
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE order_item SET enduser_part_num = :part, alloy2 = :alloy, temper = :temper,
                gauge = :gauge, gauge_p = :gp, gauge_m = :gm, surface = :surface, flatness = :flatness,
                sheet_type = :sheet, material_end_use = :enduse, order_item_desc = :idesc, pieces_skid = :pieces,
                theoretical_unit_wt = :tuw, unit_price = :price
            WHERE order_abc_num = :ord AND order_item_num = :id
            """,
            new
            {
                part = body.EnduserPartNum, alloy = body.Alloy2, temper = body.Temper, gauge = body.Gauge,
                gp = body.GaugeP, gm = body.GaugeM, surface = body.Surface, flatness = body.Flatness,
                sheet = body.SheetType, enduse = body.MaterialEndUse, idesc = body.OrderItemDesc,
                pieces = body.PiecesSkid, tuw = body.TheoreticalUnitWt, price = body.UnitPrice,
                ord = orderAbcNum, id = orderItemNum
            },
            cancellationToken: ct));
        return n == 0 ? null : await GetOrderItemAsync(orderAbcNum, orderItemNum, ct);
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

    public Task<PagedResult<AuditEntry>> GetAuditLogAsync(int page, int pageSize, string? source, string? orderBy, CancellationToken ct) =>
        PageAsync<AuditEntry>(AuditCols, "opc_action_log", orderBy ?? "opc_log_id DESC",
            source is null ? null : "source LIKE :source",
            new { source = source is null ? null : $"%{source}%" }, page, pageSize, ct);

    public async Task<AbJob> CreateJobAsync(JobWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "ab_job", "ab_job_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO ab_job (ab_job_num, order_abc_num, order_item_num, line_num, job_status, material_yield,
                number_of_men_used, sketch_id, create_date, due_date, job_notes, sketch_job_note)
            VALUES (:id, :ord, :item, :line, :status, :matYield, :men, :sketch, :created, :due, :notes, :sketchNote)
            """,
            new
            {
                id, ord = body.OrderAbcNum, item = body.OrderItemNum, line = body.LineNum, status = body.JobStatus,
                matYield = body.MaterialYield, men = body.NumberOfMenUsed, sketch = body.SketchId,
                created = (DateTime?)DateTime.UtcNow, due = body.DueDate, notes = body.JobNotes, sketchNote = body.SketchJobNote
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetJobAsync(id, ct))!;
    }

    public async Task<Coil> CreateCoilAsync(CoilWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "coil", "coil_abc_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO coil (coil_abc_num, coil_alloy2, coil_temper, coil_gauge, coil_width, coil_line_num,
                coil_location, coil_mid_num, coil_org_num, coil_status, coil_notes, coil_entry_date,
                customer_id, coil_from_cust_id, date_received, icra, lot_num, net_wt, net_wt_balance, pieces_per_case)
            VALUES (:id, :alloy, :temper, :gauge, :width, :line, :loc, :mid, :org, :status, :notes, :entry,
                :cust, :fromCust, :received, :icra, :lot, :net, :bal, :pieces)
            """,
            new
            {
                id, alloy = body.CoilAlloy2, temper = body.CoilTemper, gauge = body.CoilGauge, width = body.CoilWidth,
                line = body.CoilLineNum, loc = body.CoilLocation, mid = body.CoilMidNum, org = body.CoilOrgNum,
                status = body.CoilStatus, notes = body.CoilNotes, entry = (DateTime?)DateTime.UtcNow,
                cust = body.CustomerId, fromCust = body.CoilFromCustId, received = (DateTime?)DateTime.UtcNow,
                icra = body.Icra, lot = body.LotNum, net = body.NetWt, bal = body.NetWtBalance, pieces = body.PiecesPerCase
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetCoilAsync(id, ct))!;
    }

    public async Task<SheetSkid?> GetSheetSkidAsync(long sheetSkidNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<SheetSkid>(new CommandDefinition(
            $"SELECT {SheetSkidCols} FROM sheet_skid WHERE sheet_skid_num = :id", new { id = sheetSkidNum }, cancellationToken: ct));
    }

    public async Task<SheetSkid> CreateSheetSkidAsync(SheetSkidWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "sheet_skid", "sheet_skid_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO sheet_skid (sheet_skid_num, ab_job_num, sheet_skid_display_num, sheet_net_wt,
                sheet_tare_wt, skid_pieces, skid_date)
            VALUES (:id, :job, :display, :net, :tare, :pieces, :dval)
            """,
            new
            {
                id, job = body.AbJobNum, display = body.SheetSkidDisplayNum, net = body.SheetNetWt,
                tare = body.SheetTareWt, pieces = body.SkidPieces, dval = (DateTime?)DateTime.UtcNow
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetSheetSkidAsync(id, ct))!;
    }

    public async Task<IReadOnlyList<ProductionSummaryRow>> GetProductionSummaryAsync(DateTime? from, DateTime? to, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // Per-line production roll-up. The date filter lives in the LEFT JOIN ON so
        // idle lines still appear (0 jobs). Processed weight via a correlated subquery
        // to avoid the job×coil fan-out inflating COUNT/AVG. Portable Oracle + SQLite.
        var p = new DynamicParameters();
        var dateFilter = "";
        if (from is not null) { dateFilter += " AND j.time_date_started >= :dfrom"; p.Add("dfrom", from, DbType.DateTime); }
        if (to is not null) { dateFilter += " AND j.time_date_started < :dto"; p.Add("dto", to, DbType.DateTime); }
        var rows = await conn.QueryAsync<ProductionSummaryRow>(new CommandDefinition(
            $"""
            SELECT l.line_num AS LineNum, l.line_desc AS LineDesc,
                   COUNT(j.ab_job_num) AS JobCount,
                   AVG(j.material_yield) AS AvgYield,
                   COALESCE(SUM((SELECT SUM(pc.process_end_wt) FROM process_coil pc WHERE pc.ab_job_num = j.ab_job_num)), 0.0) AS ProcessedWt
            FROM line l
            LEFT JOIN ab_job j ON j.line_num = l.line_num{dateFilter}
            GROUP BY l.line_num, l.line_desc
            ORDER BY l.line_num
            """, p, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<OpcLog>> GetOpcLogsAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<OpcLog>(new CommandDefinition(
            "SELECT opc_log_id AS OpcLogId, title AS Title, created_date AS CreatedDate FROM opc_log ORDER BY opc_log_id DESC",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<OpcLogDetail>> GetOpcLogDetailsAsync(long opcLogId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<OpcLogDetail>(new CommandDefinition(
            """
            SELECT opc_log_id AS OpcLogId, item_name AS ItemName, device_name AS DeviceName,
                   remote_host AS RemoteHost, value AS Value, quality AS Quality,
                   time_stamp AS TimeStamp, description AS Description
            FROM opc_log_details WHERE opc_log_id = :id ORDER BY item_name
            """, new { id = opcLogId }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<string>> GetOpcItemsAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // The distinct OPC items seen — the real tag catalog (informs the edge Edge:Opc:Tags).
        var rows = await conn.QueryAsync<string>(new CommandDefinition(
            "SELECT DISTINCT item_name FROM opc_log_details WHERE item_name IS NOT NULL ORDER BY item_name",
            cancellationToken: ct));
        return rows.AsList();
    }

    // ---- Sales / quotes (legacy w_sales_main, w_new_quote, w_edit_quote) ----

    // The pending-sales / quote list (legacy d_pending_sales_list): sales_quote joined to
    // its customer and contact, with the most-recent win probability. The latest probability
    // is a correlated scalar subquery keyed on the max review_date (portable to Oracle and
    // SQLite — no LIMIT/ROWNUM); MAX wraps the value so it stays single-valued on a date tie.
    public async Task<IReadOnlyList<SalesQuoteListRow>> GetSalesQuotesAsync(string? search, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var like = string.IsNullOrWhiteSpace(search) ? null : $"%{search.Trim()}%";
        var rows = await conn.QueryAsync<SalesQuoteListRow>(new CommandDefinition(
            """
            SELECT q.quote_id AS QuoteId, q.quote_revision_id AS QuoteRevisionId, q.customer_id AS CustomerId,
                   c.customer_short_name AS CustomerShortName, q.contact_id AS ContactId,
                   cc.first_name AS ContactFirstName, cc.last_name AS ContactLastName,
                   q.end_use AS EndUse, q.part_shape AS PartShape, q.alloy AS Alloy, q.temper AS Temper,
                   q.gauge AS Gauge, q.width AS Width, q.length AS Length, q.total_lb_processed AS TotalLbProcessed,
                   q.created_date AS CreatedDate, q.valid_date AS ValidDate,
                   (SELECT MAX(p.sales_probability) FROM sales_probability p
                      WHERE p.quote_id = q.quote_id AND p.quote_revision_id = q.quote_revision_id
                        AND p.review_date = (SELECT MAX(p2.review_date) FROM sales_probability p2
                                               WHERE p2.quote_id = q.quote_id AND p2.quote_revision_id = q.quote_revision_id)
                   ) AS LatestProbability
            FROM sales_quote q
            LEFT JOIN customer c ON c.customer_id = q.customer_id
            LEFT JOIN customer_contact cc ON cc.contact_id = q.contact_id
            WHERE (:like IS NULL
                   OR c.customer_short_name LIKE :like OR q.end_use LIKE :like OR q.alloy LIKE :like)
            ORDER BY q.created_date DESC, q.quote_id, q.quote_revision_id
            """, new { like }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<SalesQuote?> GetSalesQuoteAsync(long quoteId, long revisionId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<SalesQuote>(new CommandDefinition(
            """
            SELECT q.quote_id AS QuoteId, q.quote_revision_id AS QuoteRevisionId, q.customer_id AS CustomerId,
                   c.customer_short_name AS CustomerShortName, q.contact_id AS ContactId,
                   cc.first_name AS ContactFirstName, cc.last_name AS ContactLastName, q.enduser_id AS EnduserId,
                   q.end_use AS EndUse, q.part_shape AS PartShape, q.material AS Material, q.alloy AS Alloy, q.temper AS Temper,
                   q.gauge AS Gauge, q.width AS Width, q.length AS Length, q.line_num AS LineNum, q.line_speed AS LineSpeed,
                   q.num_of_coil AS NumOfCoil, q.num_of_skid AS NumOfSkid, q.total_lb_processed AS TotalLbProcessed,
                   q.total_rev_per_hr AS TotalRevPerHr, q.variable_cost AS VariableCost, q.fixed_cost AS FixedCost,
                   q.reg_process_charge AS RegProcessCharge, q.ros AS Ros, q.quote_notes AS QuoteNotes,
                   q.approval_sales AS ApprovalSales, q.approval_vp AS ApprovalVp, q.approval_ceo AS ApprovalCeo,
                   q.pass_on_quote AS PassOnQuote, q.created_date AS CreatedDate, q.valid_date AS ValidDate
            FROM sales_quote q
            LEFT JOIN customer c ON c.customer_id = q.customer_id
            LEFT JOIN customer_contact cc ON cc.contact_id = q.contact_id
            WHERE q.quote_id = :quote AND q.quote_revision_id = :rev
            """, new { quote = quoteId, rev = revisionId }, cancellationToken: ct));
    }

    public async Task<IReadOnlyList<SalesContact>> GetSalesContactsAsync(long? customerId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<SalesContact>(new CommandDefinition(
            """
            SELECT contact_id AS ContactId, customer_id AS CustomerId, first_name AS FirstName, last_name AS LastName,
                   department AS Department, city AS City, state AS State, phone1 AS Phone1, email1 AS Email1
            FROM customer_contact
            WHERE (:cust IS NULL OR customer_id = :cust)
            ORDER BY last_name, first_name
            """, new { cust = customerId }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<SalesReminder>> GetSalesRemindersAsync(long quoteId, long revisionId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<SalesReminder>(new CommandDefinition(
            """
            SELECT event_id AS EventId, quote_id AS QuoteId, quote_revision_id AS QuoteRevisionId,
                   event_date AS EventDate, event_notes AS EventNotes, event_status AS EventStatus, user_id AS UserId
            FROM sales_reminder
            WHERE quote_id = :quote AND quote_revision_id = :rev
            ORDER BY event_date
            """, new { quote = quoteId, rev = revisionId }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<SalesReminder> CreateSalesReminderAsync(long quoteId, long revisionId, SalesReminderWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "sales_reminder", "event_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO sales_reminder (event_id, quote_id, quote_revision_id, event_date, event_notes, event_status, user_id)
            VALUES (:id, :quote, :rev, :date, :notes, :status, :user)
            """,
            new
            {
                id, quote = quoteId, rev = revisionId, date = body.EventDate ?? DateTime.UtcNow,
                notes = body.EventNotes, status = body.EventStatus ?? "OPEN", user = body.UserId
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetSalesRemindersAsync(quoteId, revisionId, ct)).First(r => r.EventId == id);
    }

    public async Task<IReadOnlyList<SalesProbability>> GetSalesProbabilityAsync(long quoteId, long revisionId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<SalesProbability>(new CommandDefinition(
            """
            SELECT probability_id AS ProbabilityId, quote_id AS QuoteId, quote_revision_id AS QuoteRevisionId,
                   review_date AS ReviewDate, sales_probability AS SalesProbabilityPercent, probability_note AS ProbabilityNote
            FROM sales_probability
            WHERE quote_id = :quote AND quote_revision_id = :rev
            ORDER BY review_date
            """, new { quote = quoteId, rev = revisionId }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<SalesProbability> CreateSalesProbabilityAsync(long quoteId, long revisionId, SalesProbabilityWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "sales_probability", "probability_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO sales_probability (probability_id, quote_id, quote_revision_id, review_date, sales_probability, probability_note)
            VALUES (:id, :quote, :rev, :date, :pct, :note)
            """,
            new
            {
                id, quote = quoteId, rev = revisionId, date = body.ReviewDate ?? DateTime.UtcNow,
                pct = body.SalesProbabilityPercent, note = body.ProbabilityNote
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetSalesProbabilityAsync(quoteId, revisionId, ct)).First(r => r.ProbabilityId == id);
    }

    // ---- Coil ownership transfer (legacy w_coil_ownership_transfer, silverdome4) ----

    // The transfer ledger (legacy d_coil_ownership_transfer): each certificate joined to its
    // orig/new customer short names and the original coil's metal details.
    public async Task<IReadOnlyList<CoilOwnershipTransfer>> GetCoilOwnershipTransfersAsync(long? customerId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<CoilOwnershipTransfer>(new CommandDefinition(
            """
            SELECT t.certificate_num AS CertificateNum, t.coil_abc_num_orig AS CoilAbcNumOrig,
                   t.coil_abc_num_new AS CoilAbcNumNew, t.coil_org_num AS CoilOrgNum,
                   t.customer_id_orig AS CustomerIdOrig, co.customer_short_name AS CustomerShortNameOrig,
                   t.customer_id_new AS CustomerIdNew, cn.customer_short_name AS CustomerShortNameNew,
                   t.transfer_datetime AS TransferDatetime, t.transfer_performed_by AS TransferPerformedBy,
                   t.authorization_note AS AuthorizationNote, t.notes AS Notes,
                   c.net_wt AS NetWt, c.net_wt_balance AS NetWtBalance, c.coil_alloy2 AS CoilAlloy2,
                   c.coil_temper AS CoilTemper, c.coil_gauge AS CoilGauge, c.coil_width AS CoilWidth, c.lot_num AS LotNum
            FROM coil_ownership_transfer t
            LEFT JOIN customer co ON co.customer_id = t.customer_id_orig
            LEFT JOIN customer cn ON cn.customer_id = t.customer_id_new
            LEFT JOIN coil c ON c.coil_abc_num = t.coil_abc_num_orig
            WHERE (:cust IS NULL OR t.customer_id_orig = :cust OR t.customer_id_new = :cust)
            ORDER BY t.transfer_datetime DESC, t.certificate_num DESC
            """, new { cust = customerId }, cancellationToken: ct));
        return rows.AsList();
    }

    // The printable certificate (legacy d_coil_ownership_transfer_certificate): full orig/new
    // customer addresses + the coil's metal details for one certificate.
    public async Task<CoilOwnershipTransferCertificate?> GetCoilOwnershipTransferCertificateAsync(long certificateNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<CoilOwnershipTransferCertificate>(new CommandDefinition(
            """
            SELECT t.certificate_num AS CertificateNum, t.coil_abc_num_orig AS CoilAbcNumOrig,
                   t.coil_abc_num_new AS CoilAbcNumNew, t.coil_org_num AS CoilOrgNum,
                   t.transfer_datetime AS TransferDatetime, t.transfer_performed_by AS TransferPerformedBy,
                   t.authorization_note AS AuthorizationNote, t.notes AS Notes,
                   t.customer_id_orig AS CustomerIdOrig, co.customer_full_name AS CustomerFullNameOrig,
                   co.customer_short_name AS CustomerShortNameOrig, co.customer_city AS CustomerCityOrig,
                   co.customer_state AS CustomerStateOrig, co.customer_zip AS CustomerZipOrig,
                   t.customer_id_new AS CustomerIdNew, cn.customer_full_name AS CustomerFullNameNew,
                   cn.customer_short_name AS CustomerShortNameNew, cn.customer_city AS CustomerCityNew,
                   cn.customer_state AS CustomerStateNew, cn.customer_zip AS CustomerZipNew,
                   c.net_wt AS NetWt, c.net_wt_balance AS NetWtBalance, c.coil_alloy2 AS CoilAlloy2,
                   c.coil_temper AS CoilTemper, c.coil_gauge AS CoilGauge, c.coil_width AS CoilWidth, c.lot_num AS LotNum
            FROM coil_ownership_transfer t
            JOIN customer co ON co.customer_id = t.customer_id_orig
            JOIN customer cn ON cn.customer_id = t.customer_id_new
            JOIN coil c ON c.coil_abc_num = t.coil_abc_num_orig
            WHERE t.certificate_num = :cert
            """, new { cert = certificateNum }, cancellationToken: ct));
    }

    // The coil picker (legacy d_ownership_transfer_coil_list): coils that can be transferred,
    // with their current owner. Optional customer scope + a text search on org-num / lot / notes.
    public async Task<IReadOnlyList<TransferableCoil>> GetTransferableCoilsAsync(long? customerId, string? search, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var like = string.IsNullOrWhiteSpace(search) ? null : $"%{search.Trim()}%";
        var rows = await conn.QueryAsync<TransferableCoil>(new CommandDefinition(
            """
            SELECT c.coil_abc_num AS CoilAbcNum, c.customer_id AS CustomerId, cu.customer_short_name AS CustomerShortName,
                   c.coil_org_num AS CoilOrgNum, c.lot_num AS LotNum, c.coil_status AS CoilStatus,
                   c.coil_alloy2 AS CoilAlloy2, c.coil_temper AS CoilTemper, c.coil_gauge AS CoilGauge,
                   c.coil_width AS CoilWidth, c.net_wt_balance AS NetWtBalance, c.coil_notes AS CoilNotes
            FROM coil c
            LEFT JOIN customer cu ON cu.customer_id = c.customer_id
            WHERE (:cust IS NULL OR c.customer_id = :cust)
              AND (:like IS NULL OR c.coil_org_num LIKE :like OR c.lot_num LIKE :like OR c.coil_notes LIKE :like)
            ORDER BY c.coil_abc_num
            """, new { cust = customerId, like }, cancellationToken: ct));
        return rows.AsList();
    }

    // Record a transfer: read the coil's current owner (orig), insert the certificate, and
    // re-point the coil's customer_id to the new owner (its prior owner kept in
    // coil_from_cust_id). Returns null if the coil does not exist.
    public async Task<CoilOwnershipTransfer?> CreateCoilOwnershipTransferAsync(CoilOwnershipTransferWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);

        var coil = await conn.QuerySingleOrDefaultAsync<CoilOwnerRow>(new CommandDefinition(
            "SELECT customer_id AS CurrentCustomerId, coil_org_num AS CoilOrgNum FROM coil WHERE coil_abc_num = :id",
            new { id = body.CoilAbcNumOrig }, transaction: tx, cancellationToken: ct));
        if (coil is null) return null; // the coil to transfer does not exist

        var cert = await NextIdAsync(conn, tx, "coil_ownership_transfer", "certificate_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO coil_ownership_transfer (certificate_num, coil_abc_num_orig, coil_abc_num_new,
                coil_org_num, customer_id_orig, customer_id_new, transfer_datetime, transfer_performed_by,
                authorization_note, notes)
            VALUES (:cert, :coilOrig, :coilNew, :org, :custOrig, :custNew, :dt, :perf, :auth, :note)
            """,
            new
            {
                cert, coilOrig = body.CoilAbcNumOrig, coilNew = body.CoilAbcNumNew, org = coil.CoilOrgNum,
                custOrig = coil.CurrentCustomerId, custNew = body.CustomerIdNew, dt = (DateTime?)DateTime.UtcNow,
                perf = body.TransferPerformedBy, auth = body.AuthorizationNote, note = body.Notes
            },
            transaction: tx, cancellationToken: ct));

        // Re-point ownership; SQLite and Oracle both evaluate the RHS with pre-update values,
        // so coil_from_cust_id captures the prior owner in the same statement.
        await conn.ExecuteAsync(new CommandDefinition(
            "UPDATE coil SET coil_from_cust_id = customer_id, customer_id = :custNew WHERE coil_abc_num = :id",
            new { custNew = body.CustomerIdNew, id = body.CoilAbcNumOrig }, transaction: tx, cancellationToken: ct));

        await tx.CommitAsync(ct);
        return (await GetCoilOwnershipTransfersAsync(null, ct)).First(t => t.CertificateNum == cert);
    }

    // The current owner + org-num of a coil being transferred (null row => coil missing).
    private sealed class CoilOwnerRow
    {
        public long? CurrentCustomerId { get; set; }
        public string? CoilOrgNum { get; set; }
    }

    public async Task<IReadOnlyList<ScrapType>> GetScrapTypesAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<ScrapType>(new CommandDefinition(
            "SELECT scrap_type_id AS ScrapTypeId, scrap_code AS ScrapCode, scrap_defect AS ScrapDefect FROM scrap_type ORDER BY scrap_type_id",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<ProductType>> GetProductTypesAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<ProductType>(new CommandDefinition(
            "SELECT product_type_id AS ProductTypeId, product_type AS ProductTypeName FROM product_type ORDER BY product_type_id",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<RecoveryCustomer>> GetRecoveryCustomersAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<RecoveryCustomer>(new CommandDefinition(
            """
            SELECT customer_id AS CustomerId, customer_name AS CustomerName,
                   all_products AS AllProducts, auto_only AS AutoOnly, comm_only AS CommOnly
            FROM recovery_report_customer ORDER BY customer_name
            """, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<CustomerDefect>> GetCustomerDefectsAsync(long customerId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // The scrap/defect types a customer tracks (legacy d_recovery_customer_defect_list).
        var rows = await conn.QueryAsync<CustomerDefect>(new CommandDefinition(
            """
            SELECT c.customer_id AS CustomerId, c.scrap_type_id AS ScrapTypeId,
                   s.scrap_code AS ScrapCode, s.scrap_defect AS ScrapDefect,
                   c.abc_or_mill AS AbcOrMill, c.autoparts AS Autoparts, c.non_autoparts AS NonAutoparts
            FROM cust_scrap_type_needed c JOIN scrap_type s ON s.scrap_type_id = c.scrap_type_id
            WHERE c.customer_id = :id
            ORDER BY s.scrap_code
            """, new { id = customerId }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<InvoiceCoil>> GetInvoiceCoilsAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // Faithful to the legacy d_rej_reband_coil_list_for_invoice: rejected (3) and
        // rebanded (7) coils on a job — the billing-relevant coils. coil ⋈ process_coil.
        var rows = await conn.QueryAsync<InvoiceCoil>(new CommandDefinition(
            """
            SELECT pc.ab_job_num AS AbJobNum, pc.coil_abc_num AS CoilAbcNum,
                   c.coil_org_num AS CoilOrgNum, c.coil_mid_num AS CoilMidNum, c.lot_num AS LotNum,
                   c.coil_gauge AS CoilGauge, c.net_wt AS NetWt, c.net_wt_balance AS NetWtBalance,
                   pc.process_end_wt AS ProcessEndWt, pc.process_quantity AS ProcessQuantity,
                   pc.process_date AS ProcessDate, c.coil_status AS CoilStatus,
                   pc.process_coil_status AS ProcessCoilStatus
            FROM coil c JOIN process_coil pc ON c.coil_abc_num = pc.coil_abc_num
            WHERE pc.process_coil_status IN (3, 7) AND pc.ab_job_num = :id
            ORDER BY pc.coil_abc_num DESC
            """, new { id = abJobNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<SheetSkid?> UpdateSheetSkidWarehouseAsync(long sheetSkidNum, SheetSkidWarehousePatch patch, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // Partial warehouse update (location / ticket / status). Explicit DbType on
        // the int null avoids the ORA-00932 COALESCE(charNull, numeric) trap.
        var p = new DynamicParameters();
        p.Add("loc", patch.SkidLocation);
        p.Add("ticket", patch.SkidTicketIfWhed);
        p.Add("status", patch.SkidSheetStatus, DbType.Int32);
        p.Add("id", sheetSkidNum);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE sheet_skid SET
                skid_location = COALESCE(:loc, skid_location),
                skid_ticket_if_whed = COALESCE(:ticket, skid_ticket_if_whed),
                skid_sheet_status = COALESCE(:status, skid_sheet_status)
            WHERE sheet_skid_num = :id
            """,
            p, cancellationToken: ct));
        return n == 0 ? null : await GetSheetSkidAsync(sheetSkidNum, ct);
    }

    public async Task<ScrapSkid?> GetScrapSkidAsync(long scrapSkidNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<ScrapSkid>(new CommandDefinition(
            $"SELECT {ScrapSkidCols} FROM scrap_skid WHERE scrap_skid_num = :id", new { id = scrapSkidNum }, cancellationToken: ct));
    }

    public async Task<ScrapSkid> CreateScrapSkidAsync(ScrapSkidWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "scrap_skid", "scrap_skid_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO scrap_skid (scrap_skid_num, scrap_ab_job_num, scrap_alloy2, scrap_temper, scrap_type,
                scrap_net_wt, scrap_tare_wt, scrap_location, scrap_notes, skid_scrap_status, scrap_date)
            VALUES (:id, :job, :alloy, :temper, :type, :net, :tare, :loc, :notes, :status, :dval)
            """,
            new
            {
                id, job = body.ScrapAbJobNum, alloy = body.ScrapAlloy2, temper = body.ScrapTemper, type = body.ScrapType,
                net = body.ScrapNetWt, tare = body.ScrapTareWt, loc = body.ScrapLocation, notes = body.ScrapNotes,
                status = body.SkidScrapStatus, dval = (DateTime?)DateTime.UtcNow
            },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetScrapSkidAsync(id, ct))!;
    }

    public async Task<IReadOnlyList<OrderItem>> GetOrderItemsByOrderAsync(long orderAbcNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<OrderItem>(new CommandDefinition(
            $"SELECT {OrderItemCols} FROM order_item WHERE order_abc_num = :id ORDER BY order_item_num",
            new { id = orderAbcNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<OrderDetail?> GetOrderDetailAsync(long orderAbcNum, CancellationToken ct)
    {
        var order = await GetOrderAsync(orderAbcNum, ct);
        if (order is null) return null;
        var customer = order.OrigCustomerId is null ? null : await GetCustomerAsync(order.OrigCustomerId.Value, ct);
        var items = await GetOrderItemsByOrderAsync(orderAbcNum, ct);
        return new OrderDetail { Order = order, Customer = customer, Items = items };
    }

    public async Task<OrderDetail> CreateOrderWithItemsAsync(OrderCreateWithItems body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);

        var orderId = await NextIdAsync(conn, tx, "customer_order", "order_abc_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO customer_order (order_abc_num, orig_customer_id, orig_customer_po, enduser_po, scrap_handing_type)
            VALUES (:id, :cust, :po, :epo, :scrap)
            """,
            new { id = orderId, cust = body.Order.OrigCustomerId, po = body.Order.OrigCustomerPo, epo = body.Order.EnduserPo, scrap = body.Order.ScrapHandingType },
            transaction: tx, cancellationToken: ct));

        foreach (var item in body.Items)
        {
            var itemId = await NextOrderItemNumAsync(conn, tx, orderId, ct);
            await conn.ExecuteAsync(new CommandDefinition(
                """
                INSERT INTO order_item (order_item_num, order_abc_num, enduser_part_num, alloy2, temper, gauge,
                    gauge_p, gauge_m, surface, flatness, sheet_type, material_end_use, order_item_desc,
                    pieces_skid, theoretical_unit_wt, unit_price, item_created_dttm)
                VALUES (:id, :ord, :part, :alloy, :temper, :gauge, :gp, :gm, :surface, :flatness, :sheet,
                    :enduse, :idesc, :pieces, :tuw, :price, :created)
                """,
                new
                {
                    id = itemId, ord = orderId, part = item.EnduserPartNum, alloy = item.Alloy2, temper = item.Temper,
                    gauge = item.Gauge, gp = item.GaugeP, gm = item.GaugeM, surface = item.Surface, flatness = item.Flatness,
                    sheet = item.SheetType, enduse = item.MaterialEndUse, idesc = item.OrderItemDesc,
                    pieces = item.PiecesSkid, tuw = item.TheoreticalUnitWt, price = item.UnitPrice,
                    created = (DateTime?)DateTime.UtcNow
                },
                transaction: tx, cancellationToken: ct));
        }

        await tx.CommitAsync(ct);
        return (await GetOrderDetailAsync(orderId, ct))!;
    }

    public Task<PagedResult<Part>> GetPartsAsync(int page, int pageSize, long? customerId, string? alloy, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (customerId is not null) { conditions.Add("customer_id = :customerId"); p.Add("customerId", customerId); }
        if (alloy is not null) { conditions.Add("alloy = :alloy"); p.Add("alloy", alloy); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<Part>(PartCols, "part_num", orderBy ?? "part_num_id", where, p, page, pageSize, ct);
    }

    public async Task<Part?> GetPartAsync(long partNumId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Part>(new CommandDefinition(
            $"SELECT {PartCols} FROM part_num WHERE part_num_id = :id", new { id = partNumId }, cancellationToken: ct));
    }

    public async Task<Part> CreatePartAsync(PartWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "part_num", "part_num_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO part_num (part_num_id, customer_id, enduser_id, enduser_part_num, sheet_type, alloy, temper, gauge, item_status)
            VALUES (:id, :cust, :enduser, :part, :sheet, :alloy, :temper, :gauge, :status)
            """,
            // item_status is NOT NULL; default to 0 (inactive) when not supplied.
            new { id, cust = body.CustomerId, enduser = body.EnduserId, part = body.EnduserPartNum, sheet = body.SheetType,
                  alloy = body.Alloy, temper = body.Temper, gauge = body.Gauge, status = body.ItemStatus ?? 0 },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetPartAsync(id, ct))!;
    }

    public async Task<Part?> UpdatePartAsync(long partNumId, PartWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // item_status preserved when omitted (COALESCE) so a partial body can't null a NOT NULL column.
        // :status is nullable NUMBER — type it explicitly so a null binds as NUMBER,
        // not CHAR, avoiding ORA-00932 in the COALESCE (see PatchJobAsync).
        var p = new DynamicParameters();
        p.Add("cust", body.CustomerId);
        p.Add("enduser", body.EnduserId);
        p.Add("part", body.EnduserPartNum);
        p.Add("sheet", body.SheetType);
        p.Add("alloy", body.Alloy);
        p.Add("temper", body.Temper);
        p.Add("gauge", body.Gauge);
        p.Add("status", body.ItemStatus, DbType.Int32);
        p.Add("id", partNumId);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE part_num SET customer_id = :cust, enduser_id = :enduser, enduser_part_num = :part,
                   sheet_type = :sheet, alloy = :alloy, temper = :temper, gauge = :gauge,
                   item_status = COALESCE(:status, item_status)
            WHERE part_num_id = :id
            """,
            p,
            cancellationToken: ct));
        return n == 0 ? null : await GetPartAsync(partNumId, ct);
    }

    public Task<PagedResult<Die>> GetDiesAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct) =>
        PageAsync<Die>(DieCols, "die", orderBy ?? "die_id",
            status is null ? null : "status = :status",
            new { status }, page, pageSize, ct);

    public async Task<Die?> GetDieAsync(long dieId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Die>(new CommandDefinition(
            $"SELECT {DieCols} FROM die WHERE die_id = :id", new { id = dieId }, cancellationToken: ct));
    }

    public async Task<Die> CreateDieAsync(DieWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "die", "die_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO die (die_id, die_name, status, tool_num, part_name, gross_weight, location, description)
            VALUES (:id, :name, :status, :tool, :part, :weight, :loc, :idesc)
            """,
            new { id, name = body.DieName, status = body.Status, tool = body.ToolNum, part = body.PartName,
                  weight = body.GrossWeight, loc = body.Location, idesc = body.Description },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetDieAsync(id, ct))!;
    }

    public async Task<Die?> UpdateDieAsync(long dieId, DieWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE die SET die_name = :name, status = :status, tool_num = :tool, part_name = :part,
                   gross_weight = :weight, location = :loc, description = :idesc
            WHERE die_id = :id
            """,
            new { name = body.DieName, status = body.Status, tool = body.ToolNum, part = body.PartName,
                  weight = body.GrossWeight, loc = body.Location, idesc = body.Description, id = dieId },
            cancellationToken: ct));
        return n == 0 ? null : await GetDieAsync(dieId, ct);
    }

    public Task<PagedResult<Shipment>> GetShipmentsAsync(int page, int pageSize, long? customerId, string? orderBy, CancellationToken ct) =>
        PageAsync<Shipment>(ShipmentCols, "shipment", orderBy ?? "packing_list",
            customerId is null ? null : "customer_id = :customerId",
            new { customerId }, page, pageSize, ct);

    public async Task<Shipment?> GetShipmentAsync(long packingList, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Shipment>(new CommandDefinition(
            $"SELECT {ShipmentCols} FROM shipment WHERE packing_list = :id", new { id = packingList }, cancellationToken: ct));
    }

    public async Task<Shipment> CreateShipmentAsync(ShipmentWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        // packing_list (PK) comes from PACKING_LIST_NUM_SEQ (table override); bill_of_lading
        // is also NOT NULL and drawn from its OWN sequence (BILL_OF_LADING_SEQ), passed
        // explicitly so the table-keyed override isn't applied to it.
        var packingList = await NextIdAsync(conn, tx, "shipment", "packing_list", ct);
        var billOfLading = await NextIdAsync(conn, tx, "shipment", "bill_of_lading", ct, sequence: "bill_of_lading_seq");
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO shipment (packing_list, bill_of_lading, carrier_id, customer_id, des_sh_cust_id, vehicle_id,
                vehicle_status, shipment_status, shipment_scheduled_date_time, shipment_notes)
            VALUES (:id, :bol, :carrier, :cust, :desCust, :vehicle, :vStatus, :sStatus, :sched, :notes)
            """,
            new { id = packingList, bol = billOfLading, carrier = body.CarrierId, cust = body.CustomerId,
                  desCust = body.DesShCustId, vehicle = body.VehicleId, vStatus = body.VehicleStatus,
                  sStatus = body.ShipmentStatus, sched = body.ShipmentScheduledDateTime, notes = body.ShipmentNotes },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetShipmentAsync(packingList, ct))!;
    }

    public async Task<Shipment?> UpdateShipmentAsync(long packingList, ShipmentWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // packing_list and bill_of_lading are server-assigned keys — matched/kept, never replaced.
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE shipment SET carrier_id = :carrier, customer_id = :cust, des_sh_cust_id = :desCust,
                   vehicle_id = :vehicle, vehicle_status = :vStatus, shipment_status = :sStatus,
                   shipment_scheduled_date_time = :sched, shipment_notes = :notes
            WHERE packing_list = :id
            """,
            new { carrier = body.CarrierId, cust = body.CustomerId, desCust = body.DesShCustId, vehicle = body.VehicleId,
                  vStatus = body.VehicleStatus, sStatus = body.ShipmentStatus, sched = body.ShipmentScheduledDateTime,
                  notes = body.ShipmentNotes, id = packingList },
            cancellationToken: ct));
        return n == 0 ? null : await GetShipmentAsync(packingList, ct);
    }

    public async Task<Shipment?> PatchShipmentAsync(long packingList, ShipmentStatusPatch patch, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // Nullable non-string params must carry an explicit DbType: ODP.NET binds a
        // null as CHAR otherwise, and COALESCE(charNull, numericOrDateCol) raises
        // ORA-00932 on Oracle (SQLite is typeless, so CI never sees it).
        var p = new DynamicParameters();
        p.Add("sStatus", patch.ShipmentStatus, DbType.Int32);
        p.Add("vStatus", patch.VehicleStatus, DbType.Int32);
        p.Add("sent", patch.DateSent, DbType.DateTime);
        p.Add("actual", patch.ShipmentActualedDateTime, DbType.DateTime);
        p.Add("notes", patch.ShipmentNotes);
        p.Add("id", packingList);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE shipment SET
                shipment_status = COALESCE(:sStatus, shipment_status),
                vehicle_status = COALESCE(:vStatus, vehicle_status),
                date_sent = COALESCE(:sent, date_sent),
                shipment_actualed_date_time = COALESCE(:actual, shipment_actualed_date_time),
                shipment_notes = COALESCE(:notes, shipment_notes)
            WHERE packing_list = :id
            """,
            p, cancellationToken: ct));
        return n == 0 ? null : await GetShipmentAsync(packingList, ct);
    }

    public Task<PagedResult<ReceivingBol>> GetReceivingBolsAsync(int page, int pageSize, long? customerId, int? status, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (customerId is not null) { conditions.Add("customer_id = :customerId"); p.Add("customerId", customerId); }
        if (status is not null) { conditions.Add("status = :status"); p.Add("status", status); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<ReceivingBol>(ReceivingBolCols, "receiving_bol", orderBy ?? "receiving_bol_id", where, p, page, pageSize, ct);
    }

    public async Task<ReceivingBol?> GetReceivingBolAsync(long receivingBolId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<ReceivingBol>(new CommandDefinition(
            $"SELECT {ReceivingBolCols} FROM receiving_bol WHERE receiving_bol_id = :id", new { id = receivingBolId }, cancellationToken: ct));
    }

    // ---- EDI (outbound transaction ledger + transmission log) ------------
    public Task<PagedResult<EdiTransaction>> GetEdiTransactionsAsync(int page, int pageSize, long? customerId, string? transactionTypeId, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (customerId is not null) { conditions.Add("customer_id = :customerId"); p.Add("customerId", customerId); }
        if (transactionTypeId is not null) { conditions.Add("transaction_type_id = :ttype"); p.Add("ttype", transactionTypeId); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<EdiTransaction>(EdiTransactionCols, "outbound_edi_transaction", orderBy ?? "edi_file_id DESC", where, p, page, pageSize, ct);
    }

    public async Task<EdiTransaction?> GetEdiTransactionAsync(long ediFileId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<EdiTransaction>(new CommandDefinition(
            $"SELECT {EdiTransactionCols} FROM outbound_edi_transaction WHERE edi_file_id = :id", new { id = ediFileId }, cancellationToken: ct));
    }

    public Task<PagedResult<EdiLogEntry>> GetEdiLogAsync(int page, int pageSize, long? customerId, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var where = customerId is null ? null : "customer_id = :customerId";
        if (customerId is not null) p.Add("customerId", customerId);
        return PageAsync<EdiLogEntry>(EdiLogCols, "edi_log", orderBy ?? "edi_log_timestamp DESC", where, p, page, pageSize, ct);
    }

    public async Task<IReadOnlyList<EdiType>> GetEdiTypesAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<EdiType>(new CommandDefinition(
            "SELECT edi_type_id AS EdiTypeId, edi_version AS EdiVersion, edi_type_description AS EdiTypeDescription FROM edi_type ORDER BY edi_type_id, edi_version",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<CustomerEdi>> GetCustomerEdiAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<CustomerEdi>(new CommandDefinition(
            "SELECT customer_edi_name AS CustomerEdiName, customer_id AS CustomerId, edi_type_id AS EdiTypeId, edi_version AS EdiVersion, customer_edi_desc AS CustomerEdiDesc FROM customer_edi ORDER BY customer_edi_name",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<ReceivingBol> CreateReceivingBolAsync(ReceivingBolWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "receiving_bol", "receiving_bol_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO receiving_bol (receiving_bol_id, bol, customer_id, created_by, created_date, received_date, status)
            VALUES (:id, :bol, :cust, :cby, :created, :received, :status)
            """,
            new { id, bol = body.Bol, cust = body.CustomerId, cby = body.CreatedBy,
                  created = (DateTime?)DateTime.UtcNow, received = body.ReceivedDate, status = body.Status },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetReceivingBolAsync(id, ct))!;
    }

    public async Task<ReceivingBol?> UpdateReceivingBolAsync(long receivingBolId, ReceivingBolWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // created_date is set once on insert and not changed here.
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE receiving_bol SET bol = :bol, customer_id = :cust, created_by = :cby,
                   received_date = :received, status = :status
            WHERE receiving_bol_id = :id
            """,
            new { bol = body.Bol, cust = body.CustomerId, cby = body.CreatedBy, received = body.ReceivedDate,
                  status = body.Status, id = receivingBolId },
            cancellationToken: ct));
        return n == 0 ? null : await GetReceivingBolAsync(receivingBolId, ct);
    }

    public Task<PagedResult<ScanLog>> GetScanLogsAsync(int page, int pageSize, long? abJobNum, string? orderBy, CancellationToken ct) =>
        PageAsync<ScanLog>(ScanLogCols, "scan_log", orderBy ?? "scan_id DESC",
            abJobNum is null ? null : "ab_job_num = :abJobNum",
            new { abJobNum }, page, pageSize, ct);

    public async Task<ScanLog?> GetScanLogAsync(long scanId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<ScanLog>(new CommandDefinition(
            $"SELECT {ScanLogCols} FROM scan_log WHERE scan_id = :id", new { id = scanId }, cancellationToken: ct));
    }

    public async Task<ScanLog> CreateScanLogAsync(ScanLogWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        // scan_log is append-only (no update path); scan_datetime is stamped server-side.
        var id = await NextIdAsync(conn, tx, "scan_log", "scan_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO scan_log (scan_id, scan_datetime, ab_job_num, scan_station, note)
            VALUES (:id, :dt, :job, :station, :note)
            """,
            new { id, dt = (DateTime?)DateTime.UtcNow, job = body.AbJobNum, station = body.ScanStation, note = body.Note },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetScanLogAsync(id, ct))!;
    }

    public async Task<IReadOnlyList<ScanLog>> GetJobScansAsync(long abJobNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<ScanLog>(new CommandDefinition(
            $"SELECT {ScanLogCols} FROM scan_log WHERE ab_job_num = :id ORDER BY scan_id", new { id = abJobNum }, cancellationToken: ct));
        return rows.AsList();
    }

    public Task<PagedResult<MaintLog>> GetMaintLogsAsync(int page, int pageSize, string? status, long? groupDepartmentId, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (status is not null) { conditions.Add("maint_log_status = :status"); p.Add("status", status); }
        if (groupDepartmentId is not null) { conditions.Add("groupdepartment_id = :groupDepartmentId"); p.Add("groupDepartmentId", groupDepartmentId); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<MaintLog>(MaintLogCols, "maint_log", orderBy ?? "maint_log_id DESC", where, p, page, pageSize, ct);
    }

    public async Task<MaintLog?> GetMaintLogAsync(long maintLogId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<MaintLog>(new CommandDefinition(
            $"SELECT {MaintLogCols} FROM maint_log WHERE maint_log_id = :id", new { id = maintLogId }, cancellationToken: ct));
    }

    public async Task<MaintLog> CreateMaintLogAsync(MaintLogWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        // maint_log has no Oracle sequence (Database:MaxIdTables) — id is MAX+1.
        // entereddatetime is NOT NULL and stamped server-side on create.
        var id = await NextIdAsync(conn, tx, "maint_log", "maint_log_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO maint_log (maint_log_id, maint_log_status, groupdepartment_id, systemequipment, subsystemequipment,
                itemdevice, probdatetime, prob_details, actions, author, reportedby, entereddatetime, assignedto,
                completeddatetime, completedby, laborhours, prob_cost)
            VALUES (:id, :status, :dept, :sys, :subsys, :item, :prob, :details, :actions, :author, :reportedBy, :entered,
                :assigned, :completed, :completedBy, :labor, :cost)
            """,
            new { id, status = body.MaintLogStatus, dept = body.GroupDepartmentId, sys = body.SystemEquipment,
                  subsys = body.SubsystemEquipment, item = body.ItemDevice, prob = body.ProbDateTime, details = body.ProbDetails,
                  actions = body.Actions, author = body.Author, reportedBy = body.ReportedBy, entered = (DateTime?)DateTime.UtcNow,
                  assigned = body.AssignedTo, completed = body.CompletedDateTime, completedBy = body.CompletedBy,
                  labor = body.LaborHours, cost = body.ProbCost },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetMaintLogAsync(id, ct))!;
    }

    public async Task<MaintLog?> UpdateMaintLogAsync(long maintLogId, MaintLogWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // entereddatetime is set once on insert and not changed here.
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE maint_log SET maint_log_status = :status, groupdepartment_id = :dept, systemequipment = :sys,
                   subsystemequipment = :subsys, itemdevice = :item, probdatetime = :prob, prob_details = :details,
                   actions = :actions, author = :author, reportedby = :reportedBy, assignedto = :assigned,
                   completeddatetime = :completed, completedby = :completedBy, laborhours = :labor, prob_cost = :cost
            WHERE maint_log_id = :id
            """,
            new { status = body.MaintLogStatus, dept = body.GroupDepartmentId, sys = body.SystemEquipment,
                  subsys = body.SubsystemEquipment, item = body.ItemDevice, prob = body.ProbDateTime, details = body.ProbDetails,
                  actions = body.Actions, author = body.Author, reportedBy = body.ReportedBy, assigned = body.AssignedTo,
                  completed = body.CompletedDateTime, completedBy = body.CompletedBy, labor = body.LaborHours,
                  cost = body.ProbCost, id = maintLogId },
            cancellationToken: ct));
        return n == 0 ? null : await GetMaintLogAsync(maintLogId, ct);
    }

    public Task<PagedResult<Carrier>> GetCarriersAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct) =>
        PageAsync<Carrier>(CarrierCols, "carrier", orderBy ?? "carrier_id",
            status is null ? null : "status = :status",
            new { status }, page, pageSize, ct);

    public async Task<Carrier?> GetCarrierAsync(long carrierId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Carrier>(new CommandDefinition(
            $"SELECT {CarrierCols} FROM carrier WHERE carrier_id = :id", new { id = carrierId }, cancellationToken: ct));
    }

    public async Task<Carrier> CreateCarrierAsync(CarrierWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "carrier", "carrier_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO carrier (carrier_id, scac, carrier_full_name, carrier_type_code, carrier_city, carrier_state, carrier_phone_number, status)
            VALUES (:id, :scac, :name, :type, :city, :state, :phone, :status)
            """,
            new { id, scac = body.Scac, name = body.CarrierFullName, type = body.CarrierTypeCode, city = body.CarrierCity,
                  state = body.CarrierState, phone = body.CarrierPhoneNumber, status = body.Status },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetCarrierAsync(id, ct))!;
    }

    public async Task<Carrier?> UpdateCarrierAsync(long carrierId, CarrierWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE carrier SET scac = :scac, carrier_full_name = :name, carrier_type_code = :type,
                   carrier_city = :city, carrier_state = :state, carrier_phone_number = :phone, status = :status
            WHERE carrier_id = :id
            """,
            new { scac = body.Scac, name = body.CarrierFullName, type = body.CarrierTypeCode, city = body.CarrierCity,
                  state = body.CarrierState, phone = body.CarrierPhoneNumber, status = body.Status, id = carrierId },
            cancellationToken: ct));
        return n == 0 ? null : await GetCarrierAsync(carrierId, ct);
    }

    public Task<PagedResult<Shift>> GetShiftsAsync(int page, int pageSize, long? lineNum, string? orderBy, CancellationToken ct) =>
        PageAsync<Shift>(ShiftCols, "shift", orderBy ?? "shift_num DESC",
            lineNum is null ? null : "line_num = :lineNum",
            new { lineNum }, page, pageSize, ct);

    public async Task<Shift?> GetShiftAsync(long shiftNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Shift>(new CommandDefinition(
            $"SELECT {ShiftCols} FROM shift WHERE shift_num = :id", new { id = shiftNum }, cancellationToken: ct));
    }

    public async Task<Shift> CreateShiftAsync(ShiftWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "shift", "shift_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO shift (shift_num, start_time, end_time, line_num, schedule_type, dt_total, operator_initial, shift_data_status, note)
            VALUES (:id, :stime, :etime, :line, :sched, :dt, :op, :status, :note)
            """,
            new { id, stime = body.StartTime, etime = body.EndTime, line = body.LineNum, sched = body.ScheduleType,
                  dt = body.DtTotal, op = body.OperatorInitial, status = body.ShiftDataStatus, note = body.Note },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetShiftAsync(id, ct))!;
    }

    public async Task<Shift?> UpdateShiftAsync(long shiftNum, ShiftWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE shift SET start_time = :stime, end_time = :etime, line_num = :line, schedule_type = :sched,
                   dt_total = :dt, operator_initial = :op, shift_data_status = :status, note = :note
            WHERE shift_num = :id
            """,
            new { stime = body.StartTime, etime = body.EndTime, line = body.LineNum, sched = body.ScheduleType,
                  dt = body.DtTotal, op = body.OperatorInitial, status = body.ShiftDataStatus, note = body.Note, id = shiftNum },
            cancellationToken: ct));
        return n == 0 ? null : await GetShiftAsync(shiftNum, ct);
    }

    public Task<PagedResult<DowntimeInstance>> GetDowntimeInstancesAsync(int page, int pageSize, long? abJobNum, long? shiftNum, string? orderBy, CancellationToken ct)
    {
        var p = new DynamicParameters();
        var conditions = new List<string>();
        if (abJobNum is not null) { conditions.Add("ab_job_num = :abJobNum"); p.Add("abJobNum", abJobNum); }
        if (shiftNum is not null) { conditions.Add("shift_num = :shiftNum"); p.Add("shiftNum", shiftNum); }
        var where = conditions.Count > 0 ? string.Join(" AND ", conditions) : null;
        return PageAsync<DowntimeInstance>(DowntimeCols, "dt_instance", orderBy ?? "instance_num DESC", where, p, page, pageSize, ct);
    }

    public async Task<DowntimeInstance?> GetDowntimeInstanceAsync(long instanceNum, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<DowntimeInstance>(new CommandDefinition(
            $"SELECT {DowntimeCols} FROM dt_instance WHERE instance_num = :id", new { id = instanceNum }, cancellationToken: ct));
    }

    public async Task<DowntimeInstance> CreateDowntimeInstanceAsync(DowntimeInstanceWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "dt_instance", "instance_num", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO dt_instance (instance_num, ab_job_num, line_num, starting_time, ending_time, note, shift_num)
            VALUES (:id, :job, :line, :stime, :etime, :note, :shift)
            """,
            new { id, job = body.AbJobNum, line = body.LineNum, stime = body.StartingTime, etime = body.EndingTime,
                  note = body.Note, shift = body.ShiftNum },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetDowntimeInstanceAsync(id, ct))!;
    }

    public async Task<DowntimeInstance?> UpdateDowntimeInstanceAsync(long instanceNum, DowntimeInstanceWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE dt_instance SET ab_job_num = :job, line_num = :line, starting_time = :stime,
                   ending_time = :etime, note = :note, shift_num = :shift
            WHERE instance_num = :id
            """,
            new { job = body.AbJobNum, line = body.LineNum, stime = body.StartingTime, etime = body.EndingTime,
                  note = body.Note, shift = body.ShiftNum, id = instanceNum },
            cancellationToken: ct));
        return n == 0 ? null : await GetDowntimeInstanceAsync(instanceNum, ct);
    }

    public async Task<IReadOnlyList<CustomerContact>> GetCustomerContactsAsync(long customerId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<CustomerContact>(new CommandDefinition(
            $"SELECT {ContactCols} FROM customer_contact WHERE customer_id = :id ORDER BY contact_id",
            new { id = customerId }, cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<CustomerContact?> GetCustomerContactAsync(long contactId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<CustomerContact>(new CommandDefinition(
            $"SELECT {ContactCols} FROM customer_contact WHERE contact_id = :id", new { id = contactId }, cancellationToken: ct));
    }

    public async Task<CustomerContact> CreateCustomerContactAsync(long customerId, CustomerContactWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        // customer_contact's sequence is CUSTOMER_CONTACT_ID_SEQ — it does NOT follow
        // the {idColumn}_seq convention (id column is contact_id), so a per-table
        // override is configured (Database:Sequences). The owning customer comes from the route.
        var id = await NextIdAsync(conn, tx, "customer_contact", "contact_id", ct);
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO customer_contact (contact_id, customer_id, first_name, last_name, department, city, state, phone1, email1)
            VALUES (:id, :cust, :first, :last, :dept, :city, :state, :phone, :email)
            """,
            new { id, cust = customerId, first = body.FirstName, last = body.LastName, dept = body.Department,
                  city = body.City, state = body.State, phone = body.Phone1, email = body.Email1 },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetCustomerContactAsync(id, ct))!;
    }

    public async Task<CustomerContact?> UpdateCustomerContactAsync(long contactId, CustomerContactWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        // customer_id is the owning FK (set on create from the route), so it's not changed here.
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE customer_contact SET first_name = :first, last_name = :last, department = :dept,
                   city = :city, state = :state, phone1 = :phone, email1 = :email
            WHERE contact_id = :id
            """,
            new { first = body.FirstName, last = body.LastName, dept = body.Department, city = body.City,
                  state = body.State, phone = body.Phone1, email = body.Email1, id = contactId },
            cancellationToken: ct));
        return n == 0 ? null : await GetCustomerContactAsync(contactId, ct);
    }

    public Task<PagedResult<Sketch>> GetSketchesAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct) =>
        PageAsync<Sketch>(SketchCols, "sketch", orderBy ?? "sketch_id",
            status is null ? null : "sketch_status = :status",
            new { status }, page, pageSize, ct);

    public async Task<Sketch?> GetSketchAsync(long sketchId, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        return await conn.QuerySingleOrDefaultAsync<Sketch>(new CommandDefinition(
            $"SELECT {SketchCols} FROM sketch WHERE sketch_id = :id", new { id = sketchId }, cancellationToken: ct));
    }

    public async Task<Sketch> CreateSketchAsync(SketchWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);
        var id = await NextIdAsync(conn, tx, "sketch", "sketch_id", ct);
        // The binary sketch_view (LONG RAW image) is never written through this API.
        await conn.ExecuteAsync(new CommandDefinition(
            """
            INSERT INTO sketch (sketch_id, sketch_name, sketch_notes, sketch_sys_note, sketch_status)
            VALUES (:id, :name, :notes, :sysNote, :status)
            """,
            new { id, name = body.SketchName, notes = body.SketchNotes, sysNote = body.SketchSysNote, status = body.SketchStatus },
            transaction: tx, cancellationToken: ct));
        await tx.CommitAsync(ct);
        return (await GetSketchAsync(id, ct))!;
    }

    public async Task<Sketch?> UpdateSketchAsync(long sketchId, SketchWrite body, CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var n = await conn.ExecuteAsync(new CommandDefinition(
            """
            UPDATE sketch SET sketch_name = :name, sketch_notes = :notes,
                   sketch_sys_note = :sysNote, sketch_status = :status
            WHERE sketch_id = :id
            """,
            new { name = body.SketchName, notes = body.SketchNotes, sysNote = body.SketchSysNote, status = body.SketchStatus, id = sketchId },
            cancellationToken: ct));
        return n == 0 ? null : await GetSketchAsync(sketchId, ct);
    }

    public async Task<IReadOnlyList<string>> GetAlloysAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<string>(new CommandDefinition(
            "SELECT DISTINCT alloy2 FROM order_item WHERE alloy2 IS NOT NULL ORDER BY alloy2",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<ProductionLine>> GetLinesAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<ProductionLine>(new CommandDefinition(
            "SELECT line_num AS LineNum, line_desc AS LineDesc, line_location AS LineLocation FROM line ORDER BY line_num",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<GroupDepartment>> GetGroupDepartmentsAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<GroupDepartment>(new CommandDefinition(
            "SELECT groupdepartment_id AS GroupDepartmentId, groupdepartment AS GroupDepartmentName, depttype AS DeptType FROM groupdepartment ORDER BY groupdepartment_id",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<DowntimeCause>> GetDowntimeCausesAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<DowntimeCause>(new CommandDefinition(
            "SELECT id AS Id, cause_name AS CauseName, note AS Note FROM dt_cause ORDER BY id",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<TransportationMethod>> GetTransportationMethodsAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<TransportationMethod>(new CommandDefinition(
            "SELECT trans_method_code AS TransMethodCode, trans_desc AS TransDesc FROM transportation_method ORDER BY trans_method_code",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<EquipmentType>> GetEquipmentTypesAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<EquipmentType>(new CommandDefinition(
            "SELECT equipment_type_code AS EquipmentTypeCode, equipment_type_desc AS EquipmentTypeDesc, equipment_type_note AS EquipmentTypeNote FROM equipment_type ORDER BY equipment_type_code",
            cancellationToken: ct));
        return rows.AsList();
    }

    public async Task<IReadOnlyList<CustomerType>> GetCustomerTypesAsync(CancellationToken ct)
    {
        await using var conn = await OpenAsync(ct);
        var rows = await conn.QueryAsync<CustomerType>(new CommandDefinition(
            "SELECT customer_type AS CustomerTypeCode, customer_type_description AS CustomerTypeDescription FROM customer_type ORDER BY customer_type",
            cancellationToken: ct));
        return rows.AsList();
    }

    /// <summary>Next id for an insert, run inside the caller's transaction. The
    /// dialect-specific SQL (MAX+1 on SQLite, a sequence NEXTVAL on Oracle) comes
    /// from the connection factory. Table/column are internal constants.</summary>
    private Task<long> NextIdAsync(DbConnection conn, DbTransaction tx, string table, string idColumn, CancellationToken ct, string? sequence = null) =>
        conn.ExecuteScalarAsync<long>(new CommandDefinition(
            _factory.NextIdQuery(table, idColumn, sequence), transaction: tx, cancellationToken: ct));

    /// <summary>Next line number for an order_item: MAX(order_item_num)+1 scoped to
    /// the order. order_item has a composite key and no sequence — the line number
    /// is assigned per order (portable SQL; runs inside the caller's transaction).</summary>
    private static Task<long> NextOrderItemNumAsync(DbConnection conn, DbTransaction tx, long orderAbcNum, CancellationToken ct) =>
        conn.ExecuteScalarAsync<long>(new CommandDefinition(
            "SELECT COALESCE(MAX(order_item_num), 0) + 1 FROM order_item WHERE order_abc_num = :ord",
            new { ord = orderAbcNum }, transaction: tx, cancellationToken: ct));

    /// <summary>Merge two anonymous parameter objects into one Dapper parameter bag.</summary>
    private static DynamicParameters Merge(object a, object b)
    {
        var p = new DynamicParameters();
        p.AddDynamicParams(a);
        p.AddDynamicParams(b);
        return p;
    }
}
