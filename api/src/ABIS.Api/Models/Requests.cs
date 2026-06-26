namespace Abis.Api.Models;

// Write request bodies. Kept separate from the read models so the public write
// contract is explicit and never silently widened by adding read columns.

/// <summary>Create or fully replace a customer. <see cref="CustomerName"/> is required.</summary>
public sealed class CustomerWrite
{
    /// <summary>Maps to <c>customer_full_name</c> (required, NOT NULL).</summary>
    public string? CustomerName { get; set; }
    public string? CustomerShortName { get; set; }
    public string? CustomerCity { get; set; }
    public string? CustomerState { get; set; }
    public string? CustomerZip { get; set; }
}

/// <summary>Partial update of a production job. Null fields are left unchanged
/// (PATCH semantics via COALESCE) — a field cannot be cleared to null this way.</summary>
public sealed class JobPatch
{
    public int? JobStatus { get; set; }
    public string? JobNotes { get; set; }
    public int? NumberOfMenUsed { get; set; }
    public DateTime? TimeDateFinished { get; set; }
}

/// <summary>Partial update of a coil (inventory move / status change). Null fields
/// are left unchanged.</summary>
public sealed class CoilPatch
{
    public int? CoilStatus { get; set; }
    public string? CoilLocation { get; set; }
    public string? CoilNotes { get; set; }
}

/// <summary>Create or replace a customer order header (table <c>customer_order</c>).</summary>
public sealed class CustomerOrderWrite
{
    public long? OrigCustomerId { get; set; }
    public string? OrigCustomerPo { get; set; }
    public string? EnduserPo { get; set; }
    public string? ScrapHandingType { get; set; }
}

/// <summary>Create or replace an order line item (table <c>order_item</c>).
/// <see cref="EnduserPartNum"/> is required. <c>item_created_dttm</c> is set
/// server-side on create.</summary>
public sealed class OrderItemWrite
{
    /// <summary>Owning order (inferred FK). Optional for a standalone item; set by
    /// the server when creating an order with embedded items.</summary>
    public long? OrderAbcNum { get; set; }
    public string? EnduserPartNum { get; set; }
    public string? Alloy2 { get; set; }
    public string? Temper { get; set; }
    public decimal? Gauge { get; set; }
    public decimal? GaugeP { get; set; }
    public decimal? GaugeM { get; set; }
    public string? Surface { get; set; }
    public string? Flatness { get; set; }
    public string? SheetType { get; set; }
    public string? MaterialEndUse { get; set; }
    public string? OrderItemDesc { get; set; }
    public int? PiecesSkid { get; set; }
    public decimal? TheoreticalUnitWt { get; set; }
    public decimal? UnitPrice { get; set; }
}

/// <summary>Create an order header together with its line items in one
/// transaction (the order-entry "save" operation). The server assigns the order
/// id and stamps it onto each item.</summary>
public sealed class OrderCreateWithItems
{
    public required CustomerOrderWrite Order { get; set; }
    public List<OrderItemWrite> Items { get; set; } = [];
}

/// <summary>Create a production job (table <c>ab_job</c>). <c>create_date</c> is
/// set server-side.</summary>
public sealed class JobWrite
{
    public long? OrderAbcNum { get; set; }
    public long? OrderItemNum { get; set; }
    public long? LineNum { get; set; }
    public int? JobStatus { get; set; }
    public decimal? MaterialYield { get; set; }
    public int? NumberOfMenUsed { get; set; }
    public long? SketchId { get; set; }
    public DateTime? DueDate { get; set; }
    public string? JobNotes { get; set; }
    public string? SketchJobNote { get; set; }
}

/// <summary>Create a coil on receipt (table <c>coil</c>). <see cref="CoilAlloy2"/>
/// is required; <c>coil_entry_date</c>/<c>date_received</c> are set server-side.</summary>
public sealed class CoilWrite
{
    public string? CoilAlloy2 { get; set; }
    public string? CoilTemper { get; set; }
    public decimal? CoilGauge { get; set; }
    public decimal? CoilWidth { get; set; }
    public long? CoilLineNum { get; set; }
    public string? CoilLocation { get; set; }
    public string? CoilMidNum { get; set; }
    public string? CoilOrgNum { get; set; }
    public int? CoilStatus { get; set; }
    public string? CoilNotes { get; set; }
    public long? CustomerId { get; set; }
    public long? CoilFromCustId { get; set; }
    public string? Icra { get; set; }
    public string? LotNum { get; set; }
    public decimal? NetWt { get; set; }
    public decimal? NetWtBalance { get; set; }
    public int? PiecesPerCase { get; set; }
}

/// <summary>Create a finished sheet skid (table <c>sheet_skid</c>).
/// <see cref="AbJobNum"/> is required; <c>skid_date</c> is set server-side.</summary>
public sealed class SheetSkidWrite
{
    public long AbJobNum { get; set; }
    public string? SheetSkidDisplayNum { get; set; }
    public decimal? SheetNetWt { get; set; }
    public decimal? SheetTareWt { get; set; }
    public int? SkidPieces { get; set; }
}

/// <summary>Create a scrap skid (table <c>scrap_skid</c>).
/// <see cref="ScrapAbJobNum"/> is required; <c>scrap_date</c> is set server-side.</summary>
public sealed class ScrapSkidWrite
{
    public string? ScrapAbJobNum { get; set; }
    public string? ScrapAlloy2 { get; set; }
    public string? ScrapTemper { get; set; }
    public int? ScrapType { get; set; }
    public decimal? ScrapNetWt { get; set; }
    public decimal? ScrapTareWt { get; set; }
    public string? ScrapLocation { get; set; }
    public string? ScrapNotes { get; set; }
    public int? SkidScrapStatus { get; set; }
}
