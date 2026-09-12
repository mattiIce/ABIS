using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// Newest-first lists over a NULLABLE timestamp must order their NULLs explicitly.
///
/// <para><b>The defect class.</b> Oracle sorts NULLs <b>first</b> under <c>ORDER BY … DESC</c>; SQLite sorts
/// them last. So a row with no timestamp silently jumps to the TOP of a "newest first" list in production,
/// while the SQLite fixture every test runs on shows it at the bottom. This project has already hit it once,
/// on the archived-BOL list, where ~1,660 undated BOLs would have led the page.</para>
///
/// <para><b>Why this test is structural rather than behavioural.</b> A behavioural test cannot fail here: on
/// SQLite the guarded and unguarded queries return the same order, so it would pass with the guard deleted —
/// verified by removing it. Checking the SQL text is the only thing that actually catches a regression in CI.</para>
///
/// <para><b>Probed on the real engine</b> (2026-09-12, `.230`):
/// <c>SELECT … ORDER BY dt DESC</c> over {2026-01-01, 2026-02-01, NULL} returns the <b>NULL first</b>, and ASC
/// returns it last — so the guard is doing real work. (Probe carefully: aliasing the displayed string with the
/// same name as the date column makes ORDER BY sort the string instead, which hides the behaviour.)</para>
/// </summary>
public sealed class NullOrderingTests
{
    private static string RepoSource()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null && !File.Exists(Path.Combine(dir.FullName, "ABIS.Api.sln"))) dir = dir.Parent;
        Assert.NotNull(dir);
        return File.ReadAllText(Path.Combine(dir!.FullName, "src", "ABIS.Api", "Data", "AbisRepository.cs"));
    }

    /// <summary>
    /// Each entry is a newest-first ordering over a column that is nullable on <c>.230</c>: a queued job run
    /// has no <c>started_utc</c>, and the other three columns permit NULL even though none is null today
    /// (checked 2026-09-12). The guard keeps Oracle and SQLite agreeing, with undated rows last.
    /// </summary>
    public static TheoryData<string, string> GuardedOrderings() => new()
    {
        { "abis_job_run (a queued run has no start time)", "CASE WHEN started_utc IS NULL THEN 1 ELSE 0 END, started_utc DESC" },
        { "sales_quote listing", "CASE WHEN q.created_date IS NULL THEN 1 ELSE 0 END, q.created_date DESC" },
        { "coil ownership transfers", "CASE WHEN t.transfer_datetime IS NULL THEN 1 ELSE 0 END, t.transfer_datetime DESC" },
        { "truck appointment lookup", "CASE WHEN scheduled_start IS NULL THEN 1 ELSE 0 END, scheduled_start DESC" },
    };

    [Theory]
    [MemberData(nameof(GuardedOrderings))]
    public void A_newest_first_list_over_a_nullable_timestamp_orders_its_nulls_explicitly(string what, string guard)
    {
        Assert.True(RepoSource().Contains(guard, StringComparison.Ordinal),
            $"{what}: this ordering lost its NULL guard. On Oracle the undated rows would move to the top of the " +
            $"list and no SQLite test would notice. Expected the SQL to contain: {guard}");
    }

    /// <summary>The archived-BOL list is the case that taught this; it carries the same guard.</summary>
    [Fact]
    public void The_archived_bol_list_still_sorts_undated_bols_last()
    {
        Assert.Contains("CASE WHEN st.received_time IS NULL THEN 1 ELSE 0 END", RepoSource(), StringComparison.Ordinal);
    }
}
