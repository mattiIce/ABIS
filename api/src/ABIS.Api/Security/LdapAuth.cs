using Novell.Directory.Ldap;

namespace Abis.Api.Security;

/// <summary>On-prem Active Directory sign-in via an LDAP simple-bind, bound from <c>Auth:Ldap</c>.
/// When enabled, <c>POST /auth/login</c> verifies the password by binding to a domain controller with
/// the user's AD credential instead of the local PBKDF2 store — the ABIS <c>security_user</c> still
/// supplies identity + RBAC (so the AD sAMAccountName must equal the ABIS <c>login_id</c>). Off by
/// default; dev/local keeps using the credential store.</summary>
public sealed class LdapOptions
{
    public const string SectionName = "Auth:Ldap";

    public bool Enabled { get; set; }
    public string? Host { get; set; }                    // a single domain controller (convenience)
    public string[]? Hosts { get; set; }                 // one or more DCs, tried in order (primary first) for failover
    public int Port { get; set; }                        // 0 = default (636 LDAPS, else 389)
    public bool UseSsl { get; set; } = true;             // LDAPS — recommended; the password is sent to the DC
    /// <summary>Accept any DC server certificate (for an internal self-signed/private-CA DC on a
    /// trusted LAN). Leave false and trust the DC's CA on the host for a real chain check.</summary>
    public bool AcceptAnyCertificate { get; set; }
    /// <summary>How the entered username becomes a bind identity, with <c>{0}</c> = the bare username.
    /// AD accepts a UPN (<c>{0}@abc.local</c>) or NetBIOS form (<c>ABC\{0}</c>). Required when enabled.</summary>
    public string? UserBindFormat { get; set; }
    public int TimeoutSeconds { get; set; } = 8;

    public int EffectivePort => Port > 0 ? Port : (UseSsl ? 636 : 389);

    /// <summary>The domain controllers to try, primary first: <see cref="Hosts"/> if given, else the
    /// single <see cref="Host"/>.</summary>
    public IReadOnlyList<string> EffectiveHosts =>
        Hosts is { Length: > 0 }
            ? Hosts.Where(h => !string.IsNullOrWhiteSpace(h)).Select(h => h.Trim()).ToArray()
            : (!string.IsNullOrWhiteSpace(Host) ? new[] { Host.Trim() } : Array.Empty<string>());

    /// <summary>Enabled AND the essentials are present — a half-filled section must not silently take
    /// over sign-in and then reject everyone.</summary>
    public bool IsUsable => Enabled && EffectiveHosts.Count > 0 && !string.IsNullOrWhiteSpace(UserBindFormat);

    /// <summary>
    /// Why the bind format looks wrong, or null when it looks sane. A bind identity is either a UPN
    /// (<c>user@domain.com</c>) or NetBIOS (<c>DOMAIN\\user</c>) - both carry a separator. A format with
    /// <c>{0}</c> but NO separator produces a single run-together string that AD refuses.
    ///
    /// <para>That is a real failure, not a hypothetical: systemd interprets backslash escapes in an
    /// EnvironmentFile, so <c>Auth__Ldap__UserBindFormat=ALBL\\{0}</c> reached the app as
    /// <c>ALBL{0}</c> and every sign-in bound as <c>ALBLsomeone</c>. The password was right, the
    /// identity was malformed, and the login page said "the username or password is incorrect" -
    /// which is exactly the wrong place to look. Double the backslash in the env file.</para>
    /// </summary>
    public string? BindFormatWarning =>
        !Enabled || string.IsNullOrWhiteSpace(UserBindFormat) ? null
        : !UserBindFormat!.Contains("{0}") ? $"Auth:Ldap:UserBindFormat ('{UserBindFormat}') has no {{0}} placeholder, so every bind uses the same literal identity."
        : UserBindFormat!.IndexOf('\\') < 0 && UserBindFormat!.IndexOf('@') < 0
            ? $"Auth:Ldap:UserBindFormat ('{UserBindFormat}') has no '@' or backslash separator, so it binds as one run-together string and AD will refuse every sign-in. "
              + "If you meant DOMAIN\\\\user, DOUBLE the backslash in /etc/abis/abis.env - systemd eats a single one."
            : null;
}

/// <summary>
/// What an AD bind attempt actually concluded. The distinction is not cosmetic: a reachable DC that
/// refuses the password and a DC nobody can reach are completely different problems for the person
/// signing in - "retype it" versus "call IT" - and reporting both as "incorrect password" sends them
/// hunting the wrong one.
///
/// <para>This is not hypothetical. On 2026-08-21 both DCs rejected the app's TLS handshake (their
/// LDAPS certificates come from an internal CA the Linux host did not trust). Every sign-in answered
/// "The username or password is incorrect", and the real cause was only visible in a Warning-level
/// log line on the server.</para>
/// </summary>
public enum LdapOutcome
{
    /// <summary>A DC accepted the credentials.</summary>
    Authenticated,
    /// <summary>A DC was reached and REFUSED the credentials. Authoritative - the password is wrong.</summary>
    Rejected,
    /// <summary>No DC could be reached or negotiated with (network, TLS, or misconfiguration). Says
    /// nothing at all about whether the password is right.</summary>
    Unreachable,
}

/// <summary>Validates a username/password against Active Directory. Abstracted so
/// <c>/auth/login</c> is unit-testable without a live domain controller.</summary>
public interface ILdapAuthenticator
{
    /// <summary>Whether AD-bind sign-in is configured and should be used by <c>/auth/login</c>.</summary>
    bool Enabled { get; }

    /// <summary>Attempt an LDAP simple-bind with these credentials and report what happened. The caller
    /// must not pass an empty password (an LDAP unauthenticated-bind succeeds without checking) — this
    /// also guards it.</summary>
    Task<LdapOutcome> ValidateAsync(string username, string password, CancellationToken ct);
}

/// <summary>Novell.Directory.Ldap (pure-managed) implementation of <see cref="ILdapAuthenticator"/>.</summary>
public sealed class LdapAuthenticator(LdapOptions opt, ILogger<LdapAuthenticator> log) : ILdapAuthenticator
{
    public bool Enabled => opt.IsUsable;

    public Task<LdapOutcome> ValidateAsync(string username, string password, CancellationToken ct)
    {
        // Never bind with an empty/whitespace password: an LDAP simple-bind with a DN and empty
        // password is an "unauthenticated bind" that SUCCEEDS without authenticating. Reject up front.
        if (!Enabled || string.IsNullOrWhiteSpace(username) || string.IsNullOrEmpty(password))
            return Task.FromResult(LdapOutcome.Rejected);

        var bindDn = string.Format(opt.UserBindFormat!, username);

        // Novell's client is synchronous/blocking; run it off the request thread and honour cancellation.
        return Task.Run(() =>
        {
            // Try each DC in order (primary first). A reachable DC that REJECTS the password is
            // authoritative (stop — the other DC would reject it too); a DC we can't reach is skipped
            // so we fail over to the next.
            foreach (var host in opt.EffectiveHosts)
            {
                try
                {
                    var options = new LdapConnectionOptions();
                    if (opt.UseSsl) options.UseSsl();
                    if (opt.AcceptAnyCertificate) options.ConfigureRemoteCertificateValidationCallback((_, _, _, _) => true);

                    using var conn = new LdapConnection(options) { ConnectionTimeout = opt.TimeoutSeconds * 1000 };
                    conn.Connect(host, opt.EffectivePort);
                    conn.Bind(bindDn, password);
                    var ok = conn.Bound;
                    conn.Disconnect();
                    return ok ? LdapOutcome.Authenticated : LdapOutcome.Rejected;
                }
                catch (LdapException ex) when (ex.ResultCode == LdapException.InvalidCredentials)
                {
                    // Wrong password from a reachable DC — definitive; don't try the other DC.
                    log.LogDebug("LDAP bind rejected for {BindDn} on {Host}: invalid credentials", bindDn, host);
                    return LdapOutcome.Rejected;
                }
                catch (Exception ex)
                {
                    // This DC is unreachable / TLS / other — try the next one (failover).
                    log.LogWarning(ex, "LDAP error on {Host}:{Port}; trying next DC if any", host, opt.EffectivePort);
                }
            }
            // Every DC threw. That is NOT a wrong password, and saying so is the point of this type.
            log.LogError("No domain controller could be reached for {BindDn} ({Count} tried on port {Port}). "
                + "Sign-in cannot verify any password until this is fixed - check DC reachability and, for "
                + "LDAPS, that this host trusts the CA that issued the DC certificates.",
                bindDn, opt.EffectiveHosts.Count, opt.EffectivePort);
            return LdapOutcome.Unreachable;
        }, ct);
    }
}

/// <summary>DI wiring for AD sign-in. Always registered (the authenticator reports
/// <see cref="ILdapAuthenticator.Enabled"/> = false when <c>Auth:Ldap</c> isn't configured).</summary>
public static class LdapSetup
{
    public static void AddAbisLdap(this WebApplicationBuilder builder)
    {
        var opt = builder.Configuration.GetSection(LdapOptions.SectionName).Get<LdapOptions>() ?? new LdapOptions();
        builder.Services.AddSingleton(opt);
        builder.Services.AddSingleton<ILdapAuthenticator, LdapAuthenticator>();
    }
}
