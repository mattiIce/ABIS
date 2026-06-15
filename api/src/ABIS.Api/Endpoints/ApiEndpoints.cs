using Abis.Api.Data;
using Abis.Api.Models;

namespace Abis.Api.Endpoints;

/// <summary>Maps the read-only ABIS REST endpoints. Routes are grouped under
/// <c>/api</c>; collections are paginated (<c>page</c>, <c>pageSize</c>).</summary>
public static class ApiEndpoints
{
    public static IEndpointRouteBuilder MapAbisApi(this IEndpointRouteBuilder app)
    {
        app.MapGet("/", (IHostEnvironment env) => Results.Ok(new
        {
            name = "ABIS API",
            version = typeof(ApiEndpoints).Assembly.GetName().Version?.ToString() ?? "1.0.0",
            environment = env.EnvironmentName,
            docs = "/swagger",
            health = "/health"
        })).WithTags("Meta").WithName("Root");

        app.MapGet("/health", () => Results.Ok(new { status = "ok" }))
           .WithTags("Meta").WithName("Health");

        // All /api endpoints require an authenticated caller (see ApiKey auth).
        // /health and Swagger remain anonymous.
        var api = app.MapGroup("/api").RequireAuthorization();

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

        api.MapGet("/jobs/{abJobNum:long}/skids", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobSheetSkidsAsync(abJobNum, ct)))
           .WithName("GetJobSkids").WithTags("Jobs");

        api.MapGet("/jobs/{abJobNum:long}/scrap", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobScrapAsync(abJobNum, ct)))
           .WithName("GetJobScrap").WithTags("Jobs");

        api.MapPost("/jobs", async (JobWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateJobAsync(body, ct);
                return Results.Created($"/api/jobs/{created.AbJobNum}", created);
            })
           .WithName("CreateJob").WithTags("Jobs");

        api.MapPatch("/jobs/{abJobNum:long}", async (long abJobNum, JobPatch body, IAbisRepository repo, CancellationToken ct) =>
                await repo.PatchJobAsync(abJobNum, body, ct) is { } job
                    ? Results.Ok(job)
                    : Results.NotFound())
           .WithName("PatchJob").WithTags("Jobs");

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

        api.MapPost("/coils", async (CoilWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCoilAsync(body, ct);
                return Results.Created($"/api/coils/{created.CoilAbcNum}", created);
            })
           .WithName("CreateCoil").WithTags("Coils");

        api.MapPatch("/coils/{coilAbcNum:long}", async (long coilAbcNum, CoilPatch body, IAbisRepository repo, CancellationToken ct) =>
                await repo.PatchCoilAsync(coilAbcNum, body, ct) is { } coil
                    ? Results.Ok(coil)
                    : Results.NotFound())
           .WithName("PatchCoil").WithTags("Coils");

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

        api.MapPost("/orders", async (CustomerOrderWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateOrderAsync(body, ct);
                return Results.Created($"/api/orders/{created.OrderAbcNum}", created);
            })
           .WithName("CreateOrder").WithTags("Orders");

        api.MapPut("/orders/{orderAbcNum:long}", async (long orderAbcNum, CustomerOrderWrite body, IAbisRepository repo, CancellationToken ct) =>
                await repo.UpdateOrderAsync(orderAbcNum, body, ct) is { } order
                    ? Results.Ok(order)
                    : Results.NotFound())
           .WithName("UpdateOrder").WithTags("Orders");

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

        api.MapPost("/order-items", async (OrderItemWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateOrderItemAsync(body, ct);
                return Results.Created($"/api/order-items/{created.OrderItemNum}", created);
            })
           .WithName("CreateOrderItem").WithTags("OrderItems");

        api.MapPut("/order-items/{orderItemNum:long}", async (long orderItemNum, OrderItemWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateOrderItemAsync(orderItemNum, body, ct) is { } item
                    ? Results.Ok(item)
                    : Results.NotFound();
            })
           .WithName("UpdateOrderItem").WithTags("OrderItems");

        // ---- Test results ----------------------------------------------
        api.MapGet("/test-results", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? testType = null) =>
                Results.Ok(await repo.GetTestResultsAsync(page, pageSize, testType, ct)))
           .WithName("ListTestResults").WithTags("TestResults");

        // ---- Customers (read + write) ----------------------------------
        api.MapGet("/customers", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? name = null) =>
                Results.Ok(await repo.GetCustomersAsync(page, pageSize, name, ct)))
           .WithName("ListCustomers").WithTags("Customers");

        api.MapGet("/customers/{customerId:long}", async (long customerId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCustomerAsync(customerId, ct) is { } customer
                    ? Results.Ok(customer)
                    : Results.NotFound())
           .WithName("GetCustomer").WithTags("Customers");

        api.MapPost("/customers", async (CustomerWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCustomerAsync(body, ct);
                return Results.Created($"/api/customers/{created.CustomerId}", created);
            })
           .WithName("CreateCustomer").WithTags("Customers");

        api.MapPut("/customers/{customerId:long}", async (long customerId, CustomerWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateCustomerAsync(customerId, body, ct) is { } customer
                    ? Results.Ok(customer)
                    : Results.NotFound();
            })
           .WithName("UpdateCustomer").WithTags("Customers");

        // ---- Skids ------------------------------------------------------
        api.MapGet("/sheet-skids", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25) =>
                Results.Ok(await repo.GetSheetSkidsAsync(page, pageSize, ct)))
           .WithName("ListSheetSkids").WithTags("Skids");

        api.MapGet("/sheet-skids/{sheetSkidNum:long}", async (long sheetSkidNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetSheetSkidAsync(sheetSkidNum, ct) is { } skid
                    ? Results.Ok(skid)
                    : Results.NotFound())
           .WithName("GetSheetSkid").WithTags("Skids");

        api.MapPost("/sheet-skids", async (SheetSkidWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateSheetSkidAsync(body, ct);
                return Results.Created($"/api/sheet-skids/{created.SheetSkidNum}", created);
            })
           .WithName("CreateSheetSkid").WithTags("Skids");

        api.MapGet("/scrap-skids", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25) =>
                Results.Ok(await repo.GetScrapSkidsAsync(page, pageSize, ct)))
           .WithName("ListScrapSkids").WithTags("Skids");

        api.MapGet("/scrap-skids/{scrapSkidNum:long}", async (long scrapSkidNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetScrapSkidAsync(scrapSkidNum, ct) is { } skid
                    ? Results.Ok(skid)
                    : Results.NotFound())
           .WithName("GetScrapSkid").WithTags("Skids");

        api.MapPost("/scrap-skids", async (ScrapSkidWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateScrapSkidAsync(body, ct);
                return Results.Created($"/api/scrap-skids/{created.ScrapSkidNum}", created);
            })
           .WithName("CreateScrapSkid").WithTags("Skids");

        // ---- Audit / action log ----------------------------------------
        api.MapGet("/audit-log", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? source = null) =>
                Results.Ok(await repo.GetAuditLogAsync(page, pageSize, source, ct)))
           .WithName("ListAuditLog").WithTags("Audit");

        return app;
    }

    /// <summary>Returns a ProblemDetails error dictionary, or null when valid.</summary>
    private static Dictionary<string, string[]>? Validate(CustomerWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.CustomerName))
            errors["customerName"] = ["customerName is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(OrderItemWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.EnduserPartNum))
            errors["enduserPartNum"] = ["enduserPartNum is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(CoilWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.CoilAlloy2))
            errors["coilAlloy2"] = ["coilAlloy2 is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(SheetSkidWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (body.AbJobNum <= 0)
            errors["abJobNum"] = ["abJobNum is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(ScrapSkidWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.ScrapAbJobNum))
            errors["scrapAbJobNum"] = ["scrapAbJobNum is required."];
        return errors.Count == 0 ? null : errors;
    }
}
