using System.Net;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>Verifies the fixed-window rate limiter on the <c>/api</c> group. Uses a
/// dedicated host with a low permit limit supplied via in-memory configuration
/// (added after the env-var provider, so it wins and never leaks into the other
/// test factories' process-wide environment variables).</summary>
public sealed class RateLimitTests : IClassFixture<RateLimitTests.LowLimitFactory>
{
    private readonly LowLimitFactory _factory;

    public RateLimitTests(LowLimitFactory factory) => _factory = factory;

    [Fact]
    public async Task Exceeding_the_window_limit_yields_429()
    {
        var client = _factory.CreateClient();
        client.DefaultRequestHeaders.Add("X-Api-Key", "test-key");

        var statuses = new List<HttpStatusCode>();
        for (var i = 0; i < 6; i++)
            statuses.Add((await client.GetAsync("/api/jobs")).StatusCode);

        Assert.Contains(HttpStatusCode.OK, statuses);                 // first few allowed (limit 3)
        Assert.Contains(HttpStatusCode.TooManyRequests, statuses);    // the rest rejected
    }

    public sealed class LowLimitFactory : WebApplicationFactory<Program>
    {
        private readonly string _dbPath = Path.Combine(Path.GetTempPath(), $"abis_rl_{Guid.NewGuid():N}.db");

        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            // UseSetting feeds the host configuration that WebApplicationBuilder reads
            // (ConfigureAppConfiguration is not reliably picked up under minimal hosting).
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={_dbPath}");
            builder.UseSetting("Database:Seed", "true");
            builder.UseSetting("ApiKeys:Enabled", "true");
            builder.UseSetting("ApiKeys:Keys:0", "test-key");
            builder.UseSetting("RateLimiting:Enabled", "true");
            builder.UseSetting("RateLimiting:PermitLimit", "3");
            builder.UseSetting("RateLimiting:WindowSeconds", "30");
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
        }
    }
}
