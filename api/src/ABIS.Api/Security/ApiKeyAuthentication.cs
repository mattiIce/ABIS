using System.Security.Claims;
using System.Text.Encodings.Web;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;

namespace Abis.Api.Security;

/// <summary>Bound from the "ApiKeys" configuration section.</summary>
public sealed class ApiKeyOptions
{
    public const string SectionName = "ApiKeys";

    /// <summary>When false, all callers are accepted (useful for trusted internal
    /// networks). Defaults to true — keys must be configured to call <c>/api</c>.</summary>
    public bool Enabled { get; set; } = true;

    public string HeaderName { get; set; } = "X-Api-Key";

    /// <summary>Accepted keys. Supply via configuration/secret, never hard-coded.</summary>
    public string[] Keys { get; set; } = [];
}

/// <summary>
/// Minimal API-key authentication: callers present a shared secret in a header
/// (default <c>X-Api-Key</c>) which is matched against the configured keys. This
/// is a pragmatic first gate for the seam; a production deployment may later swap
/// in OAuth/OIDC without changing the endpoints (they just require an authenticated
/// principal).
/// </summary>
public sealed class ApiKeyAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
{
    public const string SchemeName = "ApiKey";

    private readonly ApiKeyOptions _keys;

    public ApiKeyAuthenticationHandler(
        IOptionsMonitor<AuthenticationSchemeOptions> options,
        ILoggerFactory logger,
        UrlEncoder encoder,
        ApiKeyOptions keys)
        : base(options, logger, encoder)
    {
        _keys = keys;
    }

    protected override Task<AuthenticateResult> HandleAuthenticateAsync()
    {
        if (!_keys.Enabled)
            return Task.FromResult(AuthenticateResult.Success(Ticket("anonymous")));

        if (!Request.Headers.TryGetValue(_keys.HeaderName, out var provided) ||
            string.IsNullOrWhiteSpace(provided))
        {
            return Task.FromResult(AuthenticateResult.Fail($"Missing {_keys.HeaderName} header."));
        }

        if (!_keys.Keys.Contains(provided.ToString(), StringComparer.Ordinal))
            return Task.FromResult(AuthenticateResult.Fail("Invalid API key."));

        return Task.FromResult(AuthenticateResult.Success(Ticket("api-client")));
    }

    private AuthenticationTicket Ticket(string name)
    {
        var identity = new ClaimsIdentity([new Claim(ClaimTypes.Name, name)], SchemeName);
        return new AuthenticationTicket(new ClaimsPrincipal(identity), SchemeName);
    }
}
