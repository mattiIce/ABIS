using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// A coil's flaws say what the codes mean.
///
/// <para><b>What it ports.</b> Legacy's coil-quality window (<c>w_inv_coil</c> → <c>w_ff_data_4coil</c> /
/// <c>d_ff_data_4coil</c>) joins <c>flaw_codes</c> and <c>handling_codes</c>, so an inspector reads
/// "Surface - Scratches" and "Crop Out" rather than <c>2</c> and <c>X</c>. ABIS showed the bare codes.</para>
///
/// <para><b>Live data:</b> 6,172 flaw rows on <c>.230</c> across 9 codes, nearly all carrying a handling code,
/// and every one resolves — there are no orphan codes. The two vocabularies (10 and 3 rows) are seeded into the
/// fixture verbatim, as reference data rather than invented labels.</para>
///
/// <para>An unlisted code keeps its raw value and gains no text: inventing a meaning for a flaw the mill did
/// not describe is how a coil gets cropped for the wrong reason.</para>
/// </summary>
public sealed class CoilQualityFlawDecodeTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_flaw_{Guid.NewGuid():N}.db");
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

    private static void Exec(Factory f, string sql)
    {
        using var conn = new SqliteConnection($"Data Source={f.DbPath}");
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = sql;
        cmd.ExecuteNonQuery();
    }

    /// <summary>Coil 5001 gets three flaws: a scratch handled by inspection, a lamination cropped out, and one
    /// carrying a code the mill's list does not contain.</summary>
    private static HttpClient Client(Factory f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        Exec(f, """
            INSERT INTO coil_quality (coil_abc_num, coil_org_num, part_num, material_grade, net_coil_length, net_coil_length_uom)
            VALUES (5001, 'ORG-1', 'PN-1', '5182-O', 146142, 'inches');
            INSERT INTO coil_quality_flaw_mapping (coil_abc_num, coil_org_num, starting_position, ending_position,
                                                   flaw_code, starting_position_uom, ending_position_uom, handling_code)
            VALUES (5001, 'ORG-1', 120, 360, '2', 'inches', 'inches', 'A'),
                   (5001, 'ORG-1', 1200, 1440, '4', 'inches', 'inches', 'X'),
                   (5001, 'ORG-1', 2400, 2640, 'ZZ', 'inches', 'inches', 'Q');
            """);
        return c;
    }

    private static async Task<List<JsonElement>> Flaws(HttpClient c) =>
        (await c.GetFromJsonAsync<JsonElement>("/api/coils/5001/quality"))
            .GetProperty("flaws").EnumerateArray().ToList();

    [Fact]
    public async Task A_flaw_carries_the_mills_own_words_for_its_code()
    {
        using var f = new Factory();
        var flaws = await Flaws(Client(f));

        Assert.Equal("Surface - Scratches", flaws[0].GetProperty("flawReason").GetString());
        Assert.Equal("Visually Inspect Top & Bottom. Crop Out or FF as Necessary",
            flaws[0].GetProperty("handlingCodeName").GetString());
        Assert.Equal("Surface - Laminations", flaws[1].GetProperty("flawReason").GetString());
        Assert.Equal("Crop Out", flaws[1].GetProperty("handlingCodeName").GetString());
    }

    /// <summary>A code the mill does not list keeps its raw value and gains no invented meaning.</summary>
    [Fact]
    public async Task An_unlisted_code_is_reported_without_inventing_a_meaning()
    {
        using var f = new Factory();
        var unlisted = (await Flaws(Client(f))).Single(x => x.GetProperty("flawCode").GetString() == "ZZ");

        Assert.Equal(JsonValueKind.Null, unlisted.GetProperty("flawReason").ValueKind);
        Assert.Equal(JsonValueKind.Null, unlisted.GetProperty("handlingCodeName").ValueKind);
        Assert.Equal("Q", unlisted.GetProperty("handlingCode").GetString());
    }

    /// <summary>Decoding must not drop or duplicate a flaw — the join is to two single-row lookups.</summary>
    [Fact]
    public async Task Decoding_returns_each_flaw_exactly_once_in_position_order()
    {
        using var f = new Factory();
        var flaws = await Flaws(Client(f));

        Assert.Equal(3, flaws.Count);
        Assert.Equal([120m, 1200m, 2400m],
            flaws.Select(x => x.GetProperty("startingPosition").GetDecimal()).ToList());
    }
}
