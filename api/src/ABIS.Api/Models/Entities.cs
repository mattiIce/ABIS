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
    /// <summary>Owning order. INFERRED FK (order entry requires an order↔item link;
    /// ab_job carries both order_abc_num and order_item_num). Confirm against the
    /// real schema in Phase 1.</summary>
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

/// <summary>An in-progress / working-set mechanical test result (table
/// <c>temp_test_result</c>) — the companion to the posted <c>pst_test_result</c>.
/// Note the legacy column names differ from the posted table: <c>yts</c>/<c>uts</c>/
/// <c>elongation</c>/<c>n</c>/<c>r</c> here vs the <c>*_val</c> columns there.</summary>
public sealed class TempTestResult
{
    public DateTime? CreatedDate { get; set; }
    public int? TestType { get; set; }
    public string? Position { get; set; }
    public decimal? Yts { get; set; }
    public decimal? Uts { get; set; }
    public decimal? Elongation { get; set; }
    public decimal? N { get; set; }
    public decimal? R { get; set; }
    public decimal? Thickness { get; set; }
    public decimal? Width { get; set; }
}

/// <summary>A partial (in-process) output skid on a job (table
/// <c>process_partial_skid</c>) — material accumulated before a full sheet skid is
/// closed out. <c>partial_skid_ab_job_num</c> is the legacy char form of the job.</summary>
public sealed class PartialSkid
{
    public long? AbJobNum { get; set; }
    public string? PartialSkidAbJobNum { get; set; }
    public long? SheetSkidNum { get; set; }
    public decimal? PartialSheetNetWt { get; set; }
    public int? PartialSkidPieces { get; set; }
    public string? PartialSkidLocation { get; set; }
    public DateTime? PartialSkidDate { get; set; }
}

/// <summary>A coil's processing history entry: a <c>process_coil</c> row joined
/// with a few attributes of the consuming job.</summary>
public sealed class CoilProcessing
{
    public long AbJobNum { get; set; }
    public long CoilAbcNum { get; set; }
    public int? ProcessCoilStatus { get; set; }
    public DateTime? ProcessDate { get; set; }
    public decimal? ProcessEndWt { get; set; }
    public decimal? ProcessQuantity { get; set; }
    public int? JobStatus { get; set; }
    public long? JobLineNum { get; set; }
}

/// <summary>One row of a coil inventory rollup (weight on hand grouped by a key).</summary>
public sealed class CoilInventoryGroup
{
    public string? Key { get; set; }
    public long Count { get; set; }
    public decimal? TotalNetWt { get; set; }
    public decimal? TotalBalance { get; set; }
}

/// <summary>A customer / trading partner (table <c>customer</c>). <c>CustomerName</c>
/// maps to the real column <c>customer_full_name</c>.</summary>
public sealed class Customer
{
    public long CustomerId { get; set; }
    public string? CustomerName { get; set; }
    public string? CustomerShortName { get; set; }
    public string? CustomerCity { get; set; }
    public string? CustomerState { get; set; }
    public string? CustomerZip { get; set; }
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
    // Warehouse view/management fields (the legacy w_wh_* windows).
    public string? SkidLocation { get; set; }
    public int? SkidSheetStatus { get; set; }
    public string? SkidTicketIfWhed { get; set; }
    public string? SkidFromIfWhed { get; set; }
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

/// <summary>Composite read model for an order-entry screen: the order header,
/// its (resolved) customer, and its line items.</summary>
public sealed class OrderDetail
{
    public required CustomerOrder Order { get; init; }
    public Customer? Customer { get; init; }
    public required IReadOnlyList<OrderItem> Items { get; init; }
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

/// <summary>A part-number master record (table <c>part_num</c>).</summary>
public sealed class Part
{
    public long PartNumId { get; set; }
    public long? CustomerId { get; set; }
    public long? EnduserId { get; set; }
    public string? EnduserPartNum { get; set; }
    public string? SheetType { get; set; }
    public string? Alloy { get; set; }
    public string? Temper { get; set; }
    public decimal? Gauge { get; set; }
    public int? ItemStatus { get; set; }
}

/// <summary>A die / tooling record (table <c>die</c>).</summary>
public sealed class Die
{
    public long DieId { get; set; }
    public string? DieName { get; set; }
    public int? Status { get; set; }
    public string? ToolNum { get; set; }
    public string? PartName { get; set; }
    public decimal? GrossWeight { get; set; }
    public string? Location { get; set; }
    public string? Description { get; set; }
}

/// <summary>A shipment / packing list (table <c>shipment</c>; PK <c>packing_list</c>).</summary>
public sealed class Shipment
{
    public long PackingList { get; set; }
    public long? BillOfLading { get; set; }
    public long? CarrierId { get; set; }
    public long? CustomerId { get; set; }
    public long? DesShCustId { get; set; }
    public string? VehicleId { get; set; }
    public int? VehicleStatus { get; set; }
    public int? ShipmentStatus { get; set; }
    public DateTime? ShipmentScheduledDateTime { get; set; }
    public DateTime? DateSent { get; set; }
    public DateTime? ShipmentActualedDateTime { get; set; }
    public string? ShipmentNotes { get; set; }
}

/// <summary>An inbound receiving BOL (table <c>receiving_bol</c>).</summary>
public sealed class ReceivingBol
{
    public long ReceivingBolId { get; set; }
    public string? Bol { get; set; }
    public long? CustomerId { get; set; }
    public string? CreatedBy { get; set; }
    public DateTime? CreatedDate { get; set; }
    public DateTime? ReceivedDate { get; set; }
    public int? Status { get; set; }
}

/// <summary>A shop-floor scan event (table <c>scan_log</c>).</summary>
public sealed class ScanLog
{
    public long ScanId { get; set; }
    public DateTime? ScanDatetime { get; set; }
    public long? AbJobNum { get; set; }
    public string? ScanStation { get; set; }
    public string? Note { get; set; }
}

/// <summary>A customer contact (table <c>customer_contact</c>).</summary>
public sealed class CustomerContact
{
    public long ContactId { get; set; }
    public long? CustomerId { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public string? Department { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? Phone1 { get; set; }
    public string? Email1 { get; set; }
}

/// <summary>A part sketch / drawing header (table <c>sketch</c>). The binary
/// <c>sketch_view</c> (LONG RAW) image is intentionally not exposed here.</summary>
public sealed class Sketch
{
    public long SketchId { get; set; }
    public string? SketchName { get; set; }
    public string? SketchNotes { get; set; }
    public string? SketchSysNote { get; set; }
    public int? SketchStatus { get; set; }
}

/// <summary>A carrier / trucking partner (table <c>carrier</c>).</summary>
public sealed class Carrier
{
    public long CarrierId { get; set; }
    public string? Scac { get; set; }
    public string? CarrierFullName { get; set; }
    public string? CarrierTypeCode { get; set; }
    public string? CarrierCity { get; set; }
    public string? CarrierState { get; set; }
    public string? CarrierPhoneNumber { get; set; }
    public int? Status { get; set; }
}

/// <summary>A production shift (table <c>shift</c>).</summary>
public sealed class Shift
{
    public long ShiftNum { get; set; }
    public DateTime? StartTime { get; set; }
    public DateTime? EndTime { get; set; }
    public long? LineNum { get; set; }
    public int? ScheduleType { get; set; }
    public decimal? DtTotal { get; set; }
    public string? OperatorInitial { get; set; }
    public int? ShiftDataStatus { get; set; }
    public string? Note { get; set; }
}

/// <summary>A downtime instance on a line/job (table <c>dt_instance</c>).</summary>
public sealed class DowntimeInstance
{
    public long InstanceNum { get; set; }
    public long? AbJobNum { get; set; }
    public long? LineNum { get; set; }
    public DateTime? StartingTime { get; set; }
    public DateTime? EndingTime { get; set; }
    public string? Note { get; set; }
    public long? ShiftNum { get; set; }
}

/// <summary>A maintenance log entry (table <c>maint_log</c>).</summary>
public sealed class MaintLog
{
    public long MaintLogId { get; set; }
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
    public DateTime? EnteredDateTime { get; set; }
    public string? AssignedTo { get; set; }
    public DateTime? CompletedDateTime { get; set; }
    public string? CompletedBy { get; set; }
    public decimal? LaborHours { get; set; }
    public decimal? ProbCost { get; set; }
}

// ---- Lookups (reference/master data for data-entry dropdowns & joins) ----

/// <summary>A production line (table <c>line</c>). Referenced by jobs, coils, and
/// downtime via <c>line_num</c>.</summary>
public sealed class ProductionLine
{
    public long LineNum { get; set; }
    public string? LineDesc { get; set; }
    public string? LineLocation { get; set; }
}

/// <summary>A maintenance group/department (table <c>groupdepartment</c>).
/// Referenced by maintenance log entries.</summary>
public sealed class GroupDepartment
{
    public long GroupDepartmentId { get; set; }
    public string? GroupDepartmentName { get; set; }
    public string? DeptType { get; set; }
}

/// <summary>A downtime cause/reason (table <c>dt_cause</c>) — master data for the
/// downtime feature.</summary>
public sealed class DowntimeCause
{
    public long Id { get; set; }
    public string? CauseName { get; set; }
    public string? Note { get; set; }
}

/// <summary>A transportation method code (table <c>transportation_method</c>).
/// Referenced by shipments.</summary>
public sealed class TransportationMethod
{
    public string? TransMethodCode { get; set; }
    public string? TransDesc { get; set; }
}

/// <summary>A shipping equipment type code (table <c>equipment_type</c>).
/// Referenced by shipments.</summary>
public sealed class EquipmentType
{
    public string? EquipmentTypeCode { get; set; }
    public string? EquipmentTypeDesc { get; set; }
    public string? EquipmentTypeNote { get; set; }
}

/// <summary>A customer classification (table <c>customer_type</c>). Referenced by
/// customers.</summary>
public sealed class CustomerType
{
    public string? CustomerTypeCode { get; set; }
    public string? CustomerTypeDescription { get; set; }
}

/// <summary>One outbound EDI transaction sent to a trading partner (table
/// <c>outbound_edi_transaction</c>) — the X12 send ledger. The binary
/// <c>edi_file_raw</c> (LONG RAW) payload is not exposed via this read model.</summary>
public sealed class EdiTransaction
{
    public long EdiFileId { get; set; }
    public string? DunsFrom { get; set; }
    public string? DunsTo { get; set; }
    public long? InterchangeControlNumber { get; set; }
    public long? GroupControlNumber { get; set; }
    public DateTime? TransactionTime { get; set; }
    public string? CustomerSentTo { get; set; }
    public string? EdiFileName { get; set; }
    /// <summary>Functional-acknowledgment status for this transaction (997 received?).</summary>
    public int? FaReceiveStatus { get; set; }
    public long? CustomerId { get; set; }
    public long? SetControlNum { get; set; }
    /// <summary>The X12 transaction set (e.g. "856", "870").</summary>
    public string? TransactionTypeId { get; set; }
    public string? FaReceivedTime { get; set; }
    public string? FaReceivedFileName { get; set; }
}

/// <summary>An EDI transmission log entry (table <c>edi_log</c>).</summary>
public sealed class EdiLogEntry
{
    public DateTime? EdiLogTimestamp { get; set; }
    public long CustomerId { get; set; }
    public string? CustomerEdiName { get; set; }
    public string? EdiLogContents { get; set; }
    public int? EdiLogFlag { get; set; }
    public long? EdiFileId { get; set; }
    public long? IsaSeq { get; set; }
    public long? GsSeq { get; set; }
    public string? EdiText { get; set; }
}

/// <summary>An EDI transaction-set type + X12 version (table <c>edi_type</c>).</summary>
public sealed class EdiType
{
    public int EdiTypeId { get; set; }
    public string? EdiVersion { get; set; }
    public string? EdiTypeDescription { get; set; }
}

/// <summary>A customer's EDI trading-partner configuration (table
/// <c>customer_edi</c>) — which transaction set/version maps to a partner route.</summary>
public sealed class CustomerEdi
{
    public string? CustomerEdiName { get; set; }
    public long CustomerId { get; set; }
    public int? EdiTypeId { get; set; }
    public string? EdiVersion { get; set; }
    public string? CustomerEdiDesc { get; set; }
}
