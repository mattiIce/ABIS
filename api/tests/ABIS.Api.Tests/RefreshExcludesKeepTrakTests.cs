using System.Linq;
using System.Text.RegularExpressions;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The weekly refresh must not delete the KeepTrak import.
///
/// <para><b>The exposure.</b> On 2026-08-21 ~15,300 rows were imported from the plant's live KeepTrak
/// database — 144 PM definitions and 13,703 completions going back to 2018, plus the whole equipment
/// hierarchy. Every one of the nine target tables is a plain DBO table: <c>groupdepartment</c>,
/// <c>pm</c>, <c>pmcompletions</c> and the rest. The Data Pump parfile excludes only
/// <c>LIKE 'ABIS%'</c>, so without an explicit exclude the next
/// <c>table_exists_action=replace</c> restores prod's dead 2010 copy over all of it.</para>
///
/// <para><b>Why this is guarded by a test rather than a repair.</b> Parts 3–7 of DB_REFRESH are all
/// repairable — the app re-adds features, columns and sequences at startup. This one is not: re-importing
/// needs the Access file, a Windows box with ACE OLEDB and a PowerShell script, none of which exist on
/// the database host. <b>The exclude is the entire defence</b>, so the thing worth testing is that it
/// still covers everything the import writes.</para>
///
/// <para>The failure mode this catches: somebody extends <c>keeptrak-import.ps1</c> to populate one more
/// table and does not add it to <c>KEEPTRAK_TABLES</c>. Nothing would look wrong until a refresh
/// silently emptied that table months later.</para>
/// </summary>
public class RefreshExcludesKeepTrakTests
{
    private static string RepoFile(params string[] parts)
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null && !Directory.Exists(Path.Combine(dir.FullName, "deploy")))
            dir = dir.Parent;
        Assert.NotNull(dir);
        return Path.Combine(new[] { dir!.FullName }.Concat(parts).ToArray());
    }

    /// <summary>Every table the import generator writes, read from the generator itself.</summary>
    private static HashSet<string> ImportTargets()
    {
        var ps1 = File.ReadAllText(RepoFile("tools", "keeptrak-import.ps1"));
        var targets = Regex.Matches(ps1, @"INSERT\s+INTO\s+([A-Za-z_][A-Za-z0-9_]*)", RegexOptions.IgnoreCase)
            .Select(m => m.Groups[1].Value.ToUpperInvariant())
            .ToHashSet();
        // A generator that suddenly writes nothing would make every assertion below vacuously pass.
        Assert.True(targets.Count >= 9, $"expected the import to write at least 9 tables, found {targets.Count}");
        return targets;
    }

    private static string RefreshScript() => File.ReadAllText(RepoFile("deploy", "refresh-nonprod.sh"));

    [Fact]
    public void Every_table_the_import_writes_is_excluded_from_the_refresh()
    {
        var script = RefreshScript();
        var excludeLine = script.Split('\n').FirstOrDefault(l => l.TrimStart().StartsWith("KEEPTRAK_TABLES="));
        Assert.False(excludeLine is null,
            "deploy/refresh-nonprod.sh has no KEEPTRAK_TABLES list — a refresh will delete the whole import.");

        foreach (var table in ImportTargets())
        {
            Assert.True(excludeLine!.Contains($"'{table}'", StringComparison.OrdinalIgnoreCase),
                $"{table} is written by the KeepTrak import but is NOT in KEEPTRAK_TABLES. "
                + "table_exists_action=replace will restore prod's copy over it on the next refresh.");
        }
    }

    /// <summary>Declaring the list is not enough — the parfile has to actually use it.</summary>
    [Fact]
    public void The_parfile_uses_the_exclude_list()
    {
        Assert.Contains("exclude=TABLE:\"IN (${KEEPTRAK_TABLES})\"", RefreshScript());
    }

    /// <summary>
    /// None of these tables start with ABIS, which is precisely why the pre-existing
    /// <c>LIKE 'ABIS%'</c> exclude never covered them. If that ever stops being true the reasoning in
    /// DB_REFRESH Part 8 needs revisiting rather than quietly still passing.
    /// </summary>
    [Fact]
    public void The_import_targets_are_legacy_tables_not_ABIS_owned_ones()
    {
        Assert.All(ImportTargets(), t =>
            Assert.False(t.StartsWith("ABIS", StringComparison.OrdinalIgnoreCase),
                $"{t} starts with ABIS and would already be excluded — Part 8's reasoning assumes none do."));
    }

    /// <summary>
    /// The import must clear its previous run by PROVENANCE, not by id range, on the three tables the
    /// application can also write.
    ///
    /// <para><c>pm</c>, <c>pm_actions</c> and <c>pmcompletions</c> mint ids with MAX(id)+1, so once the
    /// import has landed, every PM created or completed in ABIS also gets an id above the reserved
    /// offset. A <c>DELETE ... WHERE pm_id &gt;= 100000</c> would then destroy real maintenance work on
    /// the next re-import — and a re-import is exactly what a wiped refresh calls for, so the two
    /// failure modes compound.</para>
    ///
    /// <para>Raising the offset does not fix it; MAX+1 always climbs back into whatever range is
    /// reserved next. The marker is the only durable answer.</para>
    /// </summary>
    [Theory]
    [InlineData("pmcompletions")]
    [InlineData("pm_actions")]
    [InlineData("pm")]
    public void The_import_clears_app_writable_tables_by_marker_not_by_id_range(string table)
    {
        var ps1 = File.ReadAllText(RepoFile("tools", "keeptrak-import.ps1"));

        Assert.Contains($"DELETE FROM {table}", ps1);
        var deleteLine = ps1.Split('\n').First(l => l.Contains($"DELETE FROM {table}"));

        Assert.True(deleteLine.Contains("kt_ref IS NOT NULL", StringComparison.OrdinalIgnoreCase),
            $"the import clears {table} by id range, which would delete PM work done in ABIS "
            + "(these tables mint ids with MAX+1, so app rows land above the reserved offset too).");
        Assert.DoesNotContain("$IdOffset", deleteLine);
    }

    /// <summary>
    /// The marker has to actually be written, or the provenance-scoped DELETE above silently clears
    /// nothing and every re-import duplicates the whole dataset.
    /// </summary>
    [Fact]
    public void The_import_writes_the_marker_it_deletes_by()
    {
        var ps1 = File.ReadAllText(RepoFile("tools", "keeptrak-import.ps1"));
        var inserts = Regex.Matches(ps1, @"INSERT INTO (pm|pm_actions|pmcompletions) \(([^)]*)\)")
            .Select(m => (Table: m.Groups[1].Value, Cols: m.Groups[2].Value))
            .ToList();

        Assert.NotEmpty(inserts);
        foreach (var (table, cols) in inserts)
        {
            Assert.True(cols.Contains("kt_ref", StringComparison.OrdinalIgnoreCase),
                $"the {table} INSERT does not set kt_ref, but the import deletes by it — a re-import "
                + "would clear nothing and duplicate every row.");
        }
    }

    /// <summary>
    /// The audit has to report it, because the exclude is the only defence and a silent loss of 15,300
    /// rows looks exactly like "the maintenance screens were always empty".
    /// </summary>
    [Fact]
    public void The_post_refresh_audit_checks_the_import_survived()
    {
        var sql = File.ReadAllText(RepoFile("tools", "verify_refresh.sql"));
        Assert.Contains("pm_id >= 100000", sql);
        Assert.Contains("pmcompletion_id >= 100000", sql);
    }
}
