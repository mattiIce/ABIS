using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// A paged list's default ordering must end in something unique.
///
/// <para><b>The defect class.</b> <c>PageAsync</c> applies its window (Oracle: <c>ROWNUM</c>) <i>after</i> the
/// ORDER BY, and a database may order tied rows however it likes — including differently between two
/// executions. When the sort key repeats, the row sitting on a page boundary is undefined, so paging can show
/// one row twice and never show another. Ending the ordering in the table's key removes the ties.</para>
///
/// <para><b>Measured on `.230` (2026-09-12)</b>, which is why these four and not others:
/// <c>pst_test_result</c> has 47,516 rows over **8,317** distinct <c>created_date</c> values (~5.7 rows per
/// timestamp); <c>edi_log</c> 944 rows over 547 timestamps; <c>process_partial_skid</c> 25,188 rows over 25,187
/// distinct <c>sheet_skid_num</c> — one duplicate, which is exactly what a boundary lands on. Every other paged
/// default already sorts by a unique id.</para>
///
/// <para><b>Honest scope:</b> the instability is latent, not observed — two consecutive page fetches on `.230`
/// returned no overlap, because the plan happened to order the ties consistently. This makes the order defined
/// by construction rather than by luck. And like the NULL-ordering guard, it cannot be caught behaviourally on
/// the SQLite fixture, so the check is on the SQL text.</para>
/// </summary>
public sealed class StablePagingTests
{
    private static string RepoSource()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null && !File.Exists(Path.Combine(dir.FullName, "ABIS.Api.sln"))) dir = dir.Parent;
        Assert.NotNull(dir);
        return File.ReadAllText(Path.Combine(dir!.FullName, "src", "ABIS.Api", "Data", "AbisRepository.cs"));
    }

    public static TheoryData<string, string> TieBrokenOrderings() => new()
    {
        { "test results (47,516 rows / 8,317 timestamps)", "\"created_date DESC, coil_abc_num, position, source_id\"" },
        { "temp test results (nullable date too)", "created_date DESC, coil_org_num, position" },
        { "EDI log (944 rows / 547 timestamps)", "\"edi_log_timestamp DESC, customer_id, customer_edi_name\"" },
        { "partial skids (one duplicate skid number)", "\"sheet_skid_num, ab_job_num\"" },
    };

    [Theory]
    [MemberData(nameof(TieBrokenOrderings))]
    public void A_paged_default_ordering_ends_in_a_unique_key(string what, string ordering)
    {
        Assert.True(RepoSource().Contains(ordering, StringComparison.Ordinal),
            $"{what}: this paged list lost its tie-breaker. Rows sharing the sort key can then swap across a " +
            $"page boundary, showing one twice and hiding another. Expected the ordering to contain: {ordering}");
    }
}
