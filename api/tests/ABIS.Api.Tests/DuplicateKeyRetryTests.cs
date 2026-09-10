using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using Abis.Api.Data;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// Retrying a create that lost an id race.
///
/// <para><b>The race.</b> Fourteen tables mint their id with <c>MAX(id)+1</c> rather than from a
/// sequence — deliberately, because the legacy PowerBuilder application still writes eleven of them the
/// same way and a sequence would hand out ids legacy is about to reuse. Two transactions can read the
/// same MAX before either commits; the primary key turns that into <c>ORA-00001</c> instead of two rows
/// sharing an id.</para>
///
/// <para><b>Why a test at this level.</b> The obvious end-to-end test does not exist: every create path
/// that a caller could collide with by hand is explicitly guarded, so no single-threaded request through
/// the public API can reach the handler at all (audited 2026-08-21). The collision needs two writers
/// picking the same integer, which a test cannot stage deterministically. So these prove the two things
/// that can actually be proven — that the retry does what it claims when a collision happens, and that
/// every minting entry point is behind it.</para>
/// </summary>
public class DuplicateKeyRetryTests
{
    private const string RepoFile = "AbisRepository.cs";

    private static string Source()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null && !Directory.Exists(Path.Combine(dir.FullName, "src", "ABIS.Api")))
            dir = dir.Parent;
        Assert.NotNull(dir);
        // Normalise line endings: these assertions are about code STRUCTURE, and a checkout that
        // brought the file back as CRLF should not fail a test about where a parameter list sits.
        return File.ReadAllText(Path.Combine(dir!.FullName, "src", "ABIS.Api", "Data", RepoFile))
                   .ReplaceLineEndings("\n");
    }

    /// <summary>A real provider exception, not a hand-built one: the error code is the thing under test.</summary>
    private static Exception RealDuplicateKey()
    {
        using var conn = new SqliteConnection("Data Source=:memory:");
        conn.Open();
        using (var create = conn.CreateCommand())
        {
            create.CommandText = "CREATE TABLE t (id INTEGER PRIMARY KEY); INSERT INTO t (id) VALUES (1);";
            create.ExecuteNonQuery();
        }
        using var dup = conn.CreateCommand();
        dup.CommandText = "INSERT INTO t (id) VALUES (1)";
        return Assert.Throws<SqliteException>(() => dup.ExecuteNonQuery());
    }

    private static Task<T> Retry<T>(Func<Task<T>> op)
    {
        var m = typeof(AbisRepository)
            .GetMethods(BindingFlags.NonPublic | BindingFlags.Static)
            .Single(x => x.Name == "RetryOnDuplicateKeyAsync" && x.IsGenericMethodDefinition)
            .MakeGenericMethod(typeof(T));
        return (Task<T>)m.Invoke(null, [op, 3])!;
    }

    [Fact]
    public async Task A_create_that_loses_the_race_once_succeeds_on_the_retry()
    {
        var attempts = 0;
        var result = await Retry<string>(() =>
        {
            attempts++;
            if (attempts == 1) throw RealDuplicateKey();
            return Task.FromResult("created");
        });

        Assert.Equal("created", result);
        Assert.Equal(2, attempts);
    }

    /// <summary>
    /// A collision surviving three fresh MAX reads is not a race — it is a caller re-inserting a key
    /// that already exists, and that must surface as the 409 rather than spin.
    /// </summary>
    [Fact]
    public async Task A_persistent_duplicate_still_surfaces()
    {
        var attempts = 0;
        await Assert.ThrowsAsync<SqliteException>(() => Retry<string>(() =>
        {
            attempts++;
            throw RealDuplicateKey();
        }));

        Assert.Equal(3, attempts);
    }

    /// <summary>
    /// Only a duplicate key is retried. Re-running a create because the database was unreachable, or
    /// because a foreign key was wrong, would repeat work for a fault that is not going to clear.
    /// </summary>
    [Fact]
    public async Task An_unrelated_failure_is_not_retried()
    {
        var attempts = 0;
        await Assert.ThrowsAsync<InvalidOperationException>(() => Retry<string>(() =>
        {
            attempts++;
            throw new InvalidOperationException("something else");
        }));

        Assert.Equal(1, attempts);
    }

    [Fact]
    public async Task A_create_that_succeeds_first_time_runs_exactly_once()
    {
        var attempts = 0;
        await Retry<string>(() => { attempts++; return Task.FromResult("ok"); });
        Assert.Equal(1, attempts);
    }

    // ---- the structural guard ------------------------------------------------

    /// <summary>Private methods that own a transaction AND mint an id — the bodies that can collide.</summary>
    private static List<string> MintingCores(string src) =>
        Regex.Matches(src, @"private async Task(?:<[^\n]*?>)? (\w+Core\w*)\(")
             .Select(m => m.Groups[1].Value)
             .Where(name => BodyOf(src, name).Contains("NextIdAsync(conn, tx"))
             .ToList();

    private static string BodyOf(string src, string method)
    {
        // Find the DEFINITION, not the wrapper's call site — the wrapper names the core method one line
        // earlier, and starting there would return a one-line "body" containing no SQL at all.
        var i = src.IndexOf($"private async Task", StringComparison.Ordinal) < 0
            ? -1
            : FindDefinition(src, method);
        if (i < 0) return "";
        var end = src.IndexOf("\n    private ", i + 1, StringComparison.Ordinal);
        var end2 = src.IndexOf("\n    public ", i + 1, StringComparison.Ordinal);
        if (end < 0 || (end2 >= 0 && end2 < end)) end = end2;
        return end < 0 ? src[i..] : src[i..end];
    }

    private static int FindDefinition(string src, string method)
    {
        var m = Regex.Match(src, @"private async Task(?:<[^
]*?>)? " + Regex.Escape(method) + @"\(");
        return m.Success ? m.Index : -1;
    }

    /// <summary>
    /// Every minting body must be reachable only through the retry. The failure this catches: somebody
    /// adds a fifteenth create path, mints with MAX+1, and it silently 409s at cutover while the other
    /// forty-five retry.
    /// </summary>
    [Fact]
    public void Every_minting_body_is_behind_the_retry_wrapper()
    {
        var src = Source();
        var cores = MintingCores(src);

        Assert.True(cores.Count >= 40, $"expected the minting cores to still be there, found {cores.Count}");
        foreach (var core in cores)
        {
            Assert.True(src.Contains($"RetryOnDuplicateKeyAsync(() => {core}("),
                $"{core} mints an id inside its own transaction but nothing wraps it in "
                + "RetryOnDuplicateKeyAsync — a collision there would surface as a 409 instead of retrying.");
        }
    }

    /// <summary>
    /// The EDI sink must stay OUT. It mints <c>edi_file_id</c> — the ISA13/GS06/ST02 control number —
    /// and generates the document text from it, so a retry burns a partner-visible number. It also takes
    /// <c>(conn, tx)</c> and runs inside the caller's transaction, so it is not an entry point at all.
    /// </summary>
    [Fact]
    public void The_EDI_document_sink_is_not_retried()
    {
        var src = Source();

        Assert.Contains("WriteEdiTransactionAsync(", src);
        Assert.DoesNotContain("RetryOnDuplicateKeyAsync(() => WriteEdiTransaction", src);
        // …and it still takes the caller's transaction, which is why wrapping it would be wrong anyway.
        Assert.Contains("WriteEdiTransactionAsync(\n        DbConnection conn, DbTransaction tx", src);
    }
}
