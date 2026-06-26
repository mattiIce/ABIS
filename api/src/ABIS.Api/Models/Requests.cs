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

/// <summary>Create or fully replace a part-number record. <see cref="CustomerId"/>
/// is required (the table's <c>customer_id</c> is NOT NULL).</summary>
public sealed class PartWrite
{
    public long? CustomerId { get; set; }
    public long? EnduserId { get; set; }
    public string? EnduserPartNum { get; set; }
    public string? SheetType { get; set; }
    public string? Alloy { get; set; }
    public string? Temper { get; set; }
    public decimal? Gauge { get; set; }
    /// <summary>Maps to <c>item_status</c> (NOT NULL); defaults to 0 on create.</summary>
    public int? ItemStatus { get; set; }
}

/// <summary>Create or fully replace a carrier. <see cref="CarrierFullName"/> is required.</summary>
public sealed class CarrierWrite
{
    public string? Scac { get; set; }
    public string? CarrierFullName { get; set; }
    public string? CarrierTypeCode { get; set; }
    public string? CarrierCity { get; set; }
    public string? CarrierState { get; set; }
    public string? CarrierPhoneNumber { get; set; }
    public int? Status { get; set; }
}

/// <summary>Create or fully replace a die. <see cref="DieName"/> is required.</summary>
public sealed class DieWrite
{
    public string? DieName { get; set; }
    public int? Status { get; set; }
    public string? ToolNum { get; set; }
    public string? PartName { get; set; }
    public decimal? GrossWeight { get; set; }
    public string? Location { get; set; }
    public string? Description { get; set; }
}

/// <summary>Create or fully replace a sketch header. <see cref="SketchName"/> is
/// required. The binary <c>sketch_view</c> image is not written via this API.</summary>
public sealed class SketchWrite
{
    public string? SketchName { get; set; }
    public string? SketchNotes { get; set; }
    public string? SketchSysNote { get; set; }
    public int? SketchStatus { get; set; }
}

/// <summary>Create or fully replace a customer contact. The owning customer comes
/// from the route on create; <see cref="LastName"/> is required.</summary>
public sealed class CustomerContactWrite
{
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public string? Department { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? Phone1 { get; set; }
    public string? Email1 { get; set; }
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
    /// <summary>Owning order — part of the order_item composite PK (confirmed real in
    /// the back-check). Optional for a standalone item; set by the server when creating
    /// an order with embedded items.</summary>
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

/// <summary>Warehouse-side partial update of a sheet skid (the legacy w_wh_* windows):
/// where it's stored, its warehouse ticket, and status. Only non-null fields apply.</summary>
public sealed class SheetSkidWarehousePatch
{
    public string? SkidLocation { get; set; }
    public string? SkidTicketIfWhed { get; set; }
    public int? SkidSheetStatus { get; set; }
}

/// <summary>Create or fully replace a shipment header (table <c>shipment</c>).
/// <c>packing_list</c> (PK) and the NOT NULL <c>bill_of_lading</c> are both
/// server-assigned from their own sequences on create.</summary>
public sealed class ShipmentWrite
{
    public long? CarrierId { get; set; }
    public long? CustomerId { get; set; }
    public long? DesShCustId { get; set; }
    public string? VehicleId { get; set; }
    public int? VehicleStatus { get; set; }
    public int? ShipmentStatus { get; set; }
    public DateTime? ShipmentScheduledDateTime { get; set; }
    public string? ShipmentNotes { get; set; }
}

/// <summary>Partial update of a shipment as it ships out (status/dispatch fields).
/// Null fields are left unchanged (COALESCE).</summary>
public sealed class ShipmentStatusPatch
{
    public int? ShipmentStatus { get; set; }
    public int? VehicleStatus { get; set; }
    public DateTime? DateSent { get; set; }
    public DateTime? ShipmentActualedDateTime { get; set; }
    public string? ShipmentNotes { get; set; }
}

/// <summary>Create or fully replace an inbound receiving BOL (table
/// <c>receiving_bol</c>). <see cref="Bol"/> and <see cref="CustomerId"/> are
/// required (both NOT NULL); <c>created_date</c> is set server-side on create.</summary>
public sealed class ReceivingBolWrite
{
    public string? Bol { get; set; }
    public long? CustomerId { get; set; }
    public string? CreatedBy { get; set; }
    public DateTime? ReceivedDate { get; set; }
    public int? Status { get; set; }
}

/// <summary>Record a shop-floor scan event (table <c>scan_log</c>, append-only).
/// <see cref="AbJobNum"/>, <see cref="ScanStation"/> and <see cref="Note"/> are
/// required (all NOT NULL); <c>scan_datetime</c> is stamped server-side.</summary>
public sealed class ScanLogWrite
{
    public long? AbJobNum { get; set; }
    public string? ScanStation { get; set; }
    public string? Note { get; set; }
}

/// <summary>Create or fully replace a maintenance log entry (table <c>maint_log</c>).
/// <see cref="ProbDateTime"/>, <see cref="ProbDetails"/> and <see cref="Author"/>
/// are required (NOT NULL); <c>entereddatetime</c> (NOT NULL) is set server-side on
/// create. The id is assigned by MAX+1 (this table has no Oracle sequence).</summary>
public sealed class MaintLogWrite
{
    public string? MaintLogStatus { get; set; }
    public long? GroupDepartmentId { get; set; }
    public string? SystemEquipment { get; set; }
    public string? SubsystemEquipment { get; set; }
    public string? ItemDevice { get; set; }
    public DateTime? ProbDateTime { get; set; }
    public string? ProbDetails { get; set; }
    public string? Actions { get; set; }
    public string? Author { get; set; }
    public string? ReportedBy { get; set; }
    public string? AssignedTo { get; set; }
    public DateTime? CompletedDateTime { get; set; }
    public string? CompletedBy { get; set; }
    public decimal? LaborHours { get; set; }
    public decimal? ProbCost { get; set; }
}

/// <summary>Create or fully replace a production shift (table <c>shift</c>).
/// Only <c>shift_num</c> (PK, server-assigned) is NOT NULL.</summary>
public sealed class ShiftWrite
{
    public DateTime? StartTime { get; set; }
    public DateTime? EndTime { get; set; }
    public long? LineNum { get; set; }
    public int? ScheduleType { get; set; }
    public decimal? DtTotal { get; set; }
    public string? OperatorInitial { get; set; }
    public int? ShiftDataStatus { get; set; }
    public string? Note { get; set; }
}

/// <summary>Create or fully replace a downtime instance (table <c>dt_instance</c>).
/// Only <c>instance_num</c> (PK, server-assigned) is NOT NULL.</summary>
public sealed class DowntimeInstanceWrite
{
    public long? AbJobNum { get; set; }
    public long? LineNum { get; set; }
    public DateTime? StartingTime { get; set; }
    public DateTime? EndingTime { get; set; }
    public string? Note { get; set; }
    public long? ShiftNum { get; set; }
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

/// <summary>Log a follow-up / reminder against a quote (table <c>sales_reminder</c>).
/// The quote id + revision come from the route; <c>event_id</c> is server-assigned.
/// <see cref="EventDate"/> defaults to now when omitted.</summary>
public sealed class SalesReminderWrite
{
    public DateTime? EventDate { get; set; }
    public string? EventNotes { get; set; }
    public string? EventStatus { get; set; }
    public string? UserId { get; set; }
}

/// <summary>Record a win-probability review on a quote (table <c>sales_probability</c>).
/// The quote id + revision come from the route; <c>probability_id</c> is server-assigned
/// and <c>review_date</c> defaults to now. <see cref="SalesProbabilityPercent"/> is 0–100.</summary>
public sealed class SalesProbabilityWrite
{
    public DateTime? ReviewDate { get; set; }
    public int? SalesProbabilityPercent { get; set; }
    public string? ProbabilityNote { get; set; }
}
