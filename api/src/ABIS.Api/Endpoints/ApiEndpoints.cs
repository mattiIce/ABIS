using Abis.Api.Data;
using Abis.Api.Models;
using Abis.Api.Security;
using Microsoft.AspNetCore.Mvc;

namespace Abis.Api.Endpoints;

/// <summary>Maps the ABIS REST endpoints. Routes are grouped under <c>/api</c>;
/// collections are paginated (<c>page</c>, <c>pageSize</c>) and sortable
/// (<c>sort</c>, <c>dir</c>). Every endpoint declares its response types via
/// <c>.Produces&lt;T&gt;()</c> so the generated OpenAPI contract is fully typed
/// and client codegen (NSwag / openapi-generator) produces real models.</summary>
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
            health = "/health",
            ready = "/health/ready",
            ui = "/ui/index.html"
        })).WithTags("Meta").WithName("Root");

        // Liveness: the process is up. No dependencies touched (cheap; safe to poll).
        app.MapGet("/health", () => Results.Ok(new { status = "ok" }))
           .WithTags("Meta").WithName("Health");

        // Readiness: the database is reachable. Returns 503 when it is not, so an
        // orchestrator can hold traffic until the data path is actually serving.
        app.MapGet("/health/ready", async (IAbisRepository repo, CancellationToken ct) =>
            {
                try
                {
                    return await repo.PingAsync(ct)
                        ? Results.Ok(new { status = "ready" })
                        : Results.Json(new { status = "unavailable" }, statusCode: StatusCodes.Status503ServiceUnavailable);
                }
                catch (Exception ex)
                {
                    return Results.Json(new { status = "unavailable", error = ex.Message },
                        statusCode: StatusCodes.Status503ServiceUnavailable);
                }
            })
           .WithTags("Meta").WithName("Ready")
           .Produces(StatusCodes.Status200OK)
           .Produces(StatusCodes.Status503ServiceUnavailable);

        // All /api endpoints require an authenticated caller (see ApiKey auth).
        // /health and Swagger remain anonymous. The 401 is declared once for the
        // whole group so it appears on every operation in the contract.
        var api = app.MapGroup("/api").RequireAuthorization().RequireRateLimiting(RateLimitOptions.PolicyName);
        api.WithMetadata(new ProducesResponseTypeAttribute(StatusCodes.Status401Unauthorized));

        // ---- Jobs -------------------------------------------------------
        api.MapGet("/jobs", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? status = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("jobs", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetJobsAsync(page, pageSize, status, orderBy, ct));
            })
           .WithName("ListJobs").WithTags("Jobs")
           .Produces<PagedResult<AbJob>>().ProducesValidationProblem();

        api.MapGet("/jobs/{abJobNum:long}", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetJobAsync(abJobNum, ct) is { } job
                    ? Results.Ok(job)
                    : Results.NotFound())
           .WithName("GetJob").WithTags("Jobs")
           .Produces<AbJob>().Produces(StatusCodes.Status404NotFound);

        api.MapGet("/jobs/{abJobNum:long}/coils", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobCoilsAsync(abJobNum, ct)))
           .WithName("GetJobCoils").WithTags("Jobs")
           .Produces<IEnumerable<ProcessCoil>>();

        api.MapGet("/jobs/{abJobNum:long}/skids", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobSheetSkidsAsync(abJobNum, ct)))
           .WithName("GetJobSkids").WithTags("Jobs")
           .Produces<IEnumerable<SheetSkid>>();

        api.MapGet("/jobs/{abJobNum:long}/scrap", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobScrapAsync(abJobNum, ct)))
           .WithName("GetJobScrap").WithTags("Jobs")
           .Produces<IEnumerable<ScrapSkid>>();

        api.MapGet("/jobs/{abJobNum:long}/partial-skids", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobPartialSkidsAsync(abJobNum, ct)))
           .WithName("GetJobPartialSkids").WithTags("Jobs")
           .Produces<IEnumerable<PartialSkid>>();

        api.MapPost("/jobs", async (JobWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateJobAsync(body, ct);
                return Results.Created($"/api/jobs/{created.AbJobNum}", created);
            })
           .WithName("CreateJob").WithTags("Jobs")
           .Produces<AbJob>(StatusCodes.Status201Created);

        api.MapPatch("/jobs/{abJobNum:long}", async (long abJobNum, JobPatch body, IAbisRepository repo, CancellationToken ct) =>
                await repo.PatchJobAsync(abJobNum, body, ct) is { } job
                    ? Results.Ok(job)
                    : Results.NotFound())
           .WithName("PatchJob").WithTags("Jobs")
           .Produces<AbJob>().Produces(StatusCodes.Status404NotFound);

        // ---- Coils (inventory) -----------------------------------------
        api.MapGet("/coils", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? status = null,
                string? alloy = null, string? location = null, long? customerId = null,
                string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("coils", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetCoilsAsync(page, pageSize, status, alloy, location, customerId, orderBy, ct));
            })
           .WithName("ListCoils").WithTags("Coils")
           .Produces<PagedResult<Coil>>().ProducesValidationProblem();

        // Inventory rollup: weight on hand grouped by alloy or location.
        api.MapGet("/coils/summary", async (IAbisRepository repo, CancellationToken ct, string groupBy = "alloy") =>
            {
                var g = groupBy.ToLowerInvariant();
                if (g is not ("alloy" or "location"))
                    return Results.ValidationProblem(new Dictionary<string, string[]>
                        { ["groupBy"] = ["groupBy must be 'alloy' or 'location'."] });
                return Results.Ok(await repo.GetCoilInventorySummaryAsync(g, ct));
            })
           .WithName("CoilInventorySummary").WithTags("Coils")
           .Produces<IEnumerable<CoilInventoryGroup>>().ProducesValidationProblem();

        api.MapGet("/coils/{coilAbcNum:long}", async (long coilAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCoilAsync(coilAbcNum, ct) is { } coil
                    ? Results.Ok(coil)
                    : Results.NotFound())
           .WithName("GetCoil").WithTags("Coils")
           .Produces<Coil>().Produces(StatusCodes.Status404NotFound);

        api.MapGet("/coils/{coilAbcNum:long}/processing", async (long coilAbcNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetCoilProcessingAsync(coilAbcNum, ct)))
           .WithName("GetCoilProcessing").WithTags("Coils")
           .Produces<IEnumerable<CoilProcessing>>();

        api.MapPost("/coils", async (CoilWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCoilAsync(body, ct);
                return Results.Created($"/api/coils/{created.CoilAbcNum}", created);
            })
           .WithName("CreateCoil").WithTags("Coils")
           .Produces<Coil>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPatch("/coils/{coilAbcNum:long}", async (long coilAbcNum, CoilPatch body, IAbisRepository repo, CancellationToken ct) =>
                await repo.PatchCoilAsync(coilAbcNum, body, ct) is { } coil
                    ? Results.Ok(coil)
                    : Results.NotFound())
           .WithName("PatchCoil").WithTags("Coils")
           .Produces<Coil>().Produces(StatusCodes.Status404NotFound);

        // ---- Orders -----------------------------------------------------
        api.MapGet("/orders", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, long? customerId = null, string? po = null,
                string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("orders", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetOrdersAsync(page, pageSize, customerId, po, orderBy, ct));
            })
           .WithName("ListOrders").WithTags("Orders")
           .Produces<PagedResult<CustomerOrder>>().ProducesValidationProblem();

        api.MapGet("/orders/{orderAbcNum:long}", async (long orderAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderAsync(orderAbcNum, ct) is { } order
                    ? Results.Ok(order)
                    : Results.NotFound())
           .WithName("GetOrder").WithTags("Orders")
           .Produces<CustomerOrder>().Produces(StatusCodes.Status404NotFound);

        api.MapGet("/orders/{orderAbcNum:long}/items", async (long orderAbcNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetOrderItemsByOrderAsync(orderAbcNum, ct)))
           .WithName("GetOrderItemsForOrder").WithTags("Orders")
           .Produces<IEnumerable<OrderItem>>();

        // Order-entry screen read model: header + customer + line items.
        api.MapGet("/orders/{orderAbcNum:long}/full", async (long orderAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderDetailAsync(orderAbcNum, ct) is { } detail
                    ? Results.Ok(detail)
                    : Results.NotFound())
           .WithName("GetOrderDetail").WithTags("Orders")
           .Produces<OrderDetail>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/orders", async (CustomerOrderWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateOrderAsync(body, ct);
                return Results.Created($"/api/orders/{created.OrderAbcNum}", created);
            })
           .WithName("CreateOrder").WithTags("Orders")
           .Produces<CustomerOrder>(StatusCodes.Status201Created);

        // Order-entry "save": create the header and its line items in one transaction.
        api.MapPost("/orders/with-items", async (OrderCreateWithItems body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateOrderWithItemsAsync(body, ct);
                return Results.Created($"/api/orders/{created.Order.OrderAbcNum}", created);
            })
           .WithName("CreateOrderWithItems").WithTags("Orders")
           .Produces<OrderDetail>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/orders/{orderAbcNum:long}", async (long orderAbcNum, CustomerOrderWrite body, IAbisRepository repo, CancellationToken ct) =>
                await repo.UpdateOrderAsync(orderAbcNum, body, ct) is { } order
                    ? Results.Ok(order)
                    : Results.NotFound())
           .WithName("UpdateOrder").WithTags("Orders")
           .Produces<CustomerOrder>().Produces(StatusCodes.Status404NotFound);

        // ---- Order items ------------------------------------------------
        api.MapGet("/order-items", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? alloy = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("orderItems", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetOrderItemsAsync(page, pageSize, alloy, orderBy, ct));
            })
           .WithName("ListOrderItems").WithTags("OrderItems")
           .Produces<PagedResult<OrderItem>>().ProducesValidationProblem();

        api.MapGet("/order-items/{orderItemNum:long}", async (long orderItemNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderItemAsync(orderItemNum, ct) is { } item
                    ? Results.Ok(item)
                    : Results.NotFound())
           .WithName("GetOrderItem").WithTags("OrderItems")
           .Produces<OrderItem>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/order-items", async (OrderItemWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateOrderItemAsync(body, ct);
                return Results.Created($"/api/order-items/{created.OrderItemNum}", created);
            })
           .WithName("CreateOrderItem").WithTags("OrderItems")
           .Produces<OrderItem>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/order-items/{orderItemNum:long}", async (long orderItemNum, OrderItemWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateOrderItemAsync(orderItemNum, body, ct) is { } item
                    ? Results.Ok(item)
                    : Results.NotFound();
            })
           .WithName("UpdateOrderItem").WithTags("OrderItems")
           .Produces<OrderItem>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Test results (QA) -----------------------------------------
        api.MapGet("/test-results", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? testType = null, string? position = null,
                DateTime? from = null, DateTime? to = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("testResults", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetTestResultsAsync(page, pageSize, testType, position, from, to, orderBy, ct));
            })
           .WithName("ListTestResults").WithTags("TestResults")
           .Produces<PagedResult<TestResult>>().ProducesValidationProblem();

        // In-progress / working-set test results (companion to the posted table).
        api.MapGet("/temp-test-results", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? testType = null, string? position = null,
                DateTime? from = null, DateTime? to = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("tempTestResults", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetTempTestResultsAsync(page, pageSize, testType, position, from, to, orderBy, ct));
            })
           .WithName("ListTempTestResults").WithTags("TestResults")
           .Produces<PagedResult<TempTestResult>>().ProducesValidationProblem();

        // ---- Customers (read + write) ----------------------------------
        api.MapGet("/customers", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? name = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("customers", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetCustomersAsync(page, pageSize, name, orderBy, ct));
            })
           .WithName("ListCustomers").WithTags("Customers")
           .Produces<PagedResult<Customer>>().ProducesValidationProblem();

        api.MapGet("/customers/{customerId:long}", async (long customerId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCustomerAsync(customerId, ct) is { } customer
                    ? Results.Ok(customer)
                    : Results.NotFound())
           .WithName("GetCustomer").WithTags("Customers")
           .Produces<Customer>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/customers", async (CustomerWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCustomerAsync(body, ct);
                return Results.Created($"/api/customers/{created.CustomerId}", created);
            })
           .WithName("CreateCustomer").WithTags("Customers")
           .Produces<Customer>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/customers/{customerId:long}", async (long customerId, CustomerWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateCustomerAsync(customerId, body, ct) is { } customer
                    ? Results.Ok(customer)
                    : Results.NotFound();
            })
           .WithName("UpdateCustomer").WithTags("Customers")
           .Produces<Customer>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Skids ------------------------------------------------------
        api.MapGet("/sheet-skids", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("sheetSkids", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetSheetSkidsAsync(page, pageSize, orderBy, ct));
            })
           .WithName("ListSheetSkids").WithTags("Skids")
           .Produces<PagedResult<SheetSkid>>().ProducesValidationProblem();

        api.MapGet("/sheet-skids/{sheetSkidNum:long}", async (long sheetSkidNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetSheetSkidAsync(sheetSkidNum, ct) is { } skid
                    ? Results.Ok(skid)
                    : Results.NotFound())
           .WithName("GetSheetSkid").WithTags("Skids")
           .Produces<SheetSkid>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/sheet-skids", async (SheetSkidWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateSheetSkidAsync(body, ct);
                return Results.Created($"/api/sheet-skids/{created.SheetSkidNum}", created);
            })
           .WithName("CreateSheetSkid").WithTags("Skids")
           .Produces<SheetSkid>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapGet("/scrap-skids", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("scrapSkids", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetScrapSkidsAsync(page, pageSize, orderBy, ct));
            })
           .WithName("ListScrapSkids").WithTags("Skids")
           .Produces<PagedResult<ScrapSkid>>().ProducesValidationProblem();

        api.MapGet("/scrap-skids/{scrapSkidNum:long}", async (long scrapSkidNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetScrapSkidAsync(scrapSkidNum, ct) is { } skid
                    ? Results.Ok(skid)
                    : Results.NotFound())
           .WithName("GetScrapSkid").WithTags("Skids")
           .Produces<ScrapSkid>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/scrap-skids", async (ScrapSkidWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateScrapSkidAsync(body, ct);
                return Results.Created($"/api/scrap-skids/{created.ScrapSkidNum}", created);
            })
           .WithName("CreateScrapSkid").WithTags("Skids")
           .Produces<ScrapSkid>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapGet("/partial-skids", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("partialSkids", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetPartialSkidsAsync(page, pageSize, orderBy, ct));
            })
           .WithName("ListPartialSkids").WithTags("Skids")
           .Produces<PagedResult<PartialSkid>>().ProducesValidationProblem();

        // ---- Lookups (reference data for data-entry screens) -----------
        api.MapGet("/lookups/alloys", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetAlloysAsync(ct)))
           .WithName("ListAlloys").WithTags("Lookups")
           .Produces<IEnumerable<string>>();

        // ---- Audit / action log ----------------------------------------
        api.MapGet("/audit-log", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? source = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("auditLog", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetAuditLogAsync(page, pageSize, source, orderBy, ct));
            })
           .WithName("ListAuditLog").WithTags("Audit")
           .Produces<PagedResult<AuditEntry>>().ProducesValidationProblem();

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

    private static Dictionary<string, string[]>? Validate(OrderCreateWithItems body)
    {
        var errors = new Dictionary<string, string[]>();
        for (var i = 0; i < body.Items.Count; i++)
            if (string.IsNullOrWhiteSpace(body.Items[i].EnduserPartNum))
                errors[$"items[{i}].enduserPartNum"] = ["enduserPartNum is required."];
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
