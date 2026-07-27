using Abis.Api.Data;
using Oracle.ManagedDataAccess.Client;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// Pins that Oracle binds parameters by NAME. ODP.NET defaults this to false, which makes an
/// <c>OracleCommand</c> match parameters to placeholders by ORDER — while SQLite, which every test in
/// this suite runs against, matches by name.
/// <para>That divergence is silent and does not throw: if a parameter object's member order differs
/// from the placeholder order, each value lands in the neighbouring column and the row is written
/// wrong. Nothing in CI can see it. This test is the only thing standing between the codebase and a
/// return to that behaviour.</para>
/// </summary>
public sealed class OracleBindByNameTests
{
    [Fact]
    public void Oracle_binds_parameters_by_name_not_by_position()
    {
        // Touching the factory runs its static initialiser, which is where the global is set.
        _ = new DbConnectionFactory(new DatabaseOptions { Provider = "Sqlite", ConnectionString = "Data Source=:memory:" });

        Assert.True(OracleConfiguration.BindByName,
            "OracleConfiguration.BindByName is false, so ODP.NET is matching parameters to placeholders " +
            "BY POSITION while the test suite runs on SQLite, which matches BY NAME. Any parameter " +
            "object whose member order differs from its SQL's placeholder order will silently write " +
            "every value into the wrong column on Oracle, and no test here can detect it.");
    }

    [Fact]
    public void A_new_OracleCommand_inherits_the_by_name_default()
    {
        // The global is only useful if commands actually pick it up — Dapper creates them itself, so
        // assert the inheritance rather than assuming it.
        _ = new DbConnectionFactory(new DatabaseOptions { Provider = "Sqlite", ConnectionString = "Data Source=:memory:" });

        using var cmd = new OracleCommand();
        Assert.True(cmd.BindByName, "A freshly created OracleCommand did not inherit BindByName from OracleConfiguration.");
    }
}
