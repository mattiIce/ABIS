namespace Abis.Api.Models;

// Write request bodies. Kept separate from the read models so the public write
// contract is explicit and never silently widened by adding read columns.

/// <summary>Create or fully replace a customer. <see cref="CustomerName"/> is required.</summary>
public sealed class CustomerWrite
{
    public string? CustomerName { get; set; }
    public string? CustomerShortName { get; set; }
    public string? EnduserName { get; set; }
    public string? ShiptoCustomerZip { get; set; }
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
