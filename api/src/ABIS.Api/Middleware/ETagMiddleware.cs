using System.Security.Cryptography;
using System.Text.Json;

namespace Abis.Api.Middleware;

/// <summary>
/// Adds HTTP caching to <c>/api</c> GETs: buffers a successful response, derives a
/// weak <c>ETag</c> from its bytes, and — when the caller sends a matching
/// <c>If-None-Match</c> — short-circuits to <c>304 Not Modified</c> with no body.
/// Cheap bandwidth savings for the polling shop-floor screens; a no-op for writes,
/// non-200s, and empty bodies. The same content hash powers <c>If-Match</c>
/// optimistic concurrency on writes (see <see cref="ForEntity"/>) — no row-version
/// column is needed, which suits the legacy schema (it has none).
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

                // 304 when the caller's validator matches: an exact tag or "*"
                // (RFC 7232 — match any current representation).
                var ifNoneMatch = context.Request.Headers.IfNoneMatch.ToString();
                if (!string.IsNullOrEmpty(ifNoneMatch) &&
                    ifNoneMatch.Split(',').Any(t => { var v = t.Trim(); return v == etag || v == "*"; }))
                {
                    context.Response.StatusCode = StatusCodes.Status304NotModified;
                    context.Response.Headers.ContentLength = null;
                    context.Response.Headers.ContentType = default;   // no representation body on a 304
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
        return Format(hash);
    }

    /// <summary>Computes the same weak ETag a GET of <paramref name="entity"/> would
    /// carry, by serializing it with the framework's JSON options (so the bytes match
    /// the GET response body). Used for <c>If-Match</c> optimistic concurrency on writes.</summary>
    public static string ForEntity(object entity, JsonSerializerOptions options)
        => Format(SHA256.HashData(JsonSerializer.SerializeToUtf8Bytes(entity, options)));

    // Weak validator: semantic equivalence is all we promise.
    private static string Format(byte[] hash) => $"W/\"{Convert.ToHexString(hash, 0, 8)}\"";
}
