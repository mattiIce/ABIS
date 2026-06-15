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
        var page = await _repo.GetJobsAsync(1, 25, status: null, CancellationToken.None);
        Assert.Equal(3, page.TotalCount);
        Assert.Equal(3, page.Items.Count);
    }

    [Fact]
    public async Task GetJobs_filters_by_status()
    {
        var page = await _repo.GetJobsAsync(1, 25, status: 1, CancellationToken.None);
        Assert.Equal(2, page.TotalCount);
        Assert.All(page.Items, j => Assert.Equal(1, j.JobStatus));
    }

    [Fact]
    public async Task GetJobs_paginates()
    {
        var p1 = await _repo.GetJobsAsync(1, 2, status: null, CancellationToken.None);
        Assert.Equal(3, p1.TotalCount);
        Assert.Equal(2, p1.Items.Count);
        Assert.Equal(2, p1.TotalPages);

        var p2 = await _repo.GetJobsAsync(2, 2, status: null, CancellationToken.None);
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
        var items = await _repo.GetOrderItemsAsync(1, 25, alloy: "3003", CancellationToken.None);
        Assert.Equal(2, items.TotalCount);
        Assert.All(items.Items, i => Assert.Equal("3003", i.Alloy2));
    }

    [Fact]
    public async Task GetTestResults_filters_by_type_and_orders_desc()
    {
        var all = await _repo.GetTestResultsAsync(1, 25, testType: null, CancellationToken.None);
        Assert.Equal(3, all.TotalCount);

        var t1 = await _repo.GetTestResultsAsync(1, 25, testType: 1, CancellationToken.None);
        Assert.Single(t1.Items);
        Assert.Equal(45.0m, t1.Items[0].YtsVal);
    }

    // ---- Expanded reads -------------------------------------------------

    [Fact]
    public async Task GetCustomers_lists_and_filters_by_name()
    {
        var all = await _repo.GetCustomersAsync(1, 25, name: null, CancellationToken.None);
        Assert.Equal(2, all.TotalCount);

        var acme = await _repo.GetCustomersAsync(1, 25, name: "ACME", CancellationToken.None);
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
        var log = await _repo.GetAuditLogAsync(1, 25, source: null, CancellationToken.None);
        Assert.Equal(3, log.TotalCount);             // 2 seeded + 1 written
        Assert.Equal("TEST /api/thing", log.Items[0].Source);   // ordered by id DESC
        Assert.Equal(1, log.Items[0].Success);

        var filtered = await _repo.GetAuditLogAsync(1, 25, source: "TEST", CancellationToken.None);
        Assert.Single(filtered.Items);
    }

    public void Dispose()
    {
        try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
    }
}
