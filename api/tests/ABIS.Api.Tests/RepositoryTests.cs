using Abis.Api.Data;
using Abis.Api.Models;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>Exercises the Dapper repository against a freshly seeded SQLite fixture.</summary>
public sealed class RepositoryTests : IDisposable
{
    private readonly string _dbPath;
    private readonly AbisRepository _repo;

    public RepositoryTests()
    {
        _dbPath = Path.Combine(Path.GetTempPath(), $"abis_repo_{Guid.NewGuid():N}.db");
        var options = new DatabaseOptions
        {
            Provider = "Sqlite",
            ConnectionString = $"Data Source={_dbPath}",
            Seed = true
        };
        SqliteFixture.EnsureCreatedAndSeeded(options.ConnectionString);
        _repo = new AbisRepository(new DbConnectionFactory(options));
    }

    [Fact]
    public async Task GetJobs_returns_all_seeded_jobs()
    {
        var page = await _repo.GetJobsAsync(1, 25, status: null, orderBy: null, CancellationToken.None);
        Assert.Equal(3, page.TotalCount);
        Assert.Equal(3, page.Items.Count);
    }

    [Fact]
    public async Task GetJobs_filters_by_status()
    {
        var page = await _repo.GetJobsAsync(1, 25, status: 1, orderBy: null, CancellationToken.None);
        Assert.Equal(2, page.TotalCount);
        Assert.All(page.Items, j => Assert.Equal(1, j.JobStatus));
    }

    [Fact]
    public async Task GetJobs_paginates()
    {
        var p1 = await _repo.GetJobsAsync(1, 2, status: null, orderBy: null, CancellationToken.None);
        Assert.Equal(3, p1.TotalCount);
        Assert.Equal(2, p1.Items.Count);
        Assert.Equal(2, p1.TotalPages);

        var p2 = await _repo.GetJobsAsync(2, 2, status: null, orderBy: null, CancellationToken.None);
        Assert.Single(p2.Items);
    }

    [Fact]
    public async Task GetJob_returns_decimal_and_date_round_trips()
    {
        var job = await _repo.GetJobAsync(1001, CancellationToken.None);
        Assert.NotNull(job);
        Assert.Equal(92.5m, job!.MaterialYield);
        Assert.NotNull(job.CreateDate);          // date round-trip
        Assert.Null(job.TimeDateFinished);

        var done = await _repo.GetJobAsync(1003, CancellationToken.None);
        Assert.NotNull(done!.TimeDateFinished);   // non-null date round-trip
    }

    [Fact]
    public async Task GetJob_unknown_returns_null()
    {
        Assert.Null(await _repo.GetJobAsync(424242, CancellationToken.None));
    }

    [Fact]
    public async Task GetJobCoils_joins_coil_attributes()
    {
        var coils = await _repo.GetJobCoilsAsync(1001, CancellationToken.None);
        Assert.Equal(2, coils.Count);
        var first = coils.First();
        Assert.Equal(5001, first.CoilAbcNum);
        Assert.Equal("3003", first.CoilAlloy2);   // came from the LEFT JOIN to coil
        Assert.Equal(48.5m, first.CoilWidth);
    }

    [Fact]
    public async Task GetCoil_reads_status_and_measures()
    {
        var coil = await _repo.GetCoilAsync(5004, CancellationToken.None);
        Assert.NotNull(coil);
        Assert.Equal(3, coil!.CoilStatus);
        Assert.Equal("5052", coil.CoilAlloy2);
        Assert.Equal(0.0625m, coil.CoilGauge);
    }

    [Fact]
    public async Task GetOrderItems_filters_by_alloy()
    {
        var items = await _repo.GetOrderItemsAsync(1, 25, alloy: "3003", orderBy: null, CancellationToken.None);
        Assert.Equal(2, items.TotalCount);
        Assert.All(items.Items, i => Assert.Equal("3003", i.Alloy2));
    }

    [Fact]
    public async Task GetTestResults_filters_by_type_and_orders_desc()
    {
        var all = await _repo.GetTestResultsAsync(1, 25, testType: null, position: null, from: null, to: null, orderBy: null, CancellationToken.None);
        Assert.Equal(3, all.TotalCount);

        var t1 = await _repo.GetTestResultsAsync(1, 25, testType: 1, position: null, from: null, to: null, orderBy: null, CancellationToken.None);
        Assert.Single(t1.Items);
        Assert.Equal(45.0m, t1.Items[0].YtsVal);
    }

    // ---- Expanded reads -------------------------------------------------

    [Fact]
    public async Task GetCustomers_lists_and_filters_by_name()
    {
        var all = await _repo.GetCustomersAsync(1, 25, name: null, orderBy: null, CancellationToken.None);
        Assert.Equal(2, all.TotalCount);

        var acme = await _repo.GetCustomersAsync(1, 25, name: "ACME", orderBy: null, CancellationToken.None);
        Assert.Single(acme.Items);
        Assert.Equal(4001, acme.Items[0].CustomerId);
    }

    [Fact]
    public async Task GetJobSheetSkids_and_scrap_filter_by_job()
    {
        var skids = await _repo.GetJobSheetSkidsAsync(1001, CancellationToken.None);
        Assert.Equal(2, skids.Count);

        // scrap_ab_job_num is char(18); the repo matches on the string form.
        var scrap = await _repo.GetJobScrapAsync(1001, CancellationToken.None);
        Assert.Single(scrap);
        Assert.Equal("1001", scrap[0].ScrapAbJobNum);
    }

    // ---- Writes ---------------------------------------------------------

    [Fact]
    public async Task CreateCustomer_assigns_next_id_and_persists()
    {
        var created = await _repo.CreateCustomerAsync(
            new CustomerWrite { CustomerName = "GAMMA ALLOYS", CustomerShortName = "GAMMA" }, CancellationToken.None);

        Assert.Equal(4003, created.CustomerId);   // MAX(4002) + 1
        var fetched = await _repo.GetCustomerAsync(4003, CancellationToken.None);
        Assert.Equal("GAMMA ALLOYS", fetched!.CustomerName);
    }

    [Fact]
    public async Task UpdateCustomer_changes_fields_and_unknown_returns_null()
    {
        var updated = await _repo.UpdateCustomerAsync(4001,
            new CustomerWrite { CustomerName = "ACME METALS LLC", CustomerShortName = "ACME" }, CancellationToken.None);
        Assert.Equal("ACME METALS LLC", updated!.CustomerName);

        Assert.Null(await _repo.UpdateCustomerAsync(999999,
            new CustomerWrite { CustomerName = "NOPE" }, CancellationToken.None));
    }

    [Fact]
    public async Task PatchJob_updates_only_provided_fields()
    {
        var patched = await _repo.PatchJobAsync(1001,
            new JobPatch { JobStatus = 7, JobNotes = "patched" }, CancellationToken.None);

        Assert.NotNull(patched);
        Assert.Equal(7, patched!.JobStatus);
        Assert.Equal("patched", patched.JobNotes);
        Assert.Equal(92.5m, patched.MaterialYield);   // untouched field preserved
    }

    [Fact]
    public async Task PatchJob_with_empty_body_preserves_values()
    {
        var patched = await _repo.PatchJobAsync(1001, new JobPatch(), CancellationToken.None);
        Assert.Equal(1, patched!.JobStatus);          // original value, not nulled
        Assert.Equal("Running", patched.JobNotes);
    }

    [Fact]
    public async Task PatchJob_unknown_returns_null()
    {
        Assert.Null(await _repo.PatchJobAsync(999999, new JobPatch { JobStatus = 1 }, CancellationToken.None));
    }

    [Fact]
    public async Task PatchCoil_updates_location_and_status()
    {
        var patched = await _repo.PatchCoilAsync(5001,
            new CoilPatch { CoilStatus = 9, CoilLocation = "Z-99" }, CancellationToken.None);
        Assert.Equal(9, patched!.CoilStatus);
        Assert.Equal("Z-99", patched.CoilLocation);
        Assert.Equal("3003", patched.CoilAlloy2);     // untouched field preserved
    }

    [Fact]
    public async Task CreateOrder_assigns_next_id_and_persists()
    {
        var created = await _repo.CreateOrderAsync(
            new CustomerOrderWrite { OrigCustomerId = 4001, OrigCustomerPo = "PO-NEW", EnduserPo = "EU-NEW" }, CancellationToken.None);
        Assert.Equal(9003, created.OrderAbcNum);   // MAX(9002) + 1
        Assert.Equal("PO-NEW", (await _repo.GetOrderAsync(9003, CancellationToken.None))!.OrigCustomerPo);
    }

    [Fact]
    public async Task UpdateOrder_changes_and_unknown_returns_null()
    {
        var updated = await _repo.UpdateOrderAsync(9001,
            new CustomerOrderWrite { OrigCustomerId = 4001, EnduserPo = "EU-CHANGED" }, CancellationToken.None);
        Assert.Equal("EU-CHANGED", updated!.EnduserPo);
        Assert.Null(await _repo.UpdateOrderAsync(999999, new CustomerOrderWrite(), CancellationToken.None));
    }

    [Fact]
    public async Task CreateOrderItem_assigns_id_and_sets_created_timestamp()
    {
        var created = await _repo.CreateOrderItemAsync(
            new OrderItemWrite { EnduserPartNum = "PN-NEW", Alloy2 = "6061", UnitPrice = 2.0m }, CancellationToken.None);
        Assert.Equal(7004, created.OrderItemNum);   // MAX(7003) + 1
        Assert.Equal("PN-NEW", created.EnduserPartNum);
        Assert.NotNull(created.ItemCreatedDttm);     // server-assigned
    }

    [Fact]
    public async Task UpdateOrderItem_changes_and_unknown_returns_null()
    {
        var updated = await _repo.UpdateOrderItemAsync(7001,
            new OrderItemWrite { EnduserPartNum = "PN-3003-A", UnitPrice = 9.99m }, CancellationToken.None);
        Assert.Equal(9.99m, updated!.UnitPrice);
        Assert.Null(await _repo.UpdateOrderItemAsync(999999,
            new OrderItemWrite { EnduserPartNum = "X" }, CancellationToken.None));
    }

    [Fact]
    public async Task WriteAudit_then_read_returns_newest_first()
    {
        await _repo.WriteAuditAsync("TEST /api/thing", success: true, "HTTP 200", CancellationToken.None);
        var log = await _repo.GetAuditLogAsync(1, 25, source: null, orderBy: null, CancellationToken.None);
        Assert.Equal(3, log.TotalCount);             // 2 seeded + 1 written
        Assert.Equal("TEST /api/thing", log.Items[0].Source);   // ordered by id DESC
        Assert.Equal(1, log.Items[0].Success);

        var filtered = await _repo.GetAuditLogAsync(1, 25, source: "TEST", orderBy: null, CancellationToken.None);
        Assert.Single(filtered.Items);
    }

    [Fact]
    public async Task CreateJob_assigns_next_id_and_sets_create_date()
    {
        var created = await _repo.CreateJobAsync(
            new JobWrite { OrderAbcNum = 9001, LineNum = 110, JobStatus = 0, JobNotes = "new job" }, CancellationToken.None);
        Assert.Equal(1004, created.AbJobNum);   // MAX(1003) + 1
        Assert.NotNull(created.CreateDate);
        Assert.Equal("new job", created.JobNotes);
    }

    [Fact]
    public async Task CreateCoil_assigns_next_id_and_persists()
    {
        var created = await _repo.CreateCoilAsync(
            new CoilWrite { CoilAlloy2 = "6061", CoilGauge = 0.25m, NetWt = 15000m, CoilStatus = 1 }, CancellationToken.None);
        Assert.Equal(5005, created.CoilAbcNum);   // MAX(5004) + 1
        Assert.Equal("6061", created.CoilAlloy2);
        Assert.NotNull(created.CoilEntryDate);
    }

    [Fact]
    public async Task CreateSheetSkid_and_GetById_round_trip()
    {
        var created = await _repo.CreateSheetSkidAsync(
            new SheetSkidWrite { AbJobNum = 1001, SheetNetWt = 1990m, SkidPieces = 100 }, CancellationToken.None);
        Assert.Equal(3004, created.SheetSkidNum);   // MAX(3003) + 1

        var fetched = await _repo.GetSheetSkidAsync(3004, CancellationToken.None);
        Assert.Equal(1001, fetched!.AbJobNum);
    }

    [Fact]
    public async Task CreateScrapSkid_assigns_next_id()
    {
        var created = await _repo.CreateScrapSkidAsync(
            new ScrapSkidWrite { ScrapAbJobNum = "1001", ScrapAlloy2 = "3003", ScrapNetWt = 75m }, CancellationToken.None);
        Assert.Equal(8003, created.ScrapSkidNum);   // MAX(8002) + 1
        Assert.Equal("1001", created.ScrapAbJobNum);
    }

    // ---- Order-entry pilot support -------------------------------------

    [Fact]
    public async Task GetOrderItemsByOrder_returns_lines_for_order()
    {
        var items = await _repo.GetOrderItemsByOrderAsync(9001, CancellationToken.None);
        Assert.Equal(2, items.Count);
        Assert.All(items, i => Assert.Equal(9001, i.OrderAbcNum));
    }

    [Fact]
    public async Task GetOrderDetail_resolves_header_customer_and_items()
    {
        var detail = await _repo.GetOrderDetailAsync(9001, CancellationToken.None);
        Assert.NotNull(detail);
        Assert.Equal(9001, detail!.Order.OrderAbcNum);
        Assert.Equal(4001, detail.Customer!.CustomerId);
        Assert.Equal(2, detail.Items.Count);

        Assert.Null(await _repo.GetOrderDetailAsync(999999, CancellationToken.None));
    }

    [Fact]
    public async Task GetOrders_filters_by_customer_and_po()
    {
        var byCust = await _repo.GetOrdersAsync(1, 25, customerId: 4001, po: null, orderBy: null, CancellationToken.None);
        Assert.Equal(1, byCust.TotalCount);
        Assert.Equal(9001, byCust.Items[0].OrderAbcNum);

        var byPo = await _repo.GetOrdersAsync(1, 25, customerId: null, po: "PO-AB-1002", orderBy: null, CancellationToken.None);
        Assert.Equal(9002, byPo.Items.Single().OrderAbcNum);
    }

    [Fact]
    public async Task CreateOrderWithItems_creates_header_and_linked_items()
    {
        var detail = await _repo.CreateOrderWithItemsAsync(new OrderCreateWithItems
        {
            Order = new CustomerOrderWrite { OrigCustomerId = 4001, OrigCustomerPo = "PO-COMBO" },
            Items =
            [
                new OrderItemWrite { EnduserPartNum = "PN-A", Alloy2 = "3003" },
                new OrderItemWrite { EnduserPartNum = "PN-B", Alloy2 = "5052" }
            ]
        }, CancellationToken.None);

        Assert.Equal(9003, detail.Order.OrderAbcNum);          // MAX(9002) + 1
        Assert.Equal(2, detail.Items.Count);
        Assert.All(detail.Items, i => Assert.Equal(9003, i.OrderAbcNum));   // stamped by server
        Assert.Equal(4001, detail.Customer!.CustomerId);
    }

    [Fact]
    public async Task GetAlloys_returns_distinct_seeded_alloys()
    {
        var alloys = await _repo.GetAlloysAsync(CancellationToken.None);
        Assert.Contains("3003", alloys);
        Assert.Contains("5052", alloys);
        Assert.Equal(alloys.Distinct().Count(), alloys.Count);
    }

    // ---- Coil inventory (inv_coil pilot support) -----------------------

    [Fact]
    public async Task GetCoils_filters_by_alloy_and_location()
    {
        var byAlloy = await _repo.GetCoilsAsync(1, 25, null, alloy: "3003", null, null, orderBy: null, CancellationToken.None);
        Assert.Equal(2, byAlloy.TotalCount);
        Assert.All(byAlloy.Items, c => Assert.Equal("3003", c.CoilAlloy2));

        var byLoc = await _repo.GetCoilsAsync(1, 25, null, null, location: "A-", null, orderBy: null, CancellationToken.None);
        Assert.Equal(2, byLoc.TotalCount);   // A-01, A-02
    }

    [Fact]
    public async Task GetCoilProcessing_returns_job_usage()
    {
        var usage = await _repo.GetCoilProcessingAsync(5001, CancellationToken.None);
        Assert.Single(usage);
        Assert.Equal(1001, usage[0].AbJobNum);
        Assert.Equal(110, usage[0].JobLineNum);   // joined from ab_job
    }

    [Fact]
    public async Task GetCoilInventorySummary_rolls_up_weight_by_alloy()
    {
        var summary = await _repo.GetCoilInventorySummaryAsync("alloy", CancellationToken.None);
        var g3003 = summary.Single(x => x.Key == "3003");
        Assert.Equal(2, g3003.Count);
        Assert.Equal(23000m, g3003.TotalNetWt);   // 12000 + 11000
        Assert.Equal(2, summary.Single(x => x.Key == "5052").Count);
    }

    // ---- Sorting --------------------------------------------------------

    [Fact]
    public async Task GetCoils_orders_by_supplied_clause()
    {
        // net_wt ascending: 9000 (5003), 9500 (5004), 11000 (5002), 12000 (5001).
        var asc = await _repo.GetCoilsAsync(1, 25, null, null, null, null, orderBy: "net_wt ASC, coil_abc_num", CancellationToken.None);
        Assert.Equal(5003, asc.Items[0].CoilAbcNum);
        Assert.Equal(5001, asc.Items[^1].CoilAbcNum);

        var desc = await _repo.GetCoilsAsync(1, 25, null, null, null, null, orderBy: "net_wt DESC, coil_abc_num", CancellationToken.None);
        Assert.Equal(5001, desc.Items[0].CoilAbcNum);
    }

    [Fact]
    public void Sort_resolves_allowlisted_field_with_tiebreaker()
    {
        Assert.True(Sort.TryResolve("coils", "netWt", "asc", out var orderBy, out var problems));
        Assert.Null(problems);
        Assert.Equal("net_wt ASC, coil_abc_num", orderBy);
    }

    [Fact]
    public void Sort_defaults_when_no_field_supplied()
    {
        Assert.True(Sort.TryResolve("jobs", null, null, out var orderBy, out _));
        Assert.Equal("ab_job_num", orderBy);
    }

    [Fact]
    public void Sort_rejects_unknown_field_and_bad_direction()
    {
        Assert.False(Sort.TryResolve("jobs", "dropTable", null, out _, out var p1));
        Assert.True(p1!.ContainsKey("sort"));

        Assert.False(Sort.TryResolve("jobs", "jobStatus", "sideways", out _, out var p2));
        Assert.True(p2!.ContainsKey("dir"));
    }

    // ---- Readiness ------------------------------------------------------

    [Fact]
    public async Task Ping_returns_true_against_a_live_fixture()
    {
        Assert.True(await _repo.PingAsync(CancellationToken.None));
    }

    // ---- QA test-result filters ----------------------------------------

    [Fact]
    public async Task GetTestResults_filters_by_position()
    {
        var m = await _repo.GetTestResultsAsync(1, 25, testType: null, position: "M", from: null, to: null, orderBy: null, CancellationToken.None);
        Assert.Single(m.Items);
        Assert.Equal(46.0m, m.Items[0].YtsVal);
    }

    [Fact]
    public async Task GetTestResults_filters_by_date_range()
    {
        // Seeded created_date values: base (08:00), +1h, +2h.
        var baseDate = new DateTime(2026, 1, 2, 8, 0, 0, DateTimeKind.Unspecified);
        var ranged = await _repo.GetTestResultsAsync(1, 25, testType: null, position: null,
            from: baseDate.AddMinutes(30), to: baseDate.AddHours(5), orderBy: null, CancellationToken.None);
        Assert.Equal(2, ranged.TotalCount);   // the +1h and +2h rows
    }

    // ---- temp_test_result (in-progress QA) -----------------------------

    [Fact]
    public async Task GetTempTestResults_lists_and_filters_by_position()
    {
        var all = await _repo.GetTempTestResultsAsync(1, 25, null, null, null, null, null, CancellationToken.None);
        Assert.Equal(2, all.TotalCount);

        var m = await _repo.GetTempTestResultsAsync(1, 25, null, position: "M", from: null, to: null, orderBy: null, CancellationToken.None);
        Assert.Single(m.Items);
        Assert.Equal(41.0m, m.Items[0].Yts);   // temp table uses 'yts', not 'yts_val'
    }

    // ---- process_partial_skid ------------------------------------------

    [Fact]
    public async Task GetPartialSkids_lists_all_and_filters_by_job()
    {
        var all = await _repo.GetPartialSkidsAsync(1, 25, null, CancellationToken.None);
        Assert.Equal(3, all.TotalCount);

        var job1001 = await _repo.GetJobPartialSkidsAsync(1001, CancellationToken.None);
        Assert.Equal(2, job1001.Count);
        Assert.All(job1001, s => Assert.Equal(1001, s.AbJobNum));
    }

    public void Dispose()
    {
        try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
    }
}
