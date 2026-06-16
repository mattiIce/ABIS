using System.Data.Common;
using Microsoft.Data.Sqlite;
using Oracle.ManagedDataAccess.Client;

namespace Abis.Api.Data;

/// <summary>Which database engine the API talks to.</summary>
public enum SqlDialect
{
    Sqlite,
    Oracle
}

/// <summary>Bound from the "Database" configuration section.</summary>
public sealed class DatabaseOptions
{
    public const string SectionName = "Database";

    /// <summary>"Sqlite" (dev/CI fixture) or "Oracle" (production).</summary>
    public string Provider { get; set; } = "Sqlite";

    public string ConnectionString { get; set; } = "Data Source=abis_dev.db";

    /// <summary>When true (dev only), create and seed the SQLite fixture at startup.</summary>
    public bool Seed { get; set; }

    public SqlDialect Dialect => Provider.Trim().ToLowerInvariant() switch
    {
        "oracle" => SqlDialect.Oracle,
        "sqlite" => SqlDialect.Sqlite,
        _ => throw new InvalidOperationException(
            $"Unsupported Database:Provider '{Provider}'. Use 'Sqlite' or 'Oracle'.")
    };
}

/// <summary>Creates ready-to-open <see cref="DbConnection"/>s for the configured engine.</summary>
public interface IDbConnectionFactory
{
    SqlDialect Dialect { get; }
    DbConnection Create();

    /// <summary>Appends the engine-specific LIMIT/OFFSET clause to a query.
    /// Expects <c>:limit</c> and <c>:offset</c> parameters to be supplied.</summary>
    string Paginate(string orderedSql);
}

public sealed class DbConnectionFactory : IDbConnectionFactory
{
    private readonly DatabaseOptions _options;

    public DbConnectionFactory(DatabaseOptions options) => _options = options;

    public SqlDialect Dialect => _options.Dialect;

    public DbConnection Create() => Dialect switch
    {
        SqlDialect.Sqlite => new SqliteConnection(_options.ConnectionString),
        SqlDialect.Oracle => new OracleConnection(_options.ConnectionString),
        _ => throw new InvalidOperationException($"Unsupported dialect {Dialect}.")
    };

    public string Paginate(string orderedSql) => Dialect switch
    {
        SqlDialect.Sqlite => $"{orderedSql} LIMIT :limit OFFSET :offset",
        // Oracle 12c+ row-limiting clause.
        SqlDialect.Oracle => $"{orderedSql} OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY",
        _ => throw new InvalidOperationException($"Unsupported dialect {Dialect}.")
    };
}
