using Abis.Api.Data;

namespace Abis.Api.Middleware;

/// <summary>
/// Records every mutating API request (POST/PUT/PATCH/DELETE under <c>/api</c>)
/// into the legacy <c>opc_action_log</c> table, giving the new seam the same
/// kind of audit trail the legacy app keeps. Auditing is best-effort: a failure
/// to write the log never fails the request.
///
/// Registered as the outermost middleware so it observes the final response
/// status (including statuses produced by the exception handler).
/// </summary>
public sealed class AuditMiddleware
{
    private static readonly HashSet<string> MutatingMethods =
        new(StringComparer.OrdinalIgnoreCase) { "POST", "PUT", "PATCH", "DELETE" };

    private readonly RequestDelegate _next;

    public AuditMiddleware(RequestDelegate next) => _next = next;

    public async Task InvokeAsync(HttpContext context, IAbisRepository repository, ILogger<AuditMiddleware> logger)
    {
        await _next(context);

        if (!MutatingMethods.Contains(context.Request.Method) ||
            !context.Request.Path.StartsWithSegments("/api"))
        {
            return;
        }

        try
        {
            var source = $"{context.Request.Method} {context.Request.Path}";
            var status = context.Response.StatusCode;
            // Use a fresh token: the request may already be completing, but the
            // audit write should still land.
            await repository.WriteAuditAsync(source, status < 400, $"HTTP {status}", CancellationToken.None);
        }
        catch (Exception ex)
        {
            logger.LogWarning(ex, "Failed to write audit entry for {Method} {Path}",
                context.Request.Method, context.Request.Path);
        }
    }
}
