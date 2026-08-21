using Abis.Api.Security;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The bind-format sanity check — and the misconfiguration that made it necessary.
///
/// <para>systemd interprets backslash escapes in an <c>EnvironmentFile</c>, so
/// <c>Auth__Ldap__UserBindFormat=ALBL\{0}</c> reached the app as <c>ALBL{0}</c>. Every sign-in then
/// bound to AD as <c>ALBLsomeone</c> instead of <c>ALBL\someone</c>, AD refused it, and the login page
/// reported "the username or password is incorrect" — sending the operator to check the one thing that
/// was not wrong. It cost most of a morning, and the only clue was a Debug-level log line.</para>
/// </summary>
public class LdapBindFormatTests
{
    private static LdapOptions Opts(string? format) => new()
    {
        Enabled = true,
        Hosts = ["dc1.example.com"],
        UserBindFormat = format,
    };

    /// <summary>The exact shape of the real failure: the separator eaten, everything else intact.</summary>
    [Fact]
    public void A_format_whose_backslash_was_swallowed_is_flagged()
    {
        var warning = Opts("ALBL{0}").BindFormatWarning;
        Assert.NotNull(warning);
        Assert.Contains("separator", warning);
        // The message has to name the cure, not just the symptom — whoever reads it is looking at a
        // login box that says "wrong password" and has no reason to suspect systemd.
        Assert.Contains("DOUBLE the backslash", warning);
    }

    [Theory]
    [InlineData(@"ALBL\{0}")]      // NetBIOS, correctly escaped by the time it reaches us
    [InlineData("{0}@albl.com")]   // UPN — no backslash to lose, which is why it is the safer choice
    [InlineData(@"CORP\{0}")]
    public void A_well_formed_bind_format_is_not_flagged(string format)
    {
        Assert.Null(Opts(format).BindFormatWarning);
    }

    /// <summary>Without the placeholder every user binds as the same literal string — a different
    /// misconfiguration with the same "wrong password" symptom.</summary>
    [Fact]
    public void A_format_with_no_placeholder_is_flagged()
    {
        var warning = Opts(@"ALBL\administrator").BindFormatWarning;
        Assert.NotNull(warning);
        Assert.Contains("placeholder", warning);
    }

    /// <summary>Silence when LDAP is off, or half-configured — a disabled section must not shout.</summary>
    [Theory]
    [InlineData(false, "ALBL{0}")]
    [InlineData(true, null)]
    [InlineData(true, "")]
    public void Nothing_is_flagged_when_there_is_nothing_to_judge(bool enabled, string? format)
    {
        var o = Opts(format);
        o.Enabled = enabled;
        Assert.Null(o.BindFormatWarning);
    }

    /// <summary>A reachable DC that refuses is authoritative; an unreachable one says nothing about the
    /// password. Conflating them is what sent the operator hunting their own credentials.</summary>
    [Fact]
    public void The_three_outcomes_are_distinct()
    {
        Assert.NotEqual(LdapOutcome.Rejected, LdapOutcome.Unreachable);
        Assert.NotEqual(LdapOutcome.Authenticated, LdapOutcome.Rejected);
    }
}
