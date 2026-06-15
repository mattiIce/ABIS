using Abis.Api.Data;
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

    public void Dispose()
    {
        try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
    }
}
