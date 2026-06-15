using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>End-to-end HTTP tests that boot the real app (minimal-API pipeline,
/// DI, JSON serialization) against a unique seeded SQLite fixture.</summary>
public sealed class ApiSmokeTests : IClassFixture<ApiSmokeTests.ApiFactory>
{
    private readonly HttpClient _client;
    private readonly ApiFactory _factory;

    public ApiSmokeTests(ApiFactory factory)
    {
        _factory = factory;
        _client = factory.CreateClient();
        _client.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
    }

    [Fact]
    public async Task Health_is_ok()
    {
        var resp = await _client.GetAsync("/health");
        resp.EnsureSuccessStatusCode();
        var body = await resp.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal("ok", body.GetProperty("status").GetString());
    }

    [Fact]
    public async Task Api_request_without_key_is_401()
    {
        var bare = _factory.CreateClient();   // no X-Api-Key header
        var resp = await bare.GetAsync("/api/jobs");
        Assert.Equal(HttpStatusCode.Unauthorized, resp.StatusCode);
    }

    [Fact]
    public async Task Api_request_with_bad_key_is_401()
    {
        var bare = _factory.CreateClient();
        bare.DefaultRequestHeaders.Add("X-Api-Key", "wrong");
        var resp = await bare.GetAsync("/api/jobs");
        Assert.Equal(HttpStatusCode.Unauthorized, resp.StatusCode);
    }

    [Fact]
    public async Task Health_is_anonymous()
    {
        var bare = _factory.CreateClient();   // no key
        var resp = await bare.GetAsync("/health");
        resp.EnsureSuccessStatusCode();
    }

    [Fact]
    public async Task List_jobs_returns_paged_envelope()
    {
        var body = await _client.GetFromJsonAsync<JsonElement>("/api/jobs");
        Assert.Equal(3, body.GetProperty("totalCount").GetInt32());
        Assert.Equal(3, body.GetProperty("items").GetArrayLength());
    }

    [Fact]
    public async Task Get_job_returns_entity()
    {
        var body = await _client.GetFromJsonAsync<JsonElement>("/api/jobs/1001");
        Assert.Equal(1001, body.GetProperty("abJobNum").GetInt64());
    }

    [Fact]
    public async Task Get_unknown_job_is_404()
    {
        var resp = await _client.GetAsync("/api/jobs/999999");
        Assert.Equal(HttpStatusCode.NotFound, resp.StatusCode);
    }

    [Fact]
    public async Task Get_job_coils_returns_two()
    {
        var body = await _client.GetFromJsonAsync<JsonElement>("/api/jobs/1001/coils");
        Assert.Equal(2, body.GetArrayLength());
    }

    [Fact]
    public async Task Coils_status_filter_applies()
    {
        var body = await _client.GetFromJsonAsync<JsonElement>("/api/coils?status=3");
        Assert.Equal(1, body.GetProperty("totalCount").GetInt32());
    }

    [Fact]
    public async Task List_customers_returns_seeded()
    {
        var body = await _client.GetFromJsonAsync<JsonElement>("/api/customers");
        Assert.True(body.GetProperty("totalCount").GetInt32() >= 2);
    }

    [Fact]
    public async Task Get_job_skids_returns_two()
    {
        var body = await _client.GetFromJsonAsync<JsonElement>("/api/jobs/1001/skids");
        Assert.Equal(2, body.GetArrayLength());
    }

    [Fact]
    public async Task Create_customer_returns_201_and_is_retrievable()
    {
        var resp = await _client.PostAsJsonAsync("/api/customers", new { customerName = "DELTA EXTRUSIONS", customerShortName = "DELTA" });
        Assert.Equal(HttpStatusCode.Created, resp.StatusCode);
        Assert.NotNull(resp.Headers.Location);

        var created = await resp.Content.ReadFromJsonAsync<JsonElement>();
        var id = created.GetProperty("customerId").GetInt64();
        var fetched = await _client.GetFromJsonAsync<JsonElement>($"/api/customers/{id}");
        Assert.Equal("DELTA EXTRUSIONS", fetched.GetProperty("customerName").GetString());
    }

    [Fact]
    public async Task Create_customer_without_name_returns_400()
    {
        var resp = await _client.PostAsJsonAsync("/api/customers", new { customerShortName = "X" });
        Assert.Equal(HttpStatusCode.BadRequest, resp.StatusCode);
    }

    [Fact]
    public async Task Patch_job_updates_status()
    {
        var resp = await _client.PatchAsJsonAsync("/api/jobs/1002", new { jobStatus = 7 });
        resp.EnsureSuccessStatusCode();
        var body = await resp.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal(7, body.GetProperty("jobStatus").GetInt32());
    }

    [Fact]
    public async Task Patch_unknown_job_returns_404()
    {
        var resp = await _client.PatchAsJsonAsync("/api/jobs/999999", new { jobStatus = 1 });
        Assert.Equal(HttpStatusCode.NotFound, resp.StatusCode);
    }

    [Fact]
    public async Task Create_order_returns_201()
    {
        var resp = await _client.PostAsJsonAsync("/api/orders", new { origCustomerId = 4001, origCustomerPo = "PO-HTTP" });
        Assert.Equal(HttpStatusCode.Created, resp.StatusCode);
        Assert.NotNull(resp.Headers.Location);
    }

    [Fact]
    public async Task Create_order_item_without_part_returns_400()
    {
        var resp = await _client.PostAsJsonAsync("/api/order-items", new { alloy2 = "3003" });
        Assert.Equal(HttpStatusCode.BadRequest, resp.StatusCode);
    }

    [Fact]
    public async Task Mutating_requests_are_audited()
    {
        // A write...
        await _client.PostAsJsonAsync("/api/customers", new { customerName = "AUDITED CO" });
        // ...produces an audit-log entry for that route.
        var log = await _client.GetFromJsonAsync<JsonElement>("/api/audit-log?source=customers");
        Assert.True(log.GetProperty("totalCount").GetInt32() >= 1);
        var first = log.GetProperty("items")[0];
        Assert.Contains("/api/customers", first.GetProperty("source").GetString());
    }

    [Fact]
    public async Task Swagger_document_is_served()
    {
        var resp = await _client.GetAsync("/swagger/v1/swagger.json");
        resp.EnsureSuccessStatusCode();
        var doc = await resp.Content.ReadFromJsonAsync<JsonElement>();
        Assert.True(doc.GetProperty("paths").TryGetProperty("/api/jobs", out _));
    }

    /// <summary>Boots the app with env-var overrides pointing at a unique temp SQLite db.</summary>
    public sealed class ApiFactory : WebApplicationFactory<Program>
    {
        private readonly string _dbPath =
            Path.Combine(Path.GetTempPath(), $"abis_api_{Guid.NewGuid():N}.db");

        public ApiFactory()
        {
            // Environment variables outrank appsettings.json, so this reliably
            // redirects the app to an isolated, seeded fixture for the test run.
            Environment.SetEnvironmentVariable("ASPNETCORE_ENVIRONMENT", "Development");
            Environment.SetEnvironmentVariable("Database__Provider", "Sqlite");
            Environment.SetEnvironmentVariable("Database__ConnectionString", $"Data Source={_dbPath}");
            Environment.SetEnvironmentVariable("Database__Seed", "true");
            Environment.SetEnvironmentVariable("ApiKeys__Enabled", "true");
            Environment.SetEnvironmentVariable("ApiKeys__Keys__0", "test-key");
        }

        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
        }
    }
}
