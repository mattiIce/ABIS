using Abis.Api.Data;

namespace Abis.Api.Middleware;

/// <summary>
/// Records every mutating API request (POST/PUT/PATCH/DELETE under <c>/api</c>)
/// into the legacy <c>opc_action_log</c> table, giving the new seam the same
/// kind of audit trail the legacy app keeps. Auditing is best-effort: a failure
/// to write the log never fails the request.
///
/// It can be turned off via <c>Audit:Enabled=false</c>, and it self-disables
/// after the first write failure (logging once) so a missing/incompatible audit
/// table — e.g. the live DBO schema has no <c>opc_action_log</c> — does not
/// produce a warning on every request.
///
/// Registered as the outermost middleware so it observes the final response
/// status (including statuses produced by the exception handler).
/// </summary>
public sealed class AuditMiddleware
{
    private static readonly HashSet<string> MutatingMethods =
        new(StringComparer.OrdinalIgnoreCase) { "POST", "PUT", "PATCH", "DELETE" };

    private readonly RequestDelegate _next;
    private readonly AuditOptions _options;
    // Set once after a write fails, so we stop attempting (and stop warning) for
    // the lifetime of the process. Audit is best-effort; correctness is unaffected.
    private volatile bool _disabled;

    public AuditMiddleware(RequestDelegate next, AuditOptions options)
    {
        _next = next;
        _options = options;
    }

    public async Task InvokeAsync(HttpContext context, IAbisRepository repository, ILogger<AuditMiddleware> logger)
    {
        await _next(context);

        if (_disabled || !_options.Enabled ||
            !MutatingMethods.Contains(context.Request.Method) ||
            !context.Request.Path.StartsWithSegments("/api"))
        {
            return;
        }

        try
        {
            var source = $"{context.Request.Method} {context.Request.Path}";
            var status = context.Response.StatusCode;
            var requestId = RequestIdMiddleware.Current(context);
            var notes = requestId is null ? $"HTTP {status}" : $"HTTP {status} req {requestId}";
            // Use a fresh token: the request may already be completing, but the
            // audit write should still land.
            await repository.WriteAuditAsync(source, status < 400, notes, CancellationToken.None);
        }
        catch (Exception ex)
        {
            // Disable after the first failure (e.g. the audit table is absent on
            // this schema) so we don't attempt — or warn — on every request.
            _disabled = true;
            logger.LogWarning(ex,
                "Audit logging disabled after a write failure for {Method} {Path}. " +
                "Set Audit:Enabled=false to silence this, or configure a valid audit table.",
                context.Request.Method, context.Request.Path);
        }
    }
}
