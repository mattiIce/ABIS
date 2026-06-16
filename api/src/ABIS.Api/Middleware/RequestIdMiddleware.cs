using System.Text.RegularExpressions;

namespace Abis.Api.Middleware;

/// <summary>
/// Assigns each request a correlation id: it honors a caller-supplied
/// <c>X-Request-Id</c> (when it looks safe) or generates one, stashes it in
/// <see cref="HttpContext.Items"/> for downstream use (audit trail, ProblemDetails),
/// and echoes it on the response so clients and logs can correlate a call.
/// Registered first so the id exists for everything that follows.
/// </summary>
public sealed class RequestIdMiddleware
{
    public const string HeaderName = "X-Request-Id";
    public const string ItemKey = "RequestId";

    // Conservative: a short token of safe characters; anything else is replaced.
    private static readonly Regex Safe = new("^[A-Za-z0-9._-]{1,128}$", RegexOptions.Compiled);

    private readonly RequestDelegate _next;

    public RequestIdMiddleware(RequestDelegate next) => _next = next;

    public async Task InvokeAsync(HttpContext context)
    {
        var incoming = context.Request.Headers[HeaderName].ToString();
        var requestId = !string.IsNullOrEmpty(incoming) && Safe.IsMatch(incoming)
            ? incoming
            : Guid.NewGuid().ToString("N");

        context.Items[ItemKey] = requestId;
        // Set before the response starts so it is present even on early/short circuits.
        context.Response.OnStarting(() =>
        {
            context.Response.Headers[HeaderName] = requestId;
            return Task.CompletedTask;
        });

        await _next(context);
    }

    /// <summary>The correlation id assigned to the current request, if any.</summary>
    public static string? Current(HttpContext context) =>
        context.Items.TryGetValue(ItemKey, out var value) ? value as string : null;
}
