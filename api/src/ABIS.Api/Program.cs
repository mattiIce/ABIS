using Abis.Api.Data;
using Abis.Api.Endpoints;
using Abis.Api.Middleware;
using Abis.Api.Security;
using Microsoft.AspNetCore.Authentication;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Configuration: bind the Database section and register the data layer.
var dbOptions = builder.Configuration.GetSection(DatabaseOptions.SectionName).Get<DatabaseOptions>()
                ?? new DatabaseOptions();
builder.Services.AddSingleton(dbOptions);
builder.Services.AddSingleton<IDbConnectionFactory, DbConnectionFactory>();
builder.Services.AddScoped<IAbisRepository, AbisRepository>();

// API-key authentication: secure the /api surface. Endpoints just require an
// authenticated principal, so the scheme can later be swapped for OAuth/OIDC.
var apiKeyOptions = builder.Configuration.GetSection(ApiKeyOptions.SectionName).Get<ApiKeyOptions>()
                    ?? new ApiKeyOptions();
builder.Services.AddSingleton(apiKeyOptions);
builder.Services
    .AddAuthentication(ApiKeyAuthenticationHandler.SchemeName)
    .AddScheme<AuthenticationSchemeOptions, ApiKeyAuthenticationHandler>(ApiKeyAuthenticationHandler.SchemeName, null);
builder.Services.AddAuthorization();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { Title = "ABIS API", Version = "v1",
        Description = "Read-first REST seam over the legacy ABIS database (modernization Phase 2)." });
    c.AddSecurityDefinition("ApiKey", new OpenApiSecurityScheme
    {
        Name = apiKeyOptions.HeaderName,
        Type = SecuritySchemeType.ApiKey,
        In = ParameterLocation.Header,
        Description = $"API key sent in the {apiKeyOptions.HeaderName} header."
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "ApiKey" }
            },
            Array.Empty<string>()
        }
    });
});

builder.Services.AddProblemDetails();

// CORS for a future SPA: configure allowed origins via Cors:Origins. With none
// configured, Development allows any origin for convenience; other environments
// stay same-origin only.
var corsOrigins = builder.Configuration.GetSection("Cors:Origins").Get<string[]>() ?? [];
builder.Services.AddCors(options => options.AddPolicy("Default", policy =>
{
    if (corsOrigins.Length > 0)
        policy.WithOrigins(corsOrigins).AllowAnyHeader().AllowAnyMethod();
    else if (builder.Environment.IsDevelopment())
        policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
}));

var app = builder.Build();

// Dev/CI only: build and seed the local SQLite fixture so the API has data.
if (dbOptions.Seed && dbOptions.Dialect == SqlDialect.Sqlite)
{
    SqliteFixture.EnsureCreatedAndSeeded(dbOptions.ConnectionString);
    app.Logger.LogInformation("Seeded SQLite fixture at {ConnectionString}", dbOptions.ConnectionString);
}

// Outermost: observe the final status (incl. exception-handler output) and audit it.
app.UseMiddleware<AuditMiddleware>();

app.UseExceptionHandler();
app.UseStatusCodePages();

app.UseCors("Default");

app.UseAuthentication();
app.UseAuthorization();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapAbisApi();

app.Run();

// Exposed so the integration test project can host the app via WebApplicationFactory.
public partial class Program { }
