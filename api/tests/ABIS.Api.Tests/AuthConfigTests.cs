using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>GET /auth/config is anonymous and tells the browser SPA whether to run
/// an OIDC login flow (and against which provider) or fall back to the API key.</summary>
public sealed class AuthConfigTests
{
    private sealed class Factory(Action<IWebHostBuilder>? extra = null) : WebApplicationFactory<Program>
    {
        private readonly string _dbPath = Path.Combine(Path.GetTempPath(), $"abis_authcfg_{Guid.NewGuid():N}.db");
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={_dbPath}");
            builder.UseSetting("Database:Seed", "true");
            extra?.Invoke(builder);
        }
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
        }
    }

    [Fact]
    public async Task Reports_oidc_disabled_when_unconfigured()
    {
        using var factory = new Factory();
        var body = await (await factory.CreateClient().GetAsync("/auth/config"))
            .Content.ReadFromJsonAsync<JsonElement>();
        Assert.False(body.GetProperty("oidc").GetBoolean());
    }

    [Fact]
    public async Task Returns_provider_config_when_oidc_is_set()
    {
        using var factory = new Factory(b =>
        {
            b.UseSetting("Auth:Oidc:Authority", "https://login.example.com/realms/abis");
            b.UseSetting("Auth:Oidc:ClientId", "abis-spa");
            b.UseSetting("Auth:Oidc:Scope", "openid profile api://abis/.default");
        });

        var resp = await factory.CreateClient().GetAsync("/auth/config");
        Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        var body = await resp.Content.ReadFromJsonAsync<JsonElement>();
        Assert.True(body.GetProperty("oidc").GetBoolean());
        Assert.Equal("https://login.example.com/realms/abis", body.GetProperty("authority").GetString());
        Assert.Equal("abis-spa", body.GetProperty("clientId").GetString());
        Assert.Equal("openid profile api://abis/.default", body.GetProperty("scope").GetString());
    }

    [Fact]
    public async Task Is_anonymous_no_api_key_required()
    {
        using var factory = new Factory(b => b.UseSetting("ApiKeys:Enabled", "true"));
        // No X-Api-Key header at all → still 200 (the SPA needs this before it can authenticate).
        var resp = await factory.CreateClient().GetAsync("/auth/config");
        Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
    }
}
