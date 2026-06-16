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
    Task<OrderItem?> GetOrderItemAsync(long orderItemNum, CancellationToken ct);
    Task<OrderItem> CreateOrderItemAsync(OrderItemWrite body, CancellationToken ct);
    Task<OrderItem?> UpdateOrderItemAsync(long orderItemNum, OrderItemWrite body, CancellationToken ct);

    // ---- Customers (read + write) --------------------------------------
    Task<PagedResult<Customer>> GetCustomersAsync(int page, int pageSize, string? name, string? orderBy, CancellationToken ct);
    Task<Customer?> GetCustomerAsync(long customerId, CancellationToken ct);
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

    // ---- Lookups (reference data for data-entry screens) ---------------
    Task<IReadOnlyList<string>> GetAlloysAsync(CancellationToken ct);

    // ---- Audit / action log --------------------------------------------
    Task WriteAuditAsync(string source, bool success, string? notes, CancellationToken ct);
    Task<PagedResult<AuditEntry>> GetAuditLogAsync(int page, int pageSize, string? source, string? orderBy, CancellationToken ct);
}
