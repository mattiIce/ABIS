using Abis.Api.Data;
using Abis.Api.Endpoints;

var builder = WebApplication.CreateBuilder(args);

// Configuration: bind the Database section and register the data layer.
var dbOptions = builder.Configuration.GetSection(DatabaseOptions.SectionName).Get<DatabaseOptions>()
                ?? new DatabaseOptions();
builder.Services.AddSingleton(dbOptions);
builder.Services.AddSingleton<IDbConnectionFactory, DbConnectionFactory>();
builder.Services.AddScoped<IAbisRepository, AbisRepository>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
    c.SwaggerDoc("v1", new() { Title = "ABIS API", Version = "v1",
        Description = "Read-first REST seam over the legacy ABIS database (modernization Phase 2)." }));

builder.Services.AddProblemDetails();

var app = builder.Build();

// Dev/CI only: build and seed the local SQLite fixture so the API has data.
if (dbOptions.Seed && dbOptions.Dialect == SqlDialect.Sqlite)
{
    SqliteFixture.EnsureCreatedAndSeeded(dbOptions.ConnectionString);
    app.Logger.LogInformation("Seeded SQLite fixture at {ConnectionString}", dbOptions.ConnectionString);
}

app.UseExceptionHandler();
app.UseStatusCodePages();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapAbisApi();

app.Run();

// Exposed so the integration test project can host the app via WebApplicationFactory.
public partial class Program { }
