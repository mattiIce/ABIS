using System.Linq;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The shell's global search box, and the Parts page's part-number search.
///
/// <para>Both existed as promises before 2026-08-21 and neither worked. The header box carried the
/// placeholder "Search POs, jobs, coils, EDI…", a <c>/</c> shortcut that focused it, and no handler at
/// all — you typed, pressed Enter, and nothing happened. The Parts page had a filter box that looked
/// like a part-number search but only filtered the 50 rows already fetched, so it answered "0 of 50"
/// for parts that exist. Reporting "not found" when the truth is "not on this page" is the kind of
/// wrong answer people believe.</para>
///
/// <para>Fixture parts: 6001 <c>PN-3003-A</c> (customer 4001), 6002 <c>PN-5052-B</c> (4001),
/// 6003 <c>PN-3003-C</c> (4002). Orders 9001 <c>PO-AB-1001</c> and 9002 <c>PO-AB-1002</c>. Job 990.</para>
/// </summary>
public sealed class QuickSearchTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        private readonly string _dbPath = Path.Combine(Path.GetTempPath(), $"abis_qsearch_{Guid.NewGuid():N}.db");
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={_dbPath}");
            builder.UseSetting("Database:Seed", "true");
            builder.UseSetting("ApiKeys:Enabled", "true");
            builder.UseSetting("ApiKeys:Keys:0", "test-key");
        }
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
        }
    }

    private static HttpClient Client(WebApplicationFactory<Program> f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        return c;
    }

    private sealed record Hit(string Kind, string Id, string Label, string Url);

    /// <summary>Run a quick search. A null <c>login</c> is a pure API-key service account, which resolves
    /// to no user and so is shown every category — the same fail-open the nav uses when it cannot
    /// identify the caller.</summary>
    private static async Task<List<Hit>> SearchAsync(HttpClient c, string q, string? login = null)
    {
        var req = new HttpRequestMessage(HttpMethod.Get, $"/api/search/quick?q={Uri.EscapeDataString(q)}");
        if (login is not null) req.Headers.Add("X-User-Login", login);
        var res = await c.SendAsync(req);
        res.EnsureSuccessStatusCode();
        var body = await res.Content.ReadFromJsonAsync<JsonElement>();
        return body.EnumerateArray()
            .Select(h => new Hit(
                h.GetProperty("kind").GetString()!,
                h.GetProperty("id").GetString()!,
                h.GetProperty("label").GetString()!,
                h.GetProperty("url").GetString()!))
            .ToList();
    }

    [Fact]
    public async Task An_empty_term_returns_nothing_rather_than_everything()
    {
        using var f = new Factory();
        Assert.Empty(await SearchAsync(Client(f), "   "));
    }

    /// <summary>The headline case: a customer's part number, typed into the header box.</summary>
    [Fact]
    public async Task A_customer_part_number_finds_the_part_and_deep_links_to_the_parts_page()
    {
        using var f = new Factory();
        var hits = await SearchAsync(Client(f), "PN-5052-B");

        var part = Assert.Single(hits, h => h.Kind == "part");
        Assert.Equal("6002", part.Id);
        Assert.Contains("PN-5052-B", part.Label);
        // The URL must carry the term, not just name the page: landing on an unfiltered list is the
        // same failure as the old Parts filter box, one click later.
        Assert.StartsWith("/ui/parts.html?q=", part.Url);
        Assert.Contains("PN-5052-B", Uri.UnescapeDataString(part.Url));
    }

    /// <summary>A customer quotes their PO on the phone, not our order number.</summary>
    [Fact]
    public async Task A_customer_po_finds_the_order()
    {
        using var f = new Factory();
        var hits = await SearchAsync(Client(f), "PO-AB-1001");

        var order = Assert.Single(hits, h => h.Kind == "order");
        Assert.Equal("9001", order.Id);
        Assert.Contains("PO-AB-1001", order.Label);
        Assert.StartsWith("/ui/order-entry.html?q=", order.Url);
    }

    /// <summary>Digits are ambiguous — id or customer-side number — so both are tried.</summary>
    [Fact]
    public async Task A_numeric_term_is_tried_as_an_identifier_in_every_category()
    {
        using var f = new Factory();
        var c = Client(f);

        Assert.Contains(await SearchAsync(c, "6001"), h => h.Kind == "part" && h.Id == "6001");
        Assert.Contains(await SearchAsync(c, "990"), h => h.Kind == "job" && h.Id == "990");
        Assert.Contains(await SearchAsync(c, "9002"), h => h.Kind == "order" && h.Id == "9002");
    }

    /// <summary>A job has no customer-side identifier, so words can never name one.</summary>
    [Fact]
    public async Task A_non_numeric_term_never_produces_a_job_hit()
    {
        using var f = new Factory();
        Assert.DoesNotContain(await SearchAsync(Client(f), "PN-3003"), h => h.Kind == "job");
    }

    /// <summary>Customer part numbers are the customer's format, not ours: somebody looking for a
    /// fragment in the wrong case should still find it.</summary>
    [Fact]
    public async Task Matching_is_case_insensitive_and_unanchored()
    {
        using var f = new Factory();
        var parts = (await SearchAsync(Client(f), "pn-3003")).Where(h => h.Kind == "part").ToList();

        Assert.Equal(2, parts.Count);
        Assert.Contains(parts, h => h.Id == "6001");
        Assert.Contains(parts, h => h.Id == "6003");
    }

    /// <summary>
    /// The box must not offer to take somebody to a page their sidebar does not show them.
    ///
    /// <para>jsmith holds a direct Write grant on "Order Entry" and nothing else, so orders are the only
    /// category they can be offered — even though the part exists and the underlying GET is ungated.
    /// mlee holds only "User Control", which maps to no searchable category at all.</para>
    ///
    /// <para>This is nav parity, NOT a security boundary: reads are ungated across the whole API, so
    /// either user could still call /api/parts directly. The test exists so the box and the sidebar can
    /// never drift into disagreeing about the same person.</para>
    /// </summary>
    [Fact]
    public async Task The_box_offers_only_the_categories_the_users_nav_shows()
    {
        using var f = new Factory();
        var c = Client(f);

        var jsmithOnAPart = await SearchAsync(c, "PN-3003-A", "jsmith");
        Assert.DoesNotContain(jsmithOnAPart, h => h.Kind == "part");

        var jsmithOnAnOrder = await SearchAsync(c, "PO-AB-1001", "jsmith");
        Assert.Contains(jsmithOnAnOrder, h => h.Kind == "order");

        // No searchable grant at all -> the box finds nothing, rather than quietly ignoring the gate.
        Assert.Empty(await SearchAsync(c, "PN-3003-A", "mlee"));

        // The service account cannot be resolved to a user, so it fails open exactly as the nav does.
        Assert.Contains(await SearchAsync(c, "PN-3003-A"), h => h.Kind == "part");
    }

    // ---- The Parts page's own search --------------------------------------

    private static async Task<JsonElement> PartsAsync(HttpClient c, string query) =>
        await c.GetFromJsonAsync<JsonElement>($"/api/parts?{query}");

    [Fact]
    public async Task Part_search_matches_the_customer_part_number()
    {
        using var f = new Factory();
        var body = await PartsAsync(Client(f), "search=PN-5052");

        var ids = body.GetProperty("items").EnumerateArray()
            .Select(i => i.GetProperty("partNumId").GetInt64()).ToList();
        Assert.Equal(new[] { 6002L }, ids);
    }

    [Fact]
    public async Task Part_search_matches_the_abis_part_id()
    {
        using var f = new Factory();
        var body = await PartsAsync(Client(f), "search=6003");

        var ids = body.GetProperty("items").EnumerateArray()
            .Select(i => i.GetProperty("partNumId").GetInt64()).ToList();
        Assert.Contains(6003L, ids);
    }

    /// <summary>
    /// The actual defect. The old page filtered rows it had already fetched, so a part beyond the first
    /// page simply did not exist as far as the operator could tell. The search has to reach the database
    /// and narrow the TOTAL — if totalCount still counted every part, the count under the table would
    /// keep saying "0 of 50" while the matching row sat on page 3.
    /// </summary>
    [Fact]
    public async Task Part_search_narrows_the_total_not_just_the_current_page()
    {
        using var f = new Factory();
        var c = Client(f);

        var all = await PartsAsync(c, "pageSize=1");
        var one = await PartsAsync(c, "pageSize=1&search=PN-5052-B");

        Assert.Equal(1, one.GetProperty("totalCount").GetInt64());
        Assert.True(all.GetProperty("totalCount").GetInt64() > 1,
            "fixture should hold more than one part, or this proves nothing");
    }

    [Fact]
    public async Task Part_search_composes_with_the_existing_filters()
    {
        using var f = new Factory();
        // 6001 and 6003 both match "PN-3003"; only 6001 belongs to customer 4001.
        var body = await PartsAsync(Client(f), "search=PN-3003&customerId=4001");

        var ids = body.GetProperty("items").EnumerateArray()
            .Select(i => i.GetProperty("partNumId").GetInt64()).ToList();
        Assert.Equal(new[] { 6001L }, ids);
    }
}
