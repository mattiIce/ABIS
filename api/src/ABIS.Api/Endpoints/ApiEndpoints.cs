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
        })).WithTags("Meta").WithName("Root").WithSummary("Service info, version, and links.");

        // Liveness: the process is up. No dependencies touched (cheap; safe to poll).
        app.MapGet("/health", () => Results.Ok(new { status = "ok" }))
           .WithTags("Meta").WithName("Health").WithSummary("Liveness probe — the process is up.");

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
           .WithSummary("Readiness probe — verifies database connectivity (503 when unreachable).")
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
           .WithSummary("List production jobs (paged, filterable by status, sortable).")
           .Produces<PagedResult<AbJob>>().ProducesValidationProblem();

        api.MapGet("/jobs/{abJobNum:long}", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetJobAsync(abJobNum, ct) is { } job
                    ? Results.Ok(job)
                    : Results.NotFound())
           .WithName("GetJob").WithTags("Jobs")
           .WithSummary("Get one production job by id.")
           .Produces<AbJob>().Produces(StatusCodes.Status404NotFound);

        api.MapGet("/jobs/{abJobNum:long}/coils", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobCoilsAsync(abJobNum, ct)))
           .WithName("GetJobCoils").WithTags("Jobs")
           .WithSummary("List the coils a job has processed.")
           .Produces<IEnumerable<ProcessCoil>>();

        api.MapGet("/jobs/{abJobNum:long}/skids", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobSheetSkidsAsync(abJobNum, ct)))
           .WithName("GetJobSkids").WithTags("Jobs")
           .WithSummary("List the finished sheet skids produced by a job.")
           .Produces<IEnumerable<SheetSkid>>();

        api.MapGet("/jobs/{abJobNum:long}/scrap", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobScrapAsync(abJobNum, ct)))
           .WithName("GetJobScrap").WithTags("Jobs")
           .WithSummary("List the scrap skids generated by a job.")
           .Produces<IEnumerable<ScrapSkid>>();

        api.MapGet("/jobs/{abJobNum:long}/partial-skids", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobPartialSkidsAsync(abJobNum, ct)))
           .WithName("GetJobPartialSkids").WithTags("Jobs")
           .WithSummary("List a job's in-process partial skids.")
           .Produces<IEnumerable<PartialSkid>>();

        api.MapPost("/jobs", async (JobWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateJobAsync(body, ct);
                return Results.Created($"/api/jobs/{created.AbJobNum}", created);
            })
           .WithName("CreateJob").WithTags("Jobs")
           .WithSummary("Create a production job.")
           .Produces<AbJob>(StatusCodes.Status201Created);

        api.MapPatch("/jobs/{abJobNum:long}", async (long abJobNum, JobPatch body, IAbisRepository repo, CancellationToken ct) =>
                await repo.PatchJobAsync(abJobNum, body, ct) is { } job
                    ? Results.Ok(job)
                    : Results.NotFound())
           .WithName("PatchJob").WithTags("Jobs")
           .WithSummary("Update a job's status, notes, men, or finish time.")
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
           .WithSummary("List raw input coils (paged, filterable, sortable).")
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
           .WithSummary("Coil inventory weight rollup grouped by alloy or location.")
           .Produces<IEnumerable<CoilInventoryGroup>>().ProducesValidationProblem();

        api.MapGet("/coils/{coilAbcNum:long}", async (long coilAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCoilAsync(coilAbcNum, ct) is { } coil
                    ? Results.Ok(coil)
                    : Results.NotFound())
           .WithName("GetCoil").WithTags("Coils")
           .WithSummary("Get one coil by id.")
           .Produces<Coil>().Produces(StatusCodes.Status404NotFound);

        api.MapGet("/coils/{coilAbcNum:long}/processing", async (long coilAbcNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetCoilProcessingAsync(coilAbcNum, ct)))
           .WithName("GetCoilProcessing").WithTags("Coils")
           .WithSummary("List a coil's processing history (the jobs that consumed it).")
           .Produces<IEnumerable<CoilProcessing>>();

        api.MapPost("/coils", async (CoilWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCoilAsync(body, ct);
                return Results.Created($"/api/coils/{created.CoilAbcNum}", created);
            })
           .WithName("CreateCoil").WithTags("Coils")
           .WithSummary("Create a coil on receipt.")
           .Produces<Coil>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPatch("/coils/{coilAbcNum:long}", async (long coilAbcNum, CoilPatch body, IAbisRepository repo, CancellationToken ct) =>
                await repo.PatchCoilAsync(coilAbcNum, body, ct) is { } coil
                    ? Results.Ok(coil)
                    : Results.NotFound())
           .WithName("PatchCoil").WithTags("Coils")
           .WithSummary("Update a coil's status, location, or notes.")
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
           .WithSummary("List customer orders (paged, filterable, sortable).")
           .Produces<PagedResult<CustomerOrder>>().ProducesValidationProblem();

        api.MapGet("/orders/{orderAbcNum:long}", async (long orderAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderAsync(orderAbcNum, ct) is { } order
                    ? Results.Ok(order)
                    : Results.NotFound())
           .WithName("GetOrder").WithTags("Orders")
           .WithSummary("Get one order header by id.")
           .Produces<CustomerOrder>().Produces(StatusCodes.Status404NotFound);

        api.MapGet("/orders/{orderAbcNum:long}/items", async (long orderAbcNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetOrderItemsByOrderAsync(orderAbcNum, ct)))
           .WithName("GetOrderItemsForOrder").WithTags("Orders")
           .WithSummary("List the line items for an order.")
           .Produces<IEnumerable<OrderItem>>();

        // Order-entry screen read model: header + customer + line items.
        api.MapGet("/orders/{orderAbcNum:long}/full", async (long orderAbcNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderDetailAsync(orderAbcNum, ct) is { } detail
                    ? Results.Ok(detail)
                    : Results.NotFound())
           .WithName("GetOrderDetail").WithTags("Orders")
           .WithSummary("Get an order with its customer and line items (order-entry read model).")
           .Produces<OrderDetail>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/orders", async (CustomerOrderWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateOrderAsync(body, ct);
                return Results.Created($"/api/orders/{created.OrderAbcNum}", created);
            })
           .WithName("CreateOrder").WithTags("Orders")
           .WithSummary("Create an order header.")
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
           .WithSummary("Create an order header and its line items in one transaction.")
           .Produces<OrderDetail>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/orders/{orderAbcNum:long}", async (long orderAbcNum, CustomerOrderWrite body, IAbisRepository repo, CancellationToken ct) =>
                await repo.UpdateOrderAsync(orderAbcNum, body, ct) is { } order
                    ? Results.Ok(order)
                    : Results.NotFound())
           .WithName("UpdateOrder").WithTags("Orders")
           .WithSummary("Replace an order header.")
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
           .WithSummary("List order line items (paged, sortable).")
           .Produces<PagedResult<OrderItem>>().ProducesValidationProblem();

        // order_item has a composite key (order + line number), so the single-item
        // routes are nested under the owning order (see docs/DATA_MODEL.md, #10).
        api.MapGet("/orders/{orderAbcNum:long}/items/{orderItemNum:long}", async (long orderAbcNum, long orderItemNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetOrderItemAsync(orderAbcNum, orderItemNum, ct) is { } item
                    ? Results.Ok(item)
                    : Results.NotFound())
           .WithName("GetOrderItem").WithTags("OrderItems")
           .WithSummary("Get one order line item by its composite key (order + line number).")
           .Produces<OrderItem>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/orders/{orderAbcNum:long}/items", async (long orderAbcNum, OrderItemWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateOrderItemAsync(orderAbcNum, body, ct);
                return Results.Created($"/api/orders/{orderAbcNum}/items/{created.OrderItemNum}", created);
            })
           .WithName("CreateOrderItem").WithTags("OrderItems")
           .WithSummary("Add a line item to an order (line number assigned per order).")
           .Produces<OrderItem>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/orders/{orderAbcNum:long}/items/{orderItemNum:long}", async (long orderAbcNum, long orderItemNum, OrderItemWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateOrderItemAsync(orderAbcNum, orderItemNum, body, ct) is { } item
                    ? Results.Ok(item)
                    : Results.NotFound();
            })
           .WithName("UpdateOrderItem").WithTags("OrderItems")
           .WithSummary("Replace an order line item (by order + line number).")
           .Produces<OrderItem>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Parts (part-number master) --------------------------------
        api.MapGet("/parts", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, long? customerId = null, string? alloy = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("parts", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetPartsAsync(page, pageSize, customerId, alloy, orderBy, ct));
            })
           .WithName("ListParts").WithTags("Parts")
           .WithSummary("List part-number master records (paged, sortable; filter by customerId/alloy).")
           .Produces<PagedResult<Part>>().ProducesValidationProblem();

        api.MapGet("/parts/{partNumId:long}", async (long partNumId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetPartAsync(partNumId, ct) is { } part
                    ? Results.Ok(part)
                    : Results.NotFound())
           .WithName("GetPart").WithTags("Parts")
           .WithSummary("Get one part-number record by id.")
           .Produces<Part>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/parts", async (PartWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreatePartAsync(body, ct);
                return Results.Created($"/api/parts/{created.PartNumId}", created);
            })
           .WithName("CreatePart").WithTags("Parts")
           .WithSummary("Create a part-number record (server-assigned id; requires customerId).")
           .Produces<Part>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/parts/{partNumId:long}", async (long partNumId, PartWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdatePartAsync(partNumId, body, ct) is { } part
                    ? Results.Ok(part)
                    : Results.NotFound();
            })
           .WithName("UpdatePart").WithTags("Parts")
           .WithSummary("Replace a part-number record.")
           .Produces<Part>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Dies (die / tooling) --------------------------------------
        api.MapGet("/dies", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? status = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("dies", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetDiesAsync(page, pageSize, status, orderBy, ct));
            })
           .WithName("ListDies").WithTags("Dies")
           .WithSummary("List dies/tooling (paged, sortable; filter by status).")
           .Produces<PagedResult<Die>>().ProducesValidationProblem();

        api.MapGet("/dies/{dieId:long}", async (long dieId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetDieAsync(dieId, ct) is { } die
                    ? Results.Ok(die)
                    : Results.NotFound())
           .WithName("GetDie").WithTags("Dies")
           .WithSummary("Get one die by id.")
           .Produces<Die>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/dies", async (DieWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateDieAsync(body, ct);
                return Results.Created($"/api/dies/{created.DieId}", created);
            })
           .WithName("CreateDie").WithTags("Dies")
           .WithSummary("Create a die/tooling record (server-assigned id; requires dieName).")
           .Produces<Die>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/dies/{dieId:long}", async (long dieId, DieWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateDieAsync(dieId, body, ct) is { } die
                    ? Results.Ok(die)
                    : Results.NotFound();
            })
           .WithName("UpdateDie").WithTags("Dies")
           .WithSummary("Replace a die/tooling record.")
           .Produces<Die>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Shipments -------------------------------------------------
        api.MapGet("/shipments", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, long? customerId = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("shipments", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetShipmentsAsync(page, pageSize, customerId, orderBy, ct));
            })
           .WithName("ListShipments").WithTags("Shipments")
           .WithSummary("List shipments / packing lists (paged, sortable; filter by customerId).")
           .Produces<PagedResult<Shipment>>().ProducesValidationProblem();

        api.MapGet("/shipments/{packingList:long}", async (long packingList, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetShipmentAsync(packingList, ct) is { } shipment
                    ? Results.Ok(shipment)
                    : Results.NotFound())
           .WithName("GetShipment").WithTags("Shipments")
           .WithSummary("Get one shipment by packing-list number.")
           .Produces<Shipment>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/shipments", async (ShipmentWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateShipmentAsync(body, ct);
                return Results.Created($"/api/shipments/{created.PackingList}", created);
            })
           .WithName("CreateShipment").WithTags("Shipments")
           .WithSummary("Create a shipment header (packing-list and bill-of-lading numbers server-assigned).")
           .Produces<Shipment>(StatusCodes.Status201Created);

        api.MapPut("/shipments/{packingList:long}", async (long packingList, ShipmentWrite body, IAbisRepository repo, CancellationToken ct) =>
                await repo.UpdateShipmentAsync(packingList, body, ct) is { } shipment
                    ? Results.Ok(shipment)
                    : Results.NotFound())
           .WithName("UpdateShipment").WithTags("Shipments")
           .WithSummary("Replace a shipment header (packing-list and bill-of-lading numbers preserved).")
           .Produces<Shipment>().Produces(StatusCodes.Status404NotFound);

        api.MapPatch("/shipments/{packingList:long}", async (long packingList, ShipmentStatusPatch body, IAbisRepository repo, CancellationToken ct) =>
                await repo.PatchShipmentAsync(packingList, body, ct) is { } shipment
                    ? Results.Ok(shipment)
                    : Results.NotFound())
           .WithName("PatchShipment").WithTags("Shipments")
           .WithSummary("Update a shipment's dispatch status (status, vehicle status, sent/actual times, notes).")
           .Produces<Shipment>().Produces(StatusCodes.Status404NotFound);

        // ---- Receiving BOLs --------------------------------------------
        api.MapGet("/receiving-bols", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, long? customerId = null, int? status = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("receivingBols", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetReceivingBolsAsync(page, pageSize, customerId, status, orderBy, ct));
            })
           .WithName("ListReceivingBols").WithTags("Receiving")
           .WithSummary("List inbound receiving BOLs (paged, sortable; filter by customerId/status).")
           .Produces<PagedResult<ReceivingBol>>().ProducesValidationProblem();

        api.MapGet("/receiving-bols/{receivingBolId:long}", async (long receivingBolId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetReceivingBolAsync(receivingBolId, ct) is { } bol
                    ? Results.Ok(bol)
                    : Results.NotFound())
           .WithName("GetReceivingBol").WithTags("Receiving")
           .WithSummary("Get one receiving BOL by id.")
           .Produces<ReceivingBol>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/receiving-bols", async (ReceivingBolWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateReceivingBolAsync(body, ct);
                return Results.Created($"/api/receiving-bols/{created.ReceivingBolId}", created);
            })
           .WithName("CreateReceivingBol").WithTags("Receiving")
           .WithSummary("Create an inbound receiving BOL (requires bol and customerId).")
           .Produces<ReceivingBol>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/receiving-bols/{receivingBolId:long}", async (long receivingBolId, ReceivingBolWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateReceivingBolAsync(receivingBolId, body, ct) is { } bol
                    ? Results.Ok(bol)
                    : Results.NotFound();
            })
           .WithName("UpdateReceivingBol").WithTags("Receiving")
           .WithSummary("Replace a receiving BOL.")
           .Produces<ReceivingBol>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Scan log (shop-floor tracking) ----------------------------
        api.MapGet("/scan-logs", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, long? abJobNum = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("scanLogs", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetScanLogsAsync(page, pageSize, abJobNum, orderBy, ct));
            })
           .WithName("ListScanLogs").WithTags("ScanLog")
           .WithSummary("List shop-floor scan events, newest first (paged, sortable; filter by abJobNum).")
           .Produces<PagedResult<ScanLog>>().ProducesValidationProblem();

        api.MapGet("/scan-logs/{scanId:long}", async (long scanId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetScanLogAsync(scanId, ct) is { } scan
                    ? Results.Ok(scan)
                    : Results.NotFound())
           .WithName("GetScanLog").WithTags("ScanLog")
           .WithSummary("Get one scan event by id.")
           .Produces<ScanLog>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/scan-logs", async (ScanLogWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateScanLogAsync(body, ct);
                return Results.Created($"/api/scan-logs/{created.ScanId}", created);
            })
           .WithName("CreateScanLog").WithTags("ScanLog")
           .WithSummary("Record a shop-floor scan event (append-only; requires abJobNum, scanStation, note).")
           .Produces<ScanLog>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapGet("/jobs/{abJobNum:long}/scans", async (long abJobNum, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetJobScansAsync(abJobNum, ct)))
           .WithName("GetJobScans").WithTags("Jobs")
           .WithSummary("List shop-floor scan events for a job.")
           .Produces<IEnumerable<ScanLog>>();

        // ---- Maintenance log -------------------------------------------
        api.MapGet("/maint-logs", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? status = null, long? groupDepartmentId = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("maintLogs", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetMaintLogsAsync(page, pageSize, status, groupDepartmentId, orderBy, ct));
            })
           .WithName("ListMaintLogs").WithTags("Maintenance")
           .WithSummary("List maintenance log entries, newest first (paged, sortable; filter by status/groupDepartmentId).")
           .Produces<PagedResult<MaintLog>>().ProducesValidationProblem();

        api.MapGet("/maint-logs/{maintLogId:long}", async (long maintLogId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetMaintLogAsync(maintLogId, ct) is { } entry
                    ? Results.Ok(entry)
                    : Results.NotFound())
           .WithName("GetMaintLog").WithTags("Maintenance")
           .WithSummary("Get one maintenance log entry by id.")
           .Produces<MaintLog>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/maint-logs", async (MaintLogWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateMaintLogAsync(body, ct);
                return Results.Created($"/api/maint-logs/{created.MaintLogId}", created);
            })
           .WithName("CreateMaintLog").WithTags("Maintenance")
           .WithSummary("Create a maintenance log entry (requires probDateTime, probDetails, author).")
           .Produces<MaintLog>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/maint-logs/{maintLogId:long}", async (long maintLogId, MaintLogWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateMaintLogAsync(maintLogId, body, ct) is { } entry
                    ? Results.Ok(entry)
                    : Results.NotFound();
            })
           .WithName("UpdateMaintLog").WithTags("Maintenance")
           .WithSummary("Replace a maintenance log entry.")
           .Produces<MaintLog>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Carriers --------------------------------------------------
        api.MapGet("/carriers", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? status = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("carriers", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetCarriersAsync(page, pageSize, status, orderBy, ct));
            })
           .WithName("ListCarriers").WithTags("Carriers")
           .WithSummary("List carriers / trucking partners (paged, sortable; filter by status).")
           .Produces<PagedResult<Carrier>>().ProducesValidationProblem();

        api.MapGet("/carriers/{carrierId:long}", async (long carrierId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCarrierAsync(carrierId, ct) is { } carrier
                    ? Results.Ok(carrier)
                    : Results.NotFound())
           .WithName("GetCarrier").WithTags("Carriers")
           .WithSummary("Get one carrier by id.")
           .Produces<Carrier>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/carriers", async (CarrierWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCarrierAsync(body, ct);
                return Results.Created($"/api/carriers/{created.CarrierId}", created);
            })
           .WithName("CreateCarrier").WithTags("Carriers")
           .WithSummary("Create a carrier (server-assigned id; requires carrierFullName).")
           .Produces<Carrier>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/carriers/{carrierId:long}", async (long carrierId, CarrierWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateCarrierAsync(carrierId, body, ct) is { } carrier
                    ? Results.Ok(carrier)
                    : Results.NotFound();
            })
           .WithName("UpdateCarrier").WithTags("Carriers")
           .WithSummary("Replace a carrier.")
           .Produces<Carrier>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        // ---- Shifts ----------------------------------------------------
        api.MapGet("/shifts", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, long? lineNum = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("shifts", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetShiftsAsync(page, pageSize, lineNum, orderBy, ct));
            })
           .WithName("ListShifts").WithTags("Shifts")
           .WithSummary("List production shifts, newest first (paged, sortable; filter by lineNum).")
           .Produces<PagedResult<Shift>>().ProducesValidationProblem();

        api.MapGet("/shifts/{shiftNum:long}", async (long shiftNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetShiftAsync(shiftNum, ct) is { } shift
                    ? Results.Ok(shift)
                    : Results.NotFound())
           .WithName("GetShift").WithTags("Shifts")
           .WithSummary("Get one shift by id.")
           .Produces<Shift>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/shifts", async (ShiftWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateShiftAsync(body, ct);
                return Results.Created($"/api/shifts/{created.ShiftNum}", created);
            })
           .WithName("CreateShift").WithTags("Shifts")
           .WithSummary("Create a production shift.")
           .Produces<Shift>(StatusCodes.Status201Created);

        api.MapPut("/shifts/{shiftNum:long}", async (long shiftNum, ShiftWrite body, IAbisRepository repo, CancellationToken ct) =>
                await repo.UpdateShiftAsync(shiftNum, body, ct) is { } shift
                    ? Results.Ok(shift)
                    : Results.NotFound())
           .WithName("UpdateShift").WithTags("Shifts")
           .WithSummary("Replace a production shift.")
           .Produces<Shift>().Produces(StatusCodes.Status404NotFound);

        // ---- Downtime instances ----------------------------------------
        api.MapGet("/downtime", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, long? abJobNum = null, long? shiftNum = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("downtime", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetDowntimeInstancesAsync(page, pageSize, abJobNum, shiftNum, orderBy, ct));
            })
           .WithName("ListDowntime").WithTags("Downtime")
           .WithSummary("List downtime instances, newest first (paged, sortable; filter by abJobNum/shiftNum).")
           .Produces<PagedResult<DowntimeInstance>>().ProducesValidationProblem();

        api.MapGet("/downtime/{instanceNum:long}", async (long instanceNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetDowntimeInstanceAsync(instanceNum, ct) is { } dt
                    ? Results.Ok(dt)
                    : Results.NotFound())
           .WithName("GetDowntimeInstance").WithTags("Downtime")
           .WithSummary("Get one downtime instance by id.")
           .Produces<DowntimeInstance>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/downtime", async (DowntimeInstanceWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                var created = await repo.CreateDowntimeInstanceAsync(body, ct);
                return Results.Created($"/api/downtime/{created.InstanceNum}", created);
            })
           .WithName("CreateDowntimeInstance").WithTags("Downtime")
           .WithSummary("Log a downtime instance.")
           .Produces<DowntimeInstance>(StatusCodes.Status201Created);

        api.MapPut("/downtime/{instanceNum:long}", async (long instanceNum, DowntimeInstanceWrite body, IAbisRepository repo, CancellationToken ct) =>
                await repo.UpdateDowntimeInstanceAsync(instanceNum, body, ct) is { } dt
                    ? Results.Ok(dt)
                    : Results.NotFound())
           .WithName("UpdateDowntimeInstance").WithTags("Downtime")
           .WithSummary("Replace a downtime instance.")
           .Produces<DowntimeInstance>().Produces(StatusCodes.Status404NotFound);

        // ---- Sketches --------------------------------------------------
        api.MapGet("/sketches", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, int? status = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("sketches", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetSketchesAsync(page, pageSize, status, orderBy, ct));
            })
           .WithName("ListSketches").WithTags("Sketches")
           .WithSummary("List part sketches/drawings (paged, sortable; filter by status). Excludes the binary image.")
           .Produces<PagedResult<Sketch>>().ProducesValidationProblem();

        api.MapGet("/sketches/{sketchId:long}", async (long sketchId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetSketchAsync(sketchId, ct) is { } sketch
                    ? Results.Ok(sketch)
                    : Results.NotFound())
           .WithName("GetSketch").WithTags("Sketches")
           .WithSummary("Get one sketch header by id (no image).")
           .Produces<Sketch>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/sketches", async (SketchWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateSketchAsync(body, ct);
                return Results.Created($"/api/sketches/{created.SketchId}", created);
            })
           .WithName("CreateSketch").WithTags("Sketches")
           .WithSummary("Create a sketch header (server-assigned id; requires sketchName; image not written via API).")
           .Produces<Sketch>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/sketches/{sketchId:long}", async (long sketchId, SketchWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateSketchAsync(sketchId, body, ct) is { } sketch
                    ? Results.Ok(sketch)
                    : Results.NotFound();
            })
           .WithName("UpdateSketch").WithTags("Sketches")
           .WithSummary("Replace a sketch header (image left untouched).")
           .Produces<Sketch>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

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
           .WithSummary("List posted mechanical test results (paged, filterable, sortable).")
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
           .WithSummary("List in-progress (working-set) mechanical test results.")
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
           .WithSummary("List customers (paged, sortable).")
           .Produces<PagedResult<Customer>>().ProducesValidationProblem();

        api.MapGet("/customers/{customerId:long}", async (long customerId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCustomerAsync(customerId, ct) is { } customer
                    ? Results.Ok(customer)
                    : Results.NotFound())
           .WithName("GetCustomer").WithTags("Customers")
           .WithSummary("Get one customer by id.")
           .Produces<Customer>().Produces(StatusCodes.Status404NotFound);

        api.MapGet("/customers/{customerId:long}/contacts", async (long customerId, IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetCustomerContactsAsync(customerId, ct)))
           .WithName("GetCustomerContacts").WithTags("Customers")
           .WithSummary("List the contacts for a customer.")
           .Produces<IEnumerable<CustomerContact>>();

        api.MapGet("/customer-contacts/{contactId:long}", async (long contactId, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetCustomerContactAsync(contactId, ct) is { } contact
                    ? Results.Ok(contact)
                    : Results.NotFound())
           .WithName("GetCustomerContact").WithTags("Customers")
           .WithSummary("Get one customer contact by id.")
           .Produces<CustomerContact>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/customers/{customerId:long}/contacts", async (long customerId, CustomerContactWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCustomerContactAsync(customerId, body, ct);
                return Results.Created($"/api/customer-contacts/{created.ContactId}", created);
            })
           .WithName("CreateCustomerContact").WithTags("Customers")
           .WithSummary("Add a contact to a customer (server-assigned id; requires lastName).")
           .Produces<CustomerContact>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapPut("/customer-contacts/{contactId:long}", async (long contactId, CustomerContactWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                return await repo.UpdateCustomerContactAsync(contactId, body, ct) is { } contact
                    ? Results.Ok(contact)
                    : Results.NotFound();
            })
           .WithName("UpdateCustomerContact").WithTags("Customers")
           .WithSummary("Replace a customer contact (owning customer unchanged).")
           .Produces<CustomerContact>().Produces(StatusCodes.Status404NotFound).ProducesValidationProblem();

        api.MapPost("/customers", async (CustomerWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateCustomerAsync(body, ct);
                return Results.Created($"/api/customers/{created.CustomerId}", created);
            })
           .WithName("CreateCustomer").WithTags("Customers")
           .WithSummary("Create a customer.")
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
           .WithSummary("Replace a customer.")
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
           .WithSummary("List finished sheet skids (paged, sortable).")
           .Produces<PagedResult<SheetSkid>>().ProducesValidationProblem();

        api.MapGet("/sheet-skids/{sheetSkidNum:long}", async (long sheetSkidNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetSheetSkidAsync(sheetSkidNum, ct) is { } skid
                    ? Results.Ok(skid)
                    : Results.NotFound())
           .WithName("GetSheetSkid").WithTags("Skids")
           .WithSummary("Get one sheet skid by id.")
           .Produces<SheetSkid>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/sheet-skids", async (SheetSkidWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateSheetSkidAsync(body, ct);
                return Results.Created($"/api/sheet-skids/{created.SheetSkidNum}", created);
            })
           .WithName("CreateSheetSkid").WithTags("Skids")
           .WithSummary("Create a finished sheet skid.")
           .Produces<SheetSkid>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapGet("/scrap-skids", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("scrapSkids", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetScrapSkidsAsync(page, pageSize, orderBy, ct));
            })
           .WithName("ListScrapSkids").WithTags("Skids")
           .WithSummary("List scrap skids (paged, sortable).")
           .Produces<PagedResult<ScrapSkid>>().ProducesValidationProblem();

        api.MapGet("/scrap-skids/{scrapSkidNum:long}", async (long scrapSkidNum, IAbisRepository repo, CancellationToken ct) =>
                await repo.GetScrapSkidAsync(scrapSkidNum, ct) is { } skid
                    ? Results.Ok(skid)
                    : Results.NotFound())
           .WithName("GetScrapSkid").WithTags("Skids")
           .WithSummary("Get one scrap skid by id.")
           .Produces<ScrapSkid>().Produces(StatusCodes.Status404NotFound);

        api.MapPost("/scrap-skids", async (ScrapSkidWrite body, IAbisRepository repo, CancellationToken ct) =>
            {
                if (Validate(body) is { } problems)
                    return Results.ValidationProblem(problems);
                var created = await repo.CreateScrapSkidAsync(body, ct);
                return Results.Created($"/api/scrap-skids/{created.ScrapSkidNum}", created);
            })
           .WithName("CreateScrapSkid").WithTags("Skids")
           .WithSummary("Create a scrap skid.")
           .Produces<ScrapSkid>(StatusCodes.Status201Created).ProducesValidationProblem();

        api.MapGet("/partial-skids", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("partialSkids", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetPartialSkidsAsync(page, pageSize, orderBy, ct));
            })
           .WithName("ListPartialSkids").WithTags("Skids")
           .WithSummary("List in-process partial skids (paged, sortable).")
           .Produces<PagedResult<PartialSkid>>().ProducesValidationProblem();

        // ---- Lookups (reference data for data-entry screens) -----------
        api.MapGet("/lookups/alloys", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetAlloysAsync(ct)))
           .WithName("ListAlloys").WithTags("Lookups")
           .WithSummary("List distinct alloys (reference data for dropdowns).")
           .Produces<IEnumerable<string>>();

        api.MapGet("/lookups/lines", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetLinesAsync(ct)))
           .WithName("ListLines").WithTags("Lookups")
           .WithSummary("List production lines (referenced by jobs, coils, downtime).")
           .Produces<IEnumerable<ProductionLine>>();

        api.MapGet("/lookups/groupdepartments", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetGroupDepartmentsAsync(ct)))
           .WithName("ListGroupDepartments").WithTags("Lookups")
           .WithSummary("List maintenance groups/departments (referenced by maintenance logs).")
           .Produces<IEnumerable<GroupDepartment>>();

        api.MapGet("/lookups/downtime-causes", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetDowntimeCausesAsync(ct)))
           .WithName("ListDowntimeCauses").WithTags("Lookups")
           .WithSummary("List downtime causes/reasons (master data for the downtime feature).")
           .Produces<IEnumerable<DowntimeCause>>();

        api.MapGet("/lookups/transportation-methods", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetTransportationMethodsAsync(ct)))
           .WithName("ListTransportationMethods").WithTags("Lookups")
           .WithSummary("List transportation method codes (referenced by shipments).")
           .Produces<IEnumerable<TransportationMethod>>();

        api.MapGet("/lookups/equipment-types", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetEquipmentTypesAsync(ct)))
           .WithName("ListEquipmentTypes").WithTags("Lookups")
           .WithSummary("List shipping equipment type codes (referenced by shipments).")
           .Produces<IEnumerable<EquipmentType>>();

        api.MapGet("/lookups/customer-types", async (IAbisRepository repo, CancellationToken ct) =>
                Results.Ok(await repo.GetCustomerTypesAsync(ct)))
           .WithName("ListCustomerTypes").WithTags("Lookups")
           .WithSummary("List customer classifications (referenced by customers).")
           .Produces<IEnumerable<CustomerType>>();

        // ---- Audit / action log ----------------------------------------
        api.MapGet("/audit-log", async (IAbisRepository repo, CancellationToken ct,
                int page = 1, int pageSize = 25, string? source = null, string? sort = null, string? dir = null) =>
            {
                if (!Sort.TryResolve("auditLog", sort, dir, out var orderBy, out var problems))
                    return Results.ValidationProblem(problems!);
                return Results.Ok(await repo.GetAuditLogAsync(page, pageSize, source, orderBy, ct));
            })
           .WithName("ListAuditLog").WithTags("Audit")
           .WithSummary("List the action/audit log, newest first.")
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

    private static Dictionary<string, string[]>? Validate(PartWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (body.CustomerId is null)
            errors["customerId"] = ["customerId is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(CarrierWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.CarrierFullName))
            errors["carrierFullName"] = ["carrierFullName is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(DieWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.DieName))
            errors["dieName"] = ["dieName is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(SketchWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.SketchName))
            errors["sketchName"] = ["sketchName is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(CustomerContactWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.LastName))
            errors["lastName"] = ["lastName is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(ReceivingBolWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (string.IsNullOrWhiteSpace(body.Bol))
            errors["bol"] = ["bol is required."];
        if (body.CustomerId is null)
            errors["customerId"] = ["customerId is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(ScanLogWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (body.AbJobNum is null)
            errors["abJobNum"] = ["abJobNum is required."];
        if (string.IsNullOrWhiteSpace(body.ScanStation))
            errors["scanStation"] = ["scanStation is required."];
        if (string.IsNullOrWhiteSpace(body.Note))
            errors["note"] = ["note is required."];
        return errors.Count == 0 ? null : errors;
    }

    private static Dictionary<string, string[]>? Validate(MaintLogWrite body)
    {
        var errors = new Dictionary<string, string[]>();
        if (body.ProbDateTime is null)
            errors["probDateTime"] = ["probDateTime is required."];
        if (string.IsNullOrWhiteSpace(body.ProbDetails))
            errors["probDetails"] = ["probDetails is required."];
        if (string.IsNullOrWhiteSpace(body.Author))
            errors["author"] = ["author is required."];
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
