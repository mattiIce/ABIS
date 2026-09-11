using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// Correcting the customer a coil is booked to.
///
/// <para><b>What it ports.</b> Legacy's receiving screen has a "Change customer" button
/// (<c>w_coil_receiving</c> <c>cb_change_cust</c> → <c>w_change_cust</c>, ticket 1108, 2021). It is in real
/// use: on <c>.230</c>, 1,020 minted coils carry a customer different from their receiving BOL's, none of
/// them through an ownership transfer, the most recent in July 2026.</para>
///
/// <para><b>A correction, not a transfer.</b> Moving a coil between customers is a documented event with a
/// certificate. This re-books a coil that was keyed to the wrong customer — which is why legacy put it on
/// the receiving screen.</para>
///
/// <para><b>What it adds over legacy</b>, which ran one bare <c>UPDATE</c> with no guard and no record:
/// a done/shipped/transferred coil is refused (the rule <c>PatchCoil</c> already applies), and who changed
/// it from what to what is written to <c>system_log</c> in the same transaction as the change. Access is
/// the app-wide gate on the "Coils" tag — Write on <c>Inventory(Coil)</c> for a signed-in user.</para>
///
/// <para>Fixture users: <c>jsmith</c> holds Write on <c>Inventory(Coil)</c> through the Operators group;
/// <c>mlee</c> is an Admin with no coil grant at all. Each test gets its own database, because these
/// re-book seeded coils that other tests read.</para>
/// </summary>
public sealed class CoilCustomerChangeTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_coilcust_{Guid.NewGuid():N}.db");
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={DbPath}");
            builder.UseSetting("Database:Seed", "true");
            builder.UseSetting("ApiKeys:Enabled", "true");
            builder.UseSetting("ApiKeys:Keys:0", "test-key");
        }
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            SqliteConnection.ClearAllPools();
            try { if (File.Exists(DbPath)) File.Delete(DbPath); } catch { /* best effort */ }
        }
    }

    private static HttpClient Client(WebApplicationFactory<Program> f, string? login = null)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        if (login is not null) c.DefaultRequestHeaders.Add("X-User-Login", login);
        return c;
    }

    private static Task<HttpResponseMessage> Change(HttpClient c, long coil, object body) =>
        c.PutAsJsonAsync($"/api/coils/{coil}/customer", body);

    private static async Task<long?> CustomerOf(HttpClient c, long coil)
    {
        var j = await c.GetFromJsonAsync<JsonElement>($"/api/coils/{coil}");
        return j.TryGetProperty("customerId", out var v) && v.ValueKind == JsonValueKind.Number ? v.GetInt64() : null;
    }

    /// <summary>Read the audit straight from the database — the point is that the row is really there.</summary>
    private static List<string> AuditRows(Factory f)
    {
        using var conn = new SqliteConnection($"Data Source={f.DbPath}");
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = "SELECT system_log_contents FROM system_log WHERE system_log_contents LIKE 'Coil % customer changed %'";
        using var r = cmd.ExecuteReader();
        var rows = new List<string>();
        while (r.Read()) rows.Add(r.GetString(0));
        return rows;
    }

    [Fact]
    public async Task Correcting_a_coil_customer_rebooks_it_and_reports_from_and_to()
    {
        using var f = new Factory();
        var c = Client(f, login: "jsmith");

        var r = await Change(c, 5001, new { customerId = 4002, note = "keyed to the wrong customer" });

        Assert.Equal(HttpStatusCode.OK, r.StatusCode);
        var body = await r.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal(4001, body.GetProperty("customerIdFrom").GetInt64());
        Assert.Equal(4002, body.GetProperty("customerIdTo").GetInt64());
        Assert.Equal("jsmith", body.GetProperty("changedBy").GetString());
        Assert.Equal(4002, await CustomerOf(c, 5001));
    }

    /// <summary>
    /// The audit is the addition that matters most — legacy's correction left no trace of who made it or
    /// what it replaced. It is written in the change's own transaction, so it cannot be lost after the
    /// change has landed.
    /// </summary>
    [Fact]
    public async Task The_change_is_recorded_with_who_from_and_to()
    {
        using var f = new Factory();
        var c = Client(f, login: "jsmith");

        Assert.Equal(HttpStatusCode.OK, (await Change(c, 5001, new { customerId = 4002, note = "keyed wrong" })).StatusCode);

        var row = Assert.Single(AuditRows(f));
        Assert.Equal("Coil 5001 customer changed from 4001 to 4002 by jsmith: keyed wrong", row);
    }

    /// <summary>
    /// The endpoint carries no gate of its own — it relies on the app-wide filter for the "Coils" tag. This
    /// proves that filter really covers it: a real user without Write on Inventory(Coil) is refused, and
    /// nothing is changed or recorded.
    /// </summary>
    [Fact]
    public async Task A_user_without_coil_inventory_write_is_refused()
    {
        using var f = new Factory();

        var r = await Change(Client(f, login: "mlee"), 5001, new { customerId = 4002 });

        Assert.Equal(HttpStatusCode.Forbidden, r.StatusCode);
        Assert.Equal(4001, await CustomerOf(Client(f), 5001));
        Assert.Empty(AuditRows(f));
    }

    /// <summary>
    /// Legacy had no guard. Re-booking a shipped coil would rewrite whose shipment it was; re-booking a
    /// transferred one would contradict the transfer certificate. Same terminal rule PatchCoil applies.
    /// </summary>
    [Theory]
    [InlineData(5005L, 4001L)]   // status 10 — shipped
    [InlineData(5006L, 4002L)]   // status 13 — transferred
    public async Task A_shipped_or_transferred_coil_is_refused_and_left_alone(long coil, long bookedTo)
    {
        using var f = new Factory();
        var c = Client(f);
        var other = bookedTo == 4001 ? 4002 : 4001;

        var r = await Change(c, coil, new { customerId = other });

        Assert.Equal(HttpStatusCode.Conflict, r.StatusCode);
        Assert.Equal(bookedTo, await CustomerOf(c, coil));
        Assert.Empty(AuditRows(f));
    }

    /// <summary>Every refusal happens before anything is written — no change, and no audit row claiming one.</summary>
    [Fact]
    public async Task Refusals_change_nothing_and_record_nothing()
    {
        using var f = new Factory();
        var c = Client(f);

        Assert.Equal(HttpStatusCode.BadRequest, (await Change(c, 5001, new { })).StatusCode);                          // no customer
        Assert.Equal(HttpStatusCode.BadRequest, (await Change(c, 5001, new { customerId = 999_999 })).StatusCode);     // unknown customer
        Assert.Equal(HttpStatusCode.BadRequest, (await Change(c, 5001, new { customerId = 4001 })).StatusCode);        // already booked there
        Assert.Equal(HttpStatusCode.NotFound, (await Change(c, 987_654_321, new { customerId = 4002 })).StatusCode);   // no such coil

        Assert.Equal(4001, await CustomerOf(c, 5001));
        Assert.Empty(AuditRows(f));
    }
}
