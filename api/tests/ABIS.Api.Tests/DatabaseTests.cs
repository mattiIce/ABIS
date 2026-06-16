using Abis.Api.Data;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>Unit tests for the dialect-specific SQL built by the connection
/// factory. These need no database — they exercise the one piece of the Oracle
/// path that is otherwise unreachable in CI (it has no Oracle instance).</summary>
public sealed class DatabaseTests
{
    private static DbConnectionFactory Factory(string provider, Action<DatabaseOptions>? configure = null)
    {
        var options = new DatabaseOptions { Provider = provider, ConnectionString = "x" };
        configure?.Invoke(options);
        return new DbConnectionFactory(options);
    }

    [Fact]
    public void Sqlite_next_id_uses_max_plus_one()
    {
        var sql = Factory("Sqlite").NextIdQuery("coil", "coil_abc_num");
        Assert.Equal("SELECT COALESCE(MAX(coil_abc_num), 0) + 1 FROM coil", sql);
    }

    [Fact]
    public void Oracle_next_id_uses_sequence_nextval_by_convention()
    {
        var sql = Factory("Oracle").NextIdQuery("coil", "coil_abc_num");
        Assert.Equal("SELECT coil_seq.NEXTVAL FROM dual", sql);
    }

    [Fact]
    public void Oracle_next_id_honors_explicit_sequence_override()
    {
        var sql = Factory("Oracle", o => o.Sequences["ab_job"] = "ABIS.AB_JOB_S").NextIdQuery("ab_job", "ab_job_num");
        Assert.Equal("SELECT ABIS.AB_JOB_S.NEXTVAL FROM dual", sql);
    }

    [Fact]
    public void Oracle_next_id_honors_custom_name_format()
    {
        var sql = Factory("Oracle", o => o.SequenceNameFormat = "seq_{0}").NextIdQuery("customer", "customer_id");
        Assert.Equal("SELECT seq_customer.NEXTVAL FROM dual", sql);
    }

    [Fact]
    public void Oracle_next_id_rejects_an_unsafe_sequence_name()
    {
        var factory = Factory("Oracle", o => o.Sequences["coil"] = "evil; DROP TABLE coil");
        Assert.Throws<InvalidOperationException>(() => factory.NextIdQuery("coil", "coil_abc_num"));
    }

    [Fact]
    public void Paginate_is_dialect_specific()
    {
        Assert.EndsWith("LIMIT :limit OFFSET :offset", Factory("Sqlite").Paginate("SELECT 1 ORDER BY a"));
        Assert.EndsWith("OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY", Factory("Oracle").Paginate("SELECT 1 ORDER BY a"));
    }

    [Fact]
    public void Ping_query_is_dialect_specific()
    {
        // Oracle needs a FROM clause; a bare "SELECT 1" raises ORA-00923.
        Assert.Equal("SELECT 1", Factory("Sqlite").PingQuery);
        Assert.Equal("SELECT 1 FROM dual", Factory("Oracle").PingQuery);
    }
}
