using System.Reflection;
using Abis.Api.Data;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The features this app gates on must exist in <c>security_application</c>, and that table is part of
/// the LEGACY schema — so a Data Pump refresh from production restores production's copy, which has
/// never heard of them. Every refresh silently deletes them again.
///
/// <para>By 2026-08-21 all four were absent from <c>.230</c>. A signed-in user therefore got <b>403</b>
/// on every Parts write, every maintenance/PM write and both admin consoles — while the API key sailed
/// through, because it bypasses RBAC entirely. Nothing in CI could see it: the suite authenticates with
/// the API key.</para>
///
/// <para>These tests guard the two halves of that: the app self-heals at startup, and the map it gates
/// on cannot drift from the list it restores.</para>
/// </summary>
public class RequiredFeatureTests
{
    /// <summary>Read the private tag→feature map the RBAC filter uses.</summary>
    private static IReadOnlyDictionary<string, string> FeatureByTag() =>
        (IReadOnlyDictionary<string, string>)typeof(Abis.Api.Endpoints.ApiEndpoints)
            .GetField("FeatureByTag", BindingFlags.NonPublic | BindingFlags.Static)!
            .GetValue(null)!;

    /// <summary>The list the plant's live database actually holds — captured from
    /// <c>security_application</c> on <c>.230</c>, 2026-08-21. Anything a tag maps to that is NOT here
    /// has to be in <see cref="AbisSchema.RequiredFeatures"/>, or it gates on a name nobody can hold.</summary>
    private static readonly HashSet<string> LiveLegacyFeatures = new(StringComparer.OrdinalIgnoreCase)
    {
        "Carrier Information", "Customer Information", "Daily Production", "Downtime report", "EDI",
        "End User Change", "Inventory(Coil)", "Inventory(ReCap)", "Inventory(Skid)", "Line Employees",
        "Line-BL110", "Line-BL84", "New Pallet Ticket", "Office Entry", "Order Entry",
        "Production Control", "Production Line Schedule", "Production Sketch", "Quality Control",
        "Quotation(Circle)", "Quotation(Sheet)", "Scrap Handling", "Shift Control", "Shift Scheduler",
        "Shipment(Control)", "Shipment(Loading)", "Shipment(Receiving)", "Shipment(Rehash)",
        "Surveillance", "System Log", "Table yield_strength", "User Control", "User Group Control",
        "User Password", "Warehouse",
    };

    /// <summary>
    /// The invariant that would have caught this three times over: <b>every feature the app gates on is
    /// either one the legacy schema defines, or one the app restores itself.</b> A name in neither is a
    /// phantom — it gates a write that no user on earth can perform, and it fails as a 403 rather than
    /// as anything that looks like a bug.
    /// </summary>
    [Fact]
    public void Every_gated_feature_is_either_legacy_or_self_restored()
    {
        var restored = AbisSchema.RequiredFeatures.Select(f => f.Name).ToHashSet(StringComparer.OrdinalIgnoreCase);
        var phantom = FeatureByTag()
            .Where(kv => !LiveLegacyFeatures.Contains(kv.Value) && !restored.Contains(kv.Value))
            .Select(kv => $"{kv.Key} -> '{kv.Value}'")
            .ToArray();

        Assert.True(phantom.Length == 0,
            "These tags gate on a feature that neither the legacy schema defines nor AbisSchema.RequiredFeatures "
            + "restores, so every write behind them 403s for a signed-in user: " + string.Join(", ", phantom));
    }

    /// <summary>The two lists must not drift apart. <c>tools/bootstrap-admin.sh</c> seeds the same four
    /// for a fresh install; the startup ensure repairs them after a refresh. If one grows a feature and
    /// the other does not, the gap reappears exactly where nobody is looking.</summary>
    [Fact]
    public void The_startup_ensure_and_the_bootstrap_script_seed_the_same_features()
    {
        var script = File.ReadAllText(RepoFile("tools/bootstrap-admin.sh"));
        foreach (var (name, _) in AbisSchema.RequiredFeatures)
            Assert.True(script.Contains($"\"{name}\"", StringComparison.Ordinal),
                $"bootstrap-admin.sh does not seed '{name}', which AbisSchema.RequiredFeatures restores.");
    }

    [Fact]
    public void Restored_features_carry_a_note_saying_what_they_gate()
    {
        Assert.All(AbisSchema.RequiredFeatures, f =>
        {
            Assert.False(string.IsNullOrWhiteSpace(f.Name));
            Assert.False(string.IsNullOrWhiteSpace(f.Notes));
        });
    }

    private static string RepoFile(string relative)
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null && !File.Exists(Path.Combine(dir.FullName, relative)))
            dir = dir.Parent;
        Assert.NotNull(dir);
        return Path.Combine(dir!.FullName, relative);
    }
}
