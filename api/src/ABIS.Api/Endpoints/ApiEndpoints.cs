using Abis.Api.Data;
using Abis.Api.Models;

namespace Abis.Api.Endpoints;

/// <summary>Maps the read-only ABIS REST endpoints. Routes are grouped under
/// <c>/api</c>; collections are paginated (<c>page</c>, <c>pageSize</c>).</summary>
public static class ApiEndpoints
{
    public static IEndpointRouteBuilder MapAbisApi(this IEndpointRouteBuilder app)
    {
        app.MapGet("/health", () => Results.Ok(new { status = "ok" }))
           .WithTags("Meta").WithName("Health");

        var api = app.MapGroup("/api");

        // ---- Jobs -------------------------------------------------------
        api.MapGet("/jobs", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? status = null) =>
                Results.Ok(await repo.GetJobsAsync(page, pageSize, status, ct)))
           .WithName("ListJobs").WithTags("Jobs");

        api.MapGet("/jobs/{abJobNum:long}", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetJobAsync(abJobNum, ct) is { } job
                    ? Results.Ok(job)
                    : Results.NotFound())
           .WithName("GetJob").WithTags("Jobs");

        api.MapGet("/jobs/{abJobNum:long}/coils", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobCoilsAsync(abJobNum, ct)))
           .WithName("GetJobCoils").WithTags("Jobs");

        // ---- Coils ------------------------------------------------------
        api.MapGet("/coils", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? status = null) =>
                Results.Ok(await repo.GetCoilsAsync(page, pageSize, status, ct)))
           .WithName("ListCoils").WithTags("Coils");

        api.MapGet("/coils/{coilAbcNum:long}", async (long coilAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCoilAsync(coilAbcNum, ct) is { } coil
                    ? Results.Ok(coil)
                    : Results.NotFound())
           .WithName("GetCoil").WithTags("Coils");

        // ---- Orders -----------------------------------------------------
        api.MapGet("/orders", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25) =>
                Results.Ok(await repo.GetOrdersAsync(page, pageSize, ct)))
           .WithName("ListOrders").WithTags("Orders");

        api.MapGet("/orders/{orderAbcNum:long}", async (long orderAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderAsync(orderAbcNum, ct) is { } order
                    ? Results.Ok(order)
                    : Results.NotFound())
           .WithName("GetOrder").WithTags("Orders");

        // ---- Order items ------------------------------------------------
        api.MapGet("/order-items", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? alloy = null) =>
                Results.Ok(await repo.GetOrderItemsAsync(page, pageSize, alloy, ct)))
           .WithName("ListOrderItems").WithTags("OrderItems");

        api.MapGet("/order-items/{orderItemNum:long}", async (long orderItemNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderItemAsync(orderItemNum, ct) is { } item
                    ? Results.Ok(item)
                    : Results.NotFound())
           .WithName("GetOrderItem").WithTags("OrderItems");

        // ---- Test results ----------------------------------------------
        api.MapGet("/test-results", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? testType = null) =>
                Results.Ok(await repo.GetTestResultsAsync(page, pageSize, testType, ct)))
           .WithName("ListTestResults").WithTags("TestResults");

        return app;
    }
}
