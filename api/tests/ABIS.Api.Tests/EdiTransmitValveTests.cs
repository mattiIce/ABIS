using System.Linq;
using System.Text.RegularExpressions;
using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Abis.Api.Edi;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The EDI transmit valve.
///
/// <para><b>What it guards.</b> Legacy owns transmission today: <c>ediprocess.sh</c> generates and
/// <c>GXS.ksh</c> SFTPs <c>S*.edi</c> to the Inovis VAN. If ABIS also emits a document for the same
/// shipment the trading partner receives it twice, and partners reconcile receipts and invoices off
/// these — a duplicate 856 can become a double receipt.</para>
///
/// <para><b>Two gates, ANDed.</b> The valve is the shape for OFF: one switch, no reasoning about
/// partners. Per-partner arming is the shape for ON, because opening globally would duplicate the three
/// documents legacy still sends.</para>
///
/// <para><b>Everything fails closed</b>, and that asymmetry is the point: a false stop leaves a document
/// in the database where somebody can see it and send it again; a false go puts a duplicate in front of
/// a trading partner, where it cannot be recalled.</para>
/// </summary>
public sealed class EdiTransmitValveTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        private readonly string _dbPath = Path.Combine(Path.GetTempPath(), $"abis_valve_{Guid.NewGuid():N}.db");
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={_dbPath}");
            builder.UseSetting("Database:Seed", "true");
            builder.UseSetting("ApiKeys:Enabled", "true");
            builder.UseSetting("ApiKeys:Keys:0", "test-key");
        }
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
        }
    }

    private static HttpClient Client(WebApplicationFactory<Program> f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        return c;
    }

    private static async Task<JsonElement> PolicyAsync(HttpClient c) =>
        await c.GetFromJsonAsync<JsonElement>("/api/admin/edi/transmit");

    // ---- the shipped state ---------------------------------------------------

    /// <summary>The state it ships in, and the one it must spend most of its life in.</summary>
    [Fact]
    public async Task The_valve_ships_closed()
    {
        using var f = new Factory();
        var p = await PolicyAsync(Client(f));

        Assert.False(p.GetProperty("valveOpen").GetBoolean());
        Assert.False(p.GetProperty("transmitting").GetBoolean());
        Assert.Empty(p.GetProperty("armed").EnumerateArray());
    }

    // ---- the gate's decision logic ------------------------------------------

    [Fact]
    public void A_closed_valve_refuses_even_an_armed_pair()
    {
        var policy = new EdiTransmitPolicy(false, new HashSet<(string, long)> { ("861", 1153) });
        Assert.False(policy.Allows("861", 1153));
    }

    [Fact]
    public void An_open_valve_still_refuses_a_pair_that_is_not_armed()
    {
        // The whole reason arming is per-partner: legacy still sends Aleris 870, so an open valve must
        // not imply "send everything".
        var policy = new EdiTransmitPolicy(true, new HashSet<(string, long)> { ("861", 1153) });
        Assert.True(policy.Allows("861", 1153));
        Assert.False(policy.Allows("870", 1980));
        Assert.False(policy.Allows("861", 1980));
    }

    /// <summary>A document we cannot attribute to a customer cannot be authorised for one.</summary>
    [Fact]
    public void A_document_with_no_customer_is_never_allowed()
    {
        var policy = new EdiTransmitPolicy(true, new HashSet<(string, long)> { ("861", 1153) });
        Assert.False(policy.Allows("861", null));
    }

    [Fact]
    public void The_shipped_default_allows_nothing()
    {
        Assert.False(EdiTransmitPolicy.Closed.ValveOpen);
        Assert.False(EdiTransmitPolicy.Closed.Allows("861", 1153));
    }

    // ---- the transport ------------------------------------------------------

    private static FileDropEdiTransport Transport(EdiTransmitPolicy policy, string outbox) =>
        new(new StubGate(policy),
            Options.Create(new EdiOutboxOptions { Path = outbox }),
            NullLogger<FileDropEdiTransport>.Instance);

    private sealed class StubGate(EdiTransmitPolicy policy) : IEdiTransmitGate
    {
        public Task<EdiTransmitPolicy> GetPolicyAsync(CancellationToken ct) => Task.FromResult(policy);
    }

    [Fact]
    public async Task Nothing_is_written_when_the_valve_is_closed()
    {
        var dir = Directory.CreateTempSubdirectory().FullName;
        try
        {
            var r = await Transport(EdiTransmitPolicy.Closed, dir)
                .SendAsync("S123.edi", "Novelis", "ISA*...", "861", 1153, CancellationToken.None);

            Assert.False(r.Transmitted);
            Assert.Empty(Directory.GetFiles(dir));
            Assert.Contains("switched off", r.Detail);
        }
        finally { Directory.Delete(dir, true); }
    }

    [Fact]
    public async Task An_armed_pair_is_written_to_the_outbox()
    {
        var dir = Directory.CreateTempSubdirectory().FullName;
        try
        {
            var policy = new EdiTransmitPolicy(true, new HashSet<(string, long)> { ("861", 1153) });
            var r = await Transport(policy, dir)
                .SendAsync("S123.edi", "Novelis", "ISA*PAYLOAD", "861", 1153, CancellationToken.None);

            Assert.True(r.Transmitted);
            var written = Assert.Single(Directory.GetFiles(dir));
            Assert.Equal("ISA*PAYLOAD", await File.ReadAllTextAsync(written));
        }
        finally { Directory.Delete(dir, true); }
    }

    /// <summary>
    /// A missing outbox is refused, never created. If it is a mount and the mount is down, creating it
    /// would silently pile documents into a local directory nobody collects — and that failure looks
    /// exactly like success until a partner notices they stopped receiving.
    /// </summary>
    [Fact]
    public async Task A_missing_outbox_directory_is_refused_and_not_created()
    {
        var missing = Path.Combine(Path.GetTempPath(), $"abis_no_such_outbox_{Guid.NewGuid():N}");
        var policy = new EdiTransmitPolicy(true, new HashSet<(string, long)> { ("861", 1153) });

        var r = await Transport(policy, missing)
            .SendAsync("S1.edi", "Novelis", "ISA*...", "861", 1153, CancellationToken.None);

        Assert.False(r.Transmitted);
        Assert.False(Directory.Exists(missing));
    }

    [Fact]
    public async Task No_configured_outbox_means_nothing_can_be_sent()
    {
        var policy = new EdiTransmitPolicy(true, new HashSet<(string, long)> { ("861", 1153) });
        var r = await Transport(policy, "")
            .SendAsync("S1.edi", "Novelis", "ISA*...", "861", 1153, CancellationToken.None);

        Assert.False(r.Transmitted);
    }

    /// <summary>
    /// The cron MOVES what it collects, so a name still sitting there is one it has not sent yet.
    /// Overwriting it would replace a document already on its way out.
    /// </summary>
    [Fact]
    public async Task An_uncollected_file_is_never_overwritten()
    {
        var dir = Directory.CreateTempSubdirectory().FullName;
        try
        {
            await File.WriteAllTextAsync(Path.Combine(dir, "S123.edi"), "FIRST");
            var policy = new EdiTransmitPolicy(true, new HashSet<(string, long)> { ("861", 1153) });

            var r = await Transport(policy, dir)
                .SendAsync("S123.edi", "Novelis", "SECOND", "861", 1153, CancellationToken.None);

            Assert.False(r.Transmitted);
            Assert.Equal("FIRST", await File.ReadAllTextAsync(Path.Combine(dir, "S123.edi")));
        }
        finally { Directory.Delete(dir, true); }
    }

    /// <summary>
    /// The name has to match what <c>GXS.ksh</c>'s <c>mput S*.edi</c> collects and its backup step
    /// moves. A name outside that pattern would be written and then never sent or cleaned up.
    /// </summary>
    [Theory]
    [InlineData("S123.edi", "S123.edi")]
    [InlineData("123.edi", "S123.edi")]
    [InlineData("S123", "S123.edi")]
    [InlineData("", "S_unnamed.edi")]
    public void The_filename_always_matches_what_the_cron_collects(string given, string expected)
    {
        Assert.Equal(expected, FileDropEdiTransport.SafeFileName(given));
    }

    /// <summary>A generated name must never steer where the file lands.</summary>
    [Fact]
    public void A_path_in_the_filename_is_stripped()
    {
        var safe = FileDropEdiTransport.SafeFileName("../../etc/S9.edi");
        Assert.Equal("S9.edi", safe);
        Assert.DoesNotContain("..", safe);
        Assert.DoesNotContain('/', safe);
    }

    // ---- arming, and the duplicate warning ----------------------------------

    [Fact]
    public async Task Opening_the_valve_requires_a_reason()
    {
        using var f = new Factory();
        var res = await Client(f).PutAsJsonAsync("/api/admin/edi/transmit/valve", new { open = true, note = "" });
        Assert.Equal(HttpStatusCode.BadRequest, res.StatusCode);
    }

    /// <summary>Closing must never be gated on paperwork — it can only make things safer.</summary>
    [Fact]
    public async Task Closing_the_valve_needs_no_reason()
    {
        using var f = new Factory();
        var res = await Client(f).PutAsJsonAsync("/api/admin/edi/transmit/valve", new { open = false, note = (string?)null });
        Assert.True(res.IsSuccessStatusCode);
    }

    /// <summary>
    /// The check that earns this feature: arming a document legacy still sends must say so, and name
    /// the line to comment out.
    /// </summary>
    [Fact]
    public async Task Arming_a_document_legacy_still_sends_warns_and_names_the_cron_line()
    {
        using var f = new Factory();
        var res = await Client(f).PutAsJsonAsync("/api/admin/edi/transmit/arm",
            new { transactionType = "870", customerId = 1980, armed = true, note = "cutover test" });

        res.EnsureSuccessStatusCode();
        var body = await res.Content.ReadFromJsonAsync<JsonElement>();
        var warning = body.GetProperty("warning").GetString();

        Assert.NotNull(warning);
        Assert.Contains("edi_aleris_870", warning);
    }

    [Fact]
    public async Task Arming_a_document_legacy_does_not_send_carries_no_warning()
    {
        using var f = new Factory();
        var res = await Client(f).PutAsJsonAsync("/api/admin/edi/transmit/arm",
            new { transactionType = "846", customerId = 3061, armed = true, note = "cliffs" });

        res.EnsureSuccessStatusCode();
        var body = await res.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal(JsonValueKind.Null, body.GetProperty("warning").ValueKind);
    }

    /// <summary>"All partners" is the mistake that duplicates what legacy sends, so it cannot be said.</summary>
    [Fact]
    public async Task Arming_without_a_named_partner_is_refused()
    {
        using var f = new Factory();
        var res = await Client(f).PutAsJsonAsync("/api/admin/edi/transmit/arm",
            new { transactionType = "861", customerId = (long?)null, armed = true, note = "all" });

        Assert.Equal(HttpStatusCode.BadRequest, res.StatusCode);
    }

    /// <summary>Arming alone must not transmit: the valve still has to be opened.</summary>
    [Fact]
    public async Task Arming_a_pair_does_not_by_itself_open_the_valve()
    {
        using var f = new Factory();
        var c = Client(f);
        await c.PutAsJsonAsync("/api/admin/edi/transmit/arm",
            new { transactionType = "846", customerId = 3061, armed = true, note = "x" });

        var p = await PolicyAsync(c);
        Assert.False(p.GetProperty("valveOpen").GetBoolean());
        Assert.False(p.GetProperty("transmitting").GetBoolean());
    }

    // ---- the funnel is not connected ----------------------------------------

    /// <summary>
    /// The claim this PR rests on: the machinery exists but NOTHING hands a document to it, so ABIS
    /// still transmits nothing whatever the valve says. Wiring that funnel is a separate, deliberate
    /// change — and when it happens, this test is what should fail and be updated on purpose.
    /// </summary>
    [Fact]
    public void No_generation_path_calls_the_transport_yet()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null && !Directory.Exists(Path.Combine(dir.FullName, "src", "ABIS.Api")))
            dir = dir.Parent;
        Assert.NotNull(dir);
        var api = Path.Combine(dir!.FullName, "src", "ABIS.Api");

        // A CONSUMER declares it — `IEdiTransport transport` as a parameter or field. The composition
        // root only names it as a generic argument (`AddScoped<…IEdiTransport, …>`), which is followed
        // by a comma rather than an identifier, so registering does not count as calling. Matching on
        // ".SendAsync(" alone would trip on Program.cs's EMAIL sender, which is a different interface.
        var callers = Directory.GetFiles(api, "*.cs", SearchOption.AllDirectories)
            .Where(f => !Path.GetDirectoryName(f)!.EndsWith("Edi", StringComparison.Ordinal))
            .Where(f => Regex.IsMatch(File.ReadAllText(f), @"IEdiTransport\s+\w"))
            .ToList();

        Assert.True(callers.Count == 0,
            "Something now hands a document to IEdiTransport. That is the funnel — it is supposed to be a "
            + "separate, deliberate change, and this test should be updated in the same PR that makes it. "
            + "Files: " + string.Join(", ", callers.Select(Path.GetFileName)));
    }
}
