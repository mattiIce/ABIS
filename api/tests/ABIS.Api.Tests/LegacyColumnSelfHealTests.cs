using System.Linq;
using System.Reflection;
using Abis.Api.Data;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The columns this app adds to <b>legacy</b> tables, and the guard that they stay declared.
///
/// <para><b>What went wrong.</b> Migration 008 adds <c>LABOR_HOURS</c> and <c>COMP_COST</c> to
/// <c>PMCOMPLETIONS</c> so KeepTrak's per-completion labour and cost survive the import. On 2026-08-21
/// <c>GET /pms/{id}/completions</c> returned <b>500</b> on .230 for every PM —
/// <c>ORA-00904: "COMP_COST": invalid identifier</c> — because the columns were not there.</para>
///
/// <para><b>Why it is structural.</b> Migrations 001–007 only CREATE ABIS-owned tables, which the
/// refresh preserves. 008 was the first to ALTER a table the legacy app also owns, and Data Pump
/// restores legacy tables from prod, where these columns have never existed. Every refresh drops them,
/// and every future legacy-table migration will behave the same way.</para>
///
/// <para><b>Why the suite did not catch it.</b> The SQLite fixture declares both columns, so every test
/// passed while live Oracle failed — the same shape as the phantom-feature bug, where the test
/// environment had what production lacked. A test that queried the fixture would prove nothing, so
/// these assert the two things that actually drift: that the repair list still names the columns the
/// query selects, and that the fixture agrees with it.</para>
/// </summary>
public class LegacyColumnSelfHealTests
{
    private static (string Table, string Column, string Type, string Why)[] Declared()
    {
        var field = typeof(AbisSchema).GetField("RequiredLegacyColumns",
            BindingFlags.NonPublic | BindingFlags.Static)!;
        Assert.NotNull(field);
        return ((string, string, string, string)[])field.GetValue(null)!;
    }

    /// <summary>The exact pair whose absence produced the ORA-00904.</summary>
    [Theory]
    [InlineData("PMCOMPLETIONS", "LABOR_HOURS")]
    [InlineData("PMCOMPLETIONS", "COMP_COST")]
    public void The_columns_migration_008_adds_are_on_the_repair_list(string table, string column)
    {
        Assert.Contains(Declared(), c => c.Table == table && c.Column == column);
    }

    /// <summary>
    /// Every declared column must be one the repository actually selects. A stale entry would add a
    /// column nothing reads to a table the legacy application shares — harmless but dishonest, and
    /// exactly how a repair list rots into folklore.
    /// </summary>
    [Fact]
    public void Every_declared_column_is_one_the_repository_selects()
    {
        var sql = File.ReadAllText(RepositorySourcePath());
        foreach (var (_, column, _, _) in Declared())
        {
            Assert.True(sql.Contains(column, StringComparison.OrdinalIgnoreCase),
                $"{column} is on the legacy-column repair list but no query names it — either the query "
                + "was removed and the entry is stale, or the column name drifted.");
        }
    }

    /// <summary>
    /// Names are UPPER CASE because the check is against <c>user_tab_cols</c>, where Oracle stores
    /// unquoted identifiers folded to upper. A lower-case entry would silently never match, and the
    /// self-heal would re-run the ALTER on every boot — or worse, appear to do nothing.
    /// </summary>
    [Fact]
    public void Table_and_column_names_are_upper_case()
    {
        foreach (var (table, column, _, _) in Declared())
        {
            Assert.Equal(table.ToUpperInvariant(), table);
            Assert.Equal(column.ToUpperInvariant(), column);
        }
    }

    /// <summary>
    /// Additive only. Anything but a plain NULLable type on a table the legacy PowerBuilder app also
    /// writes would stop being safe to apply automatically at startup.
    /// </summary>
    [Fact]
    public void Declared_types_are_plain_and_nullable()
    {
        foreach (var (_, _, type, _) in Declared())
        {
            Assert.DoesNotContain("NOT NULL", type, StringComparison.OrdinalIgnoreCase);
            Assert.DoesNotContain("DEFAULT", type, StringComparison.OrdinalIgnoreCase);
        }
    }

    /// <summary>Each entry has to say WHY, so a later reader can tell a live repair from a leftover.</summary>
    [Fact]
    public void Every_entry_explains_itself()
    {
        Assert.All(Declared(), c => Assert.False(string.IsNullOrWhiteSpace(c.Why)));
    }

    /// <summary>
    /// The SQLite fixture must declare the same columns. If it did not, CI would fail loudly instead of
    /// hiding the Oracle gap — but it does, which is precisely why this bug shipped. Asserting the
    /// agreement keeps the two schemas from drifting in the OTHER direction, where a column is dropped
    /// from the fixture and the Oracle repair list quietly becomes the only record of it.
    /// </summary>
    [Fact]
    public void The_sqlite_fixture_declares_the_same_columns()
    {
        var fixture = File.ReadAllText(FixtureSourcePath());
        foreach (var (_, column, _, _) in Declared())
        {
            Assert.True(fixture.Contains(column, StringComparison.OrdinalIgnoreCase),
                $"{column} is repaired on Oracle but absent from the SQLite fixture — the suite would "
                + "then fail for a reason unrelated to the real defect.");
        }
    }

    private static string RepositorySourcePath() => SourcePath("AbisRepository.cs");
    private static string FixtureSourcePath() => SourcePath("SqliteFixture.cs");

    private static string SourcePath(string fileName)
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null && !Directory.Exists(Path.Combine(dir.FullName, "src", "ABIS.Api")))
            dir = dir.Parent;
        Assert.NotNull(dir);
        return Path.Combine(dir!.FullName, "src", "ABIS.Api", "Data", fileName);
    }
}
