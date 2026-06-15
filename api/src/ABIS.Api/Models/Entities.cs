namespace Abis.Api.Models;

// Read models for the ABIS core entities. Property names map (case-insensitively)
// to the column aliases produced by the repository SQL. Shapes follow
// docs/DATA_MODEL.md; nullability is permissive because the legacy schema is
// only partially recovered. IDs are modeled as long (the DB type is NUMBER /
// decimal(0)); measures/money as decimal; timestamps as DateTime.

/// <summary>A production job — the central shop-floor entity (table <c>ab_job</c>).</summary>
public sealed class AbJob
{
    public long AbJobNum { get; set; }
    public long? OrderAbcNum { get; set; }
    public long? OrderItemNum { get; set; }
    public long? LineNum { get; set; }
    public int? JobStatus { get; set; }
    public decimal? MaterialYield { get; set; }
    public int? NumberOfMenUsed { get; set; }
    public long? SketchId { get; set; }
    public DateTime? CreateDate { get; set; }
    public DateTime? DueDate { get; set; }
    public DateTime? TimeDateStarted { get; set; }
    public DateTime? TimeDateFinished { get; set; }
    public string? JobNotes { get; set; }
    public string? SketchJobNote { get; set; }
}

/// <summary>A raw input coil (table <c>coil</c>).</summary>
public sealed class Coil
{
    public long CoilAbcNum { get; set; }
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
    public DateTime? CoilEntryDate { get; set; }
    public long? CustomerId { get; set; }
    public long? CoilFromCustId { get; set; }
    public DateTime? DateReceived { get; set; }
    public string? Icra { get; set; }
    public string? LotNum { get; set; }
    public decimal? NetWt { get; set; }
    public decimal? NetWtBalance { get; set; }
    public int? PiecesPerCase { get; set; }
}

/// <summary>A coil consumed by a job (junction table <c>process_coil</c>), enriched with a few coil attributes.</summary>
public sealed class ProcessCoil
{
    public long AbJobNum { get; set; }
    public long CoilAbcNum { get; set; }
    public int? ProcessCoilStatus { get; set; }
    public DateTime? ProcessDate { get; set; }
    public decimal? ProcessEndWt { get; set; }
    public decimal? ProcessQuantity { get; set; }
    // Joined from coil for convenience:
    public string? CoilAlloy2 { get; set; }
    public decimal? CoilGauge { get; set; }
    public decimal? CoilWidth { get; set; }
}

/// <summary>A commercial order header (table <c>customer_order</c>).</summary>
public sealed class CustomerOrder
{
    public long OrderAbcNum { get; set; }
    public long? OrigCustomerId { get; set; }
    public string? OrigCustomerPo { get; set; }
    public string? EnduserPo { get; set; }
    public string? ScrapHandingType { get; set; }
}

/// <summary>An order line item (table <c>order_item</c>). PK <c>order_item_num</c> is inferred from <c>ab_job.order_item_num</c> — confirm against the real schema.</summary>
public sealed class OrderItem
{
    public long OrderItemNum { get; set; }
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
    public DateTime? ItemCreatedDttm { get; set; }
}

/// <summary>A mechanical/QA test result (table <c>pst_test_result</c>).</summary>
public sealed class TestResult
{
    public DateTime? CreatedDate { get; set; }
    public int? TestType { get; set; }
    public string? Position { get; set; }
    public decimal? YtsVal { get; set; }
    public decimal? UtsVal { get; set; }
    public decimal? ElongVal { get; set; }
    public decimal? NVal { get; set; }
    public decimal? RVal { get; set; }
    public decimal? Thickness { get; set; }
    public decimal? Width { get; set; }
}

/// <summary>A customer / trading partner (table <c>customer</c>).</summary>
public sealed class Customer
{
    public long CustomerId { get; set; }
    public string? CustomerName { get; set; }
    public string? CustomerShortName { get; set; }
    public string? EnduserName { get; set; }
    public string? ShiptoCustomerZip { get; set; }
}

/// <summary>A finished output skid produced by a job (table <c>sheet_skid</c>).</summary>
public sealed class SheetSkid
{
    public long SheetSkidNum { get; set; }
    public long? AbJobNum { get; set; }
    public string? SheetSkidDisplayNum { get; set; }
    public decimal? SheetNetWt { get; set; }
    public decimal? SheetTareWt { get; set; }
    public int? SkidPieces { get; set; }
    public DateTime? SkidDate { get; set; }
}

/// <summary>A scrap skid generated by a job (table <c>scrap_skid</c>).
/// Note: in the legacy schema <c>scrap_ab_job_num</c> is char(18), not the numeric
/// <c>ab_job.ab_job_num</c> — so it is modeled as a string.</summary>
public sealed class ScrapSkid
{
    public long ScrapSkidNum { get; set; }
    public string? ScrapAbJobNum { get; set; }
    public string? ScrapAlloy2 { get; set; }
    public string? ScrapTemper { get; set; }
    public int? ScrapType { get; set; }
    public decimal? ScrapNetWt { get; set; }
    public decimal? ScrapTareWt { get; set; }
    public string? ScrapLocation { get; set; }
    public string? ScrapNotes { get; set; }
    public int? SkidScrapStatus { get; set; }
    public DateTime? ScrapDate { get; set; }
}

/// <summary>An action-log / audit entry (table <c>opc_action_log</c>). The API
/// reuses this legacy table to record every mutating request.</summary>
public sealed class AuditEntry
{
    public long OpcLogId { get; set; }
    public DateTime? TimeStamp { get; set; }
    public string? Source { get; set; }
    public int? Success { get; set; }
    public string? Notes { get; set; }
}
