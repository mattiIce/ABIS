using System.Data.Common;
using System.Text.RegularExpressions;
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

    /// <summary>Oracle only: format used to derive a sequence name from a table when
    /// no explicit mapping is given. Default <c>{0}_seq</c> (e.g. <c>coil</c> →
    /// <c>coil_seq</c>). The real names must be confirmed against the database.</summary>
    public string SequenceNameFormat { get; set; } = "{0}_seq";

    /// <summary>Oracle only: explicit <c>table → sequence name</c> overrides for
    /// names that don't follow <see cref="SequenceNameFormat"/> (set via the
    /// <c>Database:Sequences</c> config section).</summary>
    public Dictionary<string, string> Sequences { get; set; } = new(StringComparer.OrdinalIgnoreCase);

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

    /// <summary>Wraps an ordered query with the engine-specific pagination.
    /// SQLite expects <c>:limit</c>/<c>:offset</c> parameters; Oracle (an 11g-compatible
    /// ROWNUM form) expects <c>:maxRow</c> (offset + pageSize) then <c>:minRow</c> (offset).</summary>
    string Paginate(string orderedSql);

    /// <summary>Dialect-specific SQL that yields the next id for an insert:
    /// <c>MAX+1</c> on SQLite (fine for the single-writer dev fixture), a sequence
    /// <c>NEXTVAL</c> on Oracle (concurrency-safe for production). <paramref name="table"/>
    /// and <paramref name="idColumn"/> are internal constants, never user input.</summary>
    string NextIdQuery(string table, string idColumn);

    /// <summary>Dialect-specific trivial connectivity probe. Oracle requires a FROM
    /// clause (a bare <c>SELECT 1</c> raises ORA-00923), so it uses <c>FROM dual</c>.</summary>
    string PingQuery { get; }
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
        // Oracle 11g-compatible ROWNUM pagination. The 12c+ "OFFSET :offset ROWS
        // FETCH NEXT :limit ROWS ONLY" clause raises ORA-00933 on 11g, so wrap the
        // ordered query instead: the inner inline view preserves ORDER BY, ROWNUM is
        // assigned over the ordered rows and capped at :maxRow, then the outer query
        // discards the first :minRow rows. :maxRow is bound before :minRow to match
        // the order the repository appends them in (Oracle positional binding). Works
        // on 11g and 12c+ alike.
        SqlDialect.Oracle =>
            $"SELECT * FROM (SELECT __p.*, ROWNUM AS rnum FROM ({orderedSql}) __p WHERE ROWNUM <= :maxRow) WHERE rnum > :minRow",
        _ => throw new InvalidOperationException($"Unsupported dialect {Dialect}.")
    };

    public string PingQuery => Dialect switch
    {
        SqlDialect.Sqlite => "SELECT 1",
        SqlDialect.Oracle => "SELECT 1 FROM dual",
        _ => throw new InvalidOperationException($"Unsupported dialect {Dialect}.")
    };

    public string NextIdQuery(string table, string idColumn) => Dialect switch
    {
        // Single-writer dev fixture: MAX+1 is adequate and keeps the seed ids tidy.
        SqlDialect.Sqlite => $"SELECT COALESCE(MAX({idColumn}), 0) + 1 FROM {table}",
        // Production: a real sequence avoids the MAX+1 race under concurrent writers.
        SqlDialect.Oracle => $"SELECT {ResolveSequence(table)}.NEXTVAL FROM dual",
        _ => throw new InvalidOperationException($"Unsupported dialect {Dialect}.")
    };

    /// <summary>Resolves the Oracle sequence for a table (explicit override, else
    /// the <see cref="DatabaseOptions.SequenceNameFormat"/> convention) and validates
    /// it is a plain (optionally schema-qualified) identifier before interpolation.</summary>
    private string ResolveSequence(string table)
    {
        var name = _options.Sequences.TryGetValue(table, out var mapped) && !string.IsNullOrWhiteSpace(mapped)
            ? mapped
            : string.Format(_options.SequenceNameFormat, table);

        if (!Regex.IsMatch(name, @"^[A-Za-z][A-Za-z0-9_$]*(\.[A-Za-z][A-Za-z0-9_$]*)?$"))
            throw new InvalidOperationException(
                $"Invalid Oracle sequence name '{name}' for table '{table}'. " +
                "Use a plain or schema-qualified identifier (Database:Sequences or Database:SequenceNameFormat).");
        return name;
    }
}
