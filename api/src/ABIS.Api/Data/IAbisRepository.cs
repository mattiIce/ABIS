using Abis.Api.Models;

namespace Abis.Api.Data;

/// <summary>Access to the ABIS core entities: read across the board, plus a
/// small, proven write surface (customer master data; operational patches to
/// jobs and coils). Writes are validated against the SQLite fixture in CI.</summary>
public interface IAbisRepository
{
    // ---- Health ---------------------------------------------------------
    /// <summary>Readiness probe: opens a connection and runs a trivial query so
    /// callers can distinguish "process alive" from "database reachable".</summary>
    Task<bool> PingAsync(CancellationToken ct);

    // ---- Jobs -----------------------------------------------------------
    Task<PagedResult<AbJob>> GetJobsAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct);
    Task<AbJob?> GetJobAsync(long abJobNum, CancellationToken ct);
    Task<IReadOnlyList<ProcessCoil>> GetJobCoilsAsync(long abJobNum, CancellationToken ct);
    Task<IReadOnlyList<SheetSkid>> GetJobSheetSkidsAsync(long abJobNum, CancellationToken ct);
    Task<IReadOnlyList<ScrapSkid>> GetJobScrapAsync(long abJobNum, CancellationToken ct);
    Task<IReadOnlyList<PartialSkid>> GetJobPartialSkidsAsync(long abJobNum, CancellationToken ct);
    Task<AbJob> CreateJobAsync(JobWrite body, CancellationToken ct);
    Task<AbJob?> PatchJobAsync(long abJobNum, JobPatch patch, CancellationToken ct);

    // ---- Coils ----------------------------------------------------------
    Task<PagedResult<Coil>> GetCoilsAsync(int page, int pageSize, int? status, string? alloy, string? location, long? customerId, string? orderBy, CancellationToken ct);
    Task<Coil?> GetCoilAsync(long coilAbcNum, CancellationToken ct);
    Task<IReadOnlyList<CoilProcessing>> GetCoilProcessingAsync(long coilAbcNum, CancellationToken ct);
    Task<IReadOnlyList<CoilInventoryGroup>> GetCoilInventorySummaryAsync(string groupBy, CancellationToken ct);
    Task<Coil> CreateCoilAsync(CoilWrite body, CancellationToken ct);
    Task<Coil?> PatchCoilAsync(long coilAbcNum, CoilPatch patch, CancellationToken ct);

    // ---- Orders (read + write) -----------------------------------------
    Task<PagedResult<CustomerOrder>> GetOrdersAsync(int page, int pageSize, long? customerId, string? po, string? orderBy, CancellationToken ct);
    Task<CustomerOrder?> GetOrderAsync(long orderAbcNum, CancellationToken ct);
    Task<OrderDetail?> GetOrderDetailAsync(long orderAbcNum, CancellationToken ct);
    Task<CustomerOrder> CreateOrderAsync(CustomerOrderWrite body, CancellationToken ct);
    Task<OrderDetail> CreateOrderWithItemsAsync(OrderCreateWithItems body, CancellationToken ct);
    Task<CustomerOrder?> UpdateOrderAsync(long orderAbcNum, CustomerOrderWrite body, CancellationToken ct);

    Task<PagedResult<OrderItem>> GetOrderItemsAsync(int page, int pageSize, string? alloy, string? orderBy, CancellationToken ct);
    Task<IReadOnlyList<OrderItem>> GetOrderItemsByOrderAsync(long orderAbcNum, CancellationToken ct);
    // order_item has a COMPOSITE key (order_abc_num + order_item_num); order_item_num
    // is a line number within an order, not a global id (see docs/DATA_MODEL.md, #10).
    Task<OrderItem?> GetOrderItemAsync(long orderAbcNum, long orderItemNum, CancellationToken ct);
    Task<OrderItem> CreateOrderItemAsync(long orderAbcNum, OrderItemWrite body, CancellationToken ct);
    Task<OrderItem?> UpdateOrderItemAsync(long orderAbcNum, long orderItemNum, OrderItemWrite body, CancellationToken ct);

    // ---- Customers (read + write) --------------------------------------
    Task<PagedResult<Customer>> GetCustomersAsync(int page, int pageSize, string? name, string? orderBy, CancellationToken ct);
    Task<Customer?> GetCustomerAsync(long customerId, CancellationToken ct);
    Task<IReadOnlyList<CustomerContact>> GetCustomerContactsAsync(long customerId, CancellationToken ct);
    Task<CustomerContact?> GetCustomerContactAsync(long contactId, CancellationToken ct);
    Task<CustomerContact> CreateCustomerContactAsync(long customerId, CustomerContactWrite body, CancellationToken ct);
    Task<CustomerContact?> UpdateCustomerContactAsync(long contactId, CustomerContactWrite body, CancellationToken ct);
    Task<Customer> CreateCustomerAsync(CustomerWrite body, CancellationToken ct);
    Task<Customer?> UpdateCustomerAsync(long customerId, CustomerWrite body, CancellationToken ct);

    // ---- Skids ----------------------------------------------------------
    Task<PagedResult<SheetSkid>> GetSheetSkidsAsync(int page, int pageSize, string? orderBy, CancellationToken ct);
    Task<SheetSkid?> GetSheetSkidAsync(long sheetSkidNum, CancellationToken ct);
    Task<SheetSkid> CreateSheetSkidAsync(SheetSkidWrite body, CancellationToken ct);
    Task<PagedResult<ScrapSkid>> GetScrapSkidsAsync(int page, int pageSize, string? orderBy, CancellationToken ct);
    Task<ScrapSkid?> GetScrapSkidAsync(long scrapSkidNum, CancellationToken ct);
    Task<ScrapSkid> CreateScrapSkidAsync(ScrapSkidWrite body, CancellationToken ct);
    Task<PagedResult<PartialSkid>> GetPartialSkidsAsync(int page, int pageSize, string? orderBy, CancellationToken ct);

    // ---- QA -------------------------------------------------------------
    Task<PagedResult<TestResult>> GetTestResultsAsync(int page, int pageSize, int? testType, string? position, DateTime? from, DateTime? to, string? orderBy, CancellationToken ct);
    Task<PagedResult<TempTestResult>> GetTempTestResultsAsync(int page, int pageSize, int? testType, string? position, DateTime? from, DateTime? to, string? orderBy, CancellationToken ct);

    // ---- Parts & dies (read) -------------------------------------------
    Task<PagedResult<Part>> GetPartsAsync(int page, int pageSize, long? customerId, string? alloy, string? orderBy, CancellationToken ct);
    Task<Part?> GetPartAsync(long partNumId, CancellationToken ct);
    Task<Part> CreatePartAsync(PartWrite body, CancellationToken ct);
    Task<Part?> UpdatePartAsync(long partNumId, PartWrite body, CancellationToken ct);
    Task<PagedResult<Die>> GetDiesAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct);
    Task<Die?> GetDieAsync(long dieId, CancellationToken ct);
    Task<Die> CreateDieAsync(DieWrite body, CancellationToken ct);
    Task<Die?> UpdateDieAsync(long dieId, DieWrite body, CancellationToken ct);
    Task<Carrier> CreateCarrierAsync(CarrierWrite body, CancellationToken ct);
    Task<Carrier?> UpdateCarrierAsync(long carrierId, CarrierWrite body, CancellationToken ct);

    // ---- Shipping / receiving / tracking (read) ------------------------
    Task<PagedResult<Shipment>> GetShipmentsAsync(int page, int pageSize, long? customerId, string? orderBy, CancellationToken ct);
    Task<Shipment?> GetShipmentAsync(long packingList, CancellationToken ct);
    Task<PagedResult<ReceivingBol>> GetReceivingBolsAsync(int page, int pageSize, long? customerId, int? status, string? orderBy, CancellationToken ct);
    Task<ReceivingBol?> GetReceivingBolAsync(long receivingBolId, CancellationToken ct);
    Task<PagedResult<ScanLog>> GetScanLogsAsync(int page, int pageSize, long? abJobNum, string? orderBy, CancellationToken ct);
    Task<ScanLog?> GetScanLogAsync(long scanId, CancellationToken ct);
    Task<IReadOnlyList<ScanLog>> GetJobScansAsync(long abJobNum, CancellationToken ct);
    Task<PagedResult<MaintLog>> GetMaintLogsAsync(int page, int pageSize, string? status, long? groupDepartmentId, string? orderBy, CancellationToken ct);
    Task<MaintLog?> GetMaintLogAsync(long maintLogId, CancellationToken ct);

    // ---- Operations: carriers / shifts / downtime (read) ---------------
    Task<PagedResult<Carrier>> GetCarriersAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct);
    Task<Carrier?> GetCarrierAsync(long carrierId, CancellationToken ct);
    Task<PagedResult<Shift>> GetShiftsAsync(int page, int pageSize, long? lineNum, string? orderBy, CancellationToken ct);
    Task<Shift?> GetShiftAsync(long shiftNum, CancellationToken ct);
    Task<PagedResult<DowntimeInstance>> GetDowntimeInstancesAsync(int page, int pageSize, long? abJobNum, long? shiftNum, string? orderBy, CancellationToken ct);
    Task<DowntimeInstance?> GetDowntimeInstanceAsync(long instanceNum, CancellationToken ct);
    Task<PagedResult<Sketch>> GetSketchesAsync(int page, int pageSize, int? status, string? orderBy, CancellationToken ct);
    Task<Sketch?> GetSketchAsync(long sketchId, CancellationToken ct);
    Task<Sketch> CreateSketchAsync(SketchWrite body, CancellationToken ct);
    Task<Sketch?> UpdateSketchAsync(long sketchId, SketchWrite body, CancellationToken ct);

    // ---- Lookups (reference data for data-entry screens) ---------------
    Task<IReadOnlyList<string>> GetAlloysAsync(CancellationToken ct);

    // ---- Audit / action log --------------------------------------------
    Task WriteAuditAsync(string source, bool success, string? notes, CancellationToken ct);
    Task<PagedResult<AuditEntry>> GetAuditLogAsync(int page, int pageSize, string? source, string? orderBy, CancellationToken ct);
}
