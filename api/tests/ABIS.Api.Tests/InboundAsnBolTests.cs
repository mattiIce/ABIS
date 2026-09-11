using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The archived inbound ASN BOL browser.
///
/// <para><b>What it ports.</b> The "Archived BOL" button on legacy's coil inventory window
/// (<c>w_inv_coil</c> → <c>w_archived_bol</c> / <c>d_archived_bol</c>): a customer's inbound shipments —
/// <c>inbound_shipment</c> ⋈ <c>inbound_shipment_status</c> (status not 0) ⋈ <c>inbound_shipment_customer</c>
/// on ship-from. The coil drill-in reads <c>inbound_coil</c>; legacy's drill-in window is not vendored.</para>
///
/// <para>Each test gets its own database; rows are inserted after the host starts, because startup is what
/// creates and seeds it.</para>
/// </summary>
public sealed class InboundAsnBolTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_asn_{Guid.NewGuid():N}.db");
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

    private static HttpClient Client(Factory f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        Exec(f, Seed);
        return c;
    }

    private static void Exec(Factory f, string sql)
    {
        using var conn = new SqliteConnection($"Data Source={f.DbPath}");
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = sql;
        cmd.ExecuteNonQuery();
    }

    /// <summary>
    /// Customer 7001 ships from MILL-A. Its BOLs: B-OLD (2025), B-NEW (2026, two coils), B-NULL (no received
    /// time — ~1,660 of these on .230), B-ZERO (status 0, which legacy hides) and B-NOSTATUS (no status row).
    /// Customer 7002 ships from MILL-B: one BOL that must never show for 7001.
    /// </summary>
    private const string Seed = """
        INSERT INTO inbound_shipment_customer (customer_id, ship_from) VALUES (7001, 'MILL-A'), (7002, 'MILL-B');
        INSERT INTO inbound_shipment (edi_file_id, bol, ship_from, total_weight) VALUES
            (501, 'B-OLD', 'MILL-A', 30000), (502, 'B-NEW', 'MILL-A', 41000), (503, 'B-NULL', 'MILL-A', 12000),
            (504, 'B-ZERO', 'MILL-A', 9000), (505, 'B-NOSTATUS', 'MILL-A', 8000), (506, 'B-OTHER', 'MILL-B', 7000);
        INSERT INTO inbound_shipment_status (edi_file_id, bol, status, received_time) VALUES
            (501, 'B-OLD', 1, '2025-01-15 00:00:00'), (502, 'B-NEW', 3, '2026-08-01 00:00:00'),
            (503, 'B-NULL', 1, NULL), (504, 'B-ZERO', 0, '2026-08-20 00:00:00'),
            (506, 'B-OTHER', 1, '2026-08-19 00:00:00');
        INSERT INTO inbound_coil (edi_file_id, bol, item_num, coil_number, alloy, temper, net_weight, gross_weight, coil_gauge, coil_width, lot)
        VALUES (502, 'B-NEW', 2, 'MC-2', '5182', 'H19', 20600, 20900, 0.0106, 62.0, 'L2'),
               (502, 'B-NEW', 1, 'MC-1', '5182', 'H19', 20400, 20700, 0.0106, 62.0, 'L1'),
               (501, 'B-OLD', 1, 'MC-9', '3104', 'H19', 30000, 30300, 0.0112, 60.5, 'L9');
        """;

    private static async Task<JsonElement> List(HttpClient c, string query) =>
        await c.GetFromJsonAsync<JsonElement>($"/api/inbound-asns?{query}");

    private static List<string?> Bols(JsonElement page) =>
        page.GetProperty("items").EnumerateArray().Select(b => b.GetProperty("bol").GetString()).ToList();

    [Fact]
    public async Task Lists_the_customers_bols_newest_received_first_with_undated_ones_last()
    {
        using var f = new Factory();
        var c = Client(f);

        var page = await List(c, "customerId=7001");

        // Not B-ZERO (status 0), not B-NOSTATUS (no status row), not B-OTHER (another customer's mill).
        Assert.Equal(["B-NEW", "B-OLD", "B-NULL"], Bols(page));
        Assert.Equal(3, page.GetProperty("totalCount").GetInt32());
        var newest = page.GetProperty("items")[0];
        Assert.Equal(502, newest.GetProperty("ediFileId").GetInt64());
        Assert.Equal(2, newest.GetProperty("coilCount").GetInt32());
        Assert.Equal(41000m, newest.GetProperty("totalWeight").GetDecimal());
        Assert.Equal(JsonValueKind.Null, page.GetProperty("items")[2].GetProperty("receivedTime").ValueKind);
    }

    [Fact]
    public async Task Another_customers_mill_is_not_listed()
    {
        using var f = new Factory();
        var c = Client(f);

        Assert.Equal(["B-OTHER"], Bols(await List(c, "customerId=7002")));
    }

    [Fact]
    public async Task The_bol_filter_matches_part_of_the_number_in_any_case()
    {
        using var f = new Factory();
        var c = Client(f);

        var page = await List(c, "customerId=7001&bol=new");

        Assert.Equal(["B-NEW"], Bols(page));
        Assert.Equal(1, page.GetProperty("totalCount").GetInt32());
    }

    [Fact]
    public async Task Pages_carry_the_full_count()
    {
        using var f = new Factory();
        var c = Client(f);

        var first = await List(c, "customerId=7001&pageSize=2");
        var second = await List(c, "customerId=7001&pageSize=2&page=2");

        Assert.Equal(["B-NEW", "B-OLD"], Bols(first));
        Assert.Equal(["B-NULL"], Bols(second));
        Assert.Equal(3, second.GetProperty("totalCount").GetInt32());
    }

    [Fact]
    public async Task A_customer_is_required()
    {
        using var f = new Factory();
        var c = Client(f);

        Assert.Equal(HttpStatusCode.BadRequest, (await c.GetAsync("/api/inbound-asns")).StatusCode);
        Assert.Equal(HttpStatusCode.BadRequest, (await c.GetAsync("/api/inbound-asns?customerId=0")).StatusCode);
    }

    [Fact]
    public async Task The_drill_in_lists_the_asns_coils_in_item_order()
    {
        using var f = new Factory();
        var c = Client(f);

        var coils = (await c.GetFromJsonAsync<JsonElement>("/api/inbound-asns/502/coils?bol=B-NEW")).EnumerateArray().ToList();

        Assert.Equal(["MC-1", "MC-2"], coils.Select(x => x.GetProperty("coilNumber").GetString()).ToList());
        Assert.Equal("5182", coils[0].GetProperty("alloy").GetString());
        Assert.Equal(20400m, coils[0].GetProperty("netWeight").GetDecimal());
        Assert.Equal("L1", coils[0].GetProperty("lot").GetString());
    }

    [Fact]
    public async Task The_drill_in_is_keyed_by_file_and_bol_together()
    {
        using var f = new Factory();
        var c = Client(f);

        // File 502 with B-OLD's number: neither ASN.
        Assert.Empty((await c.GetFromJsonAsync<JsonElement>("/api/inbound-asns/502/coils?bol=B-OLD")).EnumerateArray());
        Assert.Equal(HttpStatusCode.BadRequest, (await c.GetAsync("/api/inbound-asns/502/coils")).StatusCode);
    }
}
