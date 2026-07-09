using System.Globalization;
using System.Runtime.Versioning;
using TitaniumAS.Opc.Client.Common;
using TitaniumAS.Opc.Client.Da;
using TitaniumAS.Opc.Client.Da.Browsing;

namespace AbisEdge.Tags;

/// <summary>Verbose one-shot diagnostic for the Classic OPC DA path (INGEAR), run via
/// <c>AbisEdge --probe ...</c> on the OPC box. Uses the same TitaniumAS client as
/// <see cref="ClassicDaTagSource"/> but prints per-item add/read detail and can browse the tag
/// namespace, so a live session can find real item ids and confirm quality. READ-ONLY. Windows-only.</summary>
[SupportedOSPlatform("windows")]
public static class ClassicDaProbe
{
    // Usage: (no args) read the defaults; "--browse [filter]" list item ids; "<item> ..." read those.
    public static void Run(string[] args)
    {
        var progId = Environment.GetEnvironmentVariable("Edge__Opc__ProgId") ?? "CimQuestInc.IGOPCAB.1";
        var browse = args.Length > 0 && string.Equals(args[0], "--browse", StringComparison.OrdinalIgnoreCase);
        var filter = browse && args.Length > 1 ? args[1] : "";
        var items = browse ? Array.Empty<string>() : args.Length > 0 ? args : ["Device110.spm", "Device110.idle"];

        using var server = new OpcDaServer(UrlBuilder.Build(progId, "localhost"));
        try
        {
            server.Connect();
            Console.WriteLine($"connected: {progId}  IsConnected={server.IsConnected}");

            if (browse) { BrowseFlat(server, filter); return; }

            var group = server.AddGroup("abis-probe");
            group.IsActive = true;

            var defs = items.Select(i => new OpcDaItemDefinition { ItemId = i, IsActive = true }).ToArray();
            var results = group.AddItems(defs);
            var added = new List<OpcDaItem>();
            for (var i = 0; i < results.Length; i++)
            {
                if (results[i].Error.Succeeded) added.Add(results[i].Item);
                else Console.WriteLine($"  {defs[i].ItemId,-30} ADD failed: {results[i].Error}");
            }

            if (added.Count > 0)
                foreach (var v in group.Read(added.ToArray(), OpcDaDataSource.Device))
                    Console.WriteLine($"  {v.Item.ItemId,-30} value={Fmt(v.Value),-14} quality={v.Quality.Master} ({v.Quality.Status})");
        }
        catch (Exception ex) { Console.WriteLine($"error: {ex.GetType().Name}: {ex.Message}"); }
    }

    private static string Fmt(object? v) => v is null ? "(null)" : Convert.ToString(v, CultureInfo.InvariantCulture) ?? "(null)";

    // Recursively browse branches, printing every leaf item id (optionally filtered).
    private static void BrowseFlat(OpcDaServer server, string filter)
    {
        var browser = new OpcDaBrowserAuto(server);
        var count = 0;

        void Walk(string itemId)
        {
            OpcDaBrowseElement[] elements;
            try { elements = browser.GetElements(itemId); }
            catch (Exception ex) { Console.WriteLine($"  browse '{itemId}' failed: {ex.Message}"); return; }
            foreach (var e in elements)
            {
                if (e.IsItem)
                {
                    if ((filter.Length == 0 || e.ItemId.Contains(filter, StringComparison.OrdinalIgnoreCase)) && count < 1000)
                    {
                        Console.WriteLine("  " + e.ItemId);
                        count++;
                    }
                }
                else Walk(e.ItemId);   // branch → descend
            }
        }

        Walk("");
        Console.WriteLine($"--- {count} leaf item ids{(filter.Length > 0 ? $" matching '{filter}'" : "")} ---");
    }
}
