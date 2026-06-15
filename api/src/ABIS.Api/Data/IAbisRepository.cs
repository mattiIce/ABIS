using Abis.Api.Models;

namespace Abis.Api.Data;

/// <summary>Read-only access to the ABIS core entities. Phase 2 is intentionally
/// query-only — writes will follow once the API seam is proven.</summary>
public interface IAbisRepository
{
    Task<PagedResult<AbJob>> GetJobsAsync(int page, int pageSize, int? status, CancellationToken ct);
    Task<AbJob?> GetJobAsync(long abJobNum, CancellationToken ct);
    Task<IReadOnlyList<ProcessCoil>> GetJobCoilsAsync(long abJobNum, CancellationToken ct);

    Task<PagedResult<Coil>> GetCoilsAsync(int page, int pageSize, int? status, CancellationToken ct);
    Task<Coil?> GetCoilAsync(long coilAbcNum, CancellationToken ct);

    Task<PagedResult<CustomerOrder>> GetOrdersAsync(int page, int pageSize, CancellationToken ct);
    Task<CustomerOrder?> GetOrderAsync(long orderAbcNum, CancellationToken ct);

    Task<PagedResult<OrderItem>> GetOrderItemsAsync(int page, int pageSize, string? alloy, CancellationToken ct);
    Task<OrderItem?> GetOrderItemAsync(long orderItemNum, CancellationToken ct);

    Task<PagedResult<TestResult>> GetTestResultsAsync(int page, int pageSize, int? testType, CancellationToken ct);
}
