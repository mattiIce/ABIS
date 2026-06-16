using System.Threading.RateLimiting;
using Abis.Api.Data;
using Abis.Api.Endpoints;
using Abis.Api.Middleware;
using Abis.Api.Security;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.RateLimiting;
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

// Rate limiting: a fixed window partitioned per API key (fallback to remote IP),
// applied to the /api group. Shields the legacy DB from runaway callers; tunable
// via the RateLimiting section.
var rateLimitOptions = builder.Configuration.GetSection(RateLimitOptions.SectionName).Get<RateLimitOptions>()
                       ?? new RateLimitOptions();
builder.Services.AddSingleton(rateLimitOptions);
builder.Services.AddRateLimiter(options =>
{
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
    options.AddPolicy(RateLimitOptions.PolicyName, http =>
    {
        var partitionKey = http.Request.Headers[apiKeyOptions.HeaderName].ToString();
        if (string.IsNullOrEmpty(partitionKey))
            partitionKey = http.Connection.RemoteIpAddress?.ToString() ?? "anonymous";
        return RateLimitPartition.GetFixedWindowLimiter(partitionKey, _ => new FixedWindowRateLimiterOptions
        {
            PermitLimit = rateLimitOptions.PermitLimit,
            Window = TimeSpan.FromSeconds(rateLimitOptions.WindowSeconds),
            QueueLimit = 0
        });
    });
    options.OnRejected = async (context, token) =>
    {
        context.HttpContext.Response.Headers.RetryAfter = rateLimitOptions.WindowSeconds.ToString();
        await Results.Problem(
            statusCode: StatusCodes.Status429TooManyRequests,
            title: "Too many requests",
            detail: $"Rate limit exceeded. Retry after {rateLimitOptions.WindowSeconds}s.")
            .ExecuteAsync(context.HttpContext);
    };
});

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

builder.Services.AddProblemDetails(options =>
    options.CustomizeProblemDetails = ctx =>
    {
        if (Abis.Api.Middleware.RequestIdMiddleware.Current(ctx.HttpContext) is { } requestId)
            ctx.ProblemDetails.Extensions["requestId"] = requestId;
    });

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

// First: assign/propagate a correlation id available to everything downstream.
app.UseMiddleware<RequestIdMiddleware>();

// Outermost audit: observe the final status (incl. exception-handler output) and audit it.
app.UseMiddleware<AuditMiddleware>();

// Baseline security headers on every response (set before the body is written).
app.Use(async (context, next) =>
{
    var headers = context.Response.Headers;
    headers["X-Content-Type-Options"] = "nosniff";
    headers["X-Frame-Options"] = "DENY";
    headers["Referrer-Policy"] = "no-referrer";
    await next();
});

app.UseExceptionHandler();
app.UseStatusCodePages();

app.UseCors("Default");

// Serve the static order-entry demo (wwwroot/ui/) — anonymous; its data calls
// still carry the API key.
app.UseStaticFiles();

app.UseAuthentication();
app.UseAuthorization();

// After routing + auth so the selected endpoint's RequireRateLimiting policy applies.
if (rateLimitOptions.Enabled)
    app.UseRateLimiter();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapAbisApi();

app.Run();

// Exposed so the integration test project can host the app via WebApplicationFactory.
public partial class Program { }
