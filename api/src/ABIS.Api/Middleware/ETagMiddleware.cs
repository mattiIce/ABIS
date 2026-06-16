using System.Security.Cryptography;

namespace Abis.Api.Middleware;

/// <summary>
/// Adds HTTP caching to <c>/api</c> GETs: buffers a successful response, derives a
/// weak <c>ETag</c> from its bytes, and — when the caller sends a matching
/// <c>If-None-Match</c> — short-circuits to <c>304 Not Modified</c> with no body.
/// Cheap bandwidth savings for the polling shop-floor screens; a no-op for writes,
/// non-200s, and empty bodies. (Foundation for <c>If-Match</c> optimistic
/// concurrency once the real schema provides a row version.)
/// </summary>
public sealed class ETagMiddleware
{
    private readonly RequestDelegate _next;

    public ETagMiddleware(RequestDelegate next) => _next = next;

    public async Task InvokeAsync(HttpContext context)
    {
        // Only GETs under /api are cacheable here; everything else passes through.
        if (!HttpMethods.IsGet(context.Request.Method) ||
            !context.Request.Path.StartsWithSegments("/api"))
        {
            await _next(context);
            return;
        }

        var originalBody = context.Response.Body;
        using var buffer = new MemoryStream();
        context.Response.Body = buffer;

        try
        {
            await _next(context);

            buffer.Position = 0;
            // Only hash a normal 200 with content; otherwise stream the buffer back as-is.
            if (context.Response.StatusCode == StatusCodes.Status200OK && buffer.Length > 0)
            {
                var etag = ComputeWeakETag(buffer);
                context.Response.Headers.ETag = etag;

                var ifNoneMatch = context.Request.Headers.IfNoneMatch.ToString();
                if (!string.IsNullOrEmpty(ifNoneMatch) && ifNoneMatch.Split(',').Any(t => t.Trim() == etag))
                {
                    context.Response.StatusCode = StatusCodes.Status304NotModified;
                    context.Response.Headers.ContentLength = null;
                    context.Response.Body = originalBody;
                    return;
                }
            }

            context.Response.Body = originalBody;
            buffer.Position = 0;
            await buffer.CopyToAsync(originalBody);
        }
        finally
        {
            context.Response.Body = originalBody;
        }
    }

    private static string ComputeWeakETag(Stream content)
    {
        content.Position = 0;
        var hash = SHA256.HashData(content);
        content.Position = 0;
        // Weak validator: semantic equivalence is all we promise.
        return $"W/\"{Convert.ToHexString(hash, 0, 8)}\"";
    }
}
