// End-to-end check: drive the *generated* client against a live API instance.
// Run by CI after the client is regenerated + compiled, so a contract change that
// breaks the real request/response path (not just compilation) fails the build.
//
// Usage: start the API (seeded SQLite), then:
//   ABIS_BASE=http://127.0.0.1:5225 ABIS_KEY=<key> node clientapp/e2e/run.mjs
import { test } from 'node:test';
import assert from 'node:assert/strict';
import {
  AbisClient,
  ApiException,
  OrderCreateWithItems,
  CustomerOrderWrite,
  OrderItemWrite,
  CoilPatch,
  ShipmentStatusPatch,
  MaintLogWrite,
  DieWrite,
  DowntimeInstanceWrite,
  ReceivingBolWrite,
  CustomerWrite,
  CustomerContactWrite,
  PartWrite,
  CarrierWrite,
  ScanLogWrite,
  SketchWrite,
  ShiftWrite,
  JobPatch,
  SheetSkidWrite,
  ScrapSkidWrite,
  SheetSkidWarehousePatch,
  SalesReminderWrite,
  SalesProbabilityWrite,
} from '../../src/ABIS.Api/wwwroot/ui/app/generated/abis-client.js';

const base = process.env.ABIS_BASE ?? 'http://127.0.0.1:5225';
const key = process.env.ABIS_KEY ?? 'dev-local-key';

// A client that injects the API key on every request (baseUrl points at the API).
const client = new AbisClient(base, {
  fetch: (url, init = {}) => {
    const headers = new Headers(init.headers);
    headers.set('X-Api-Key', key);
    return fetch(url, { ...init, headers });
  },
});

test('listCoils returns typed, server-sorted results', async () => {
  const page = await client.listCoils(1, 50, undefined, undefined, undefined, undefined, 'netWt', 'asc');
  assert.equal(page.totalCount, 4);
  assert.equal(page.items[0].coilAbcNum, 5003); // lowest net_wt first
});

test('getCoil returns a typed entity', async () => {
  const c = await client.getCoil(5004);
  assert.equal(c.coilAlloy2, '5052');
  assert.equal(c.coilStatus, 3);
});

test('getCoil(missing) throws a typed ApiException(404)', async () => {
  await assert.rejects(
    () => client.getCoil(999999),
    (e) => e instanceof ApiException && e.status === 404
  );
});

test('listJobs filters + sorts via the typed client', async () => {
  const page = await client.listJobs(1, 25, undefined, 'jobStatus', 'desc');
  const statuses = page.items.map((j) => j.jobStatus);
  assert.deepEqual(statuses, [...statuses].sort((a, b) => b - a));
});

test('createOrderWithItems writes via typed DTOs and returns a typed OrderDetail', async () => {
  const body = new OrderCreateWithItems({
    order: new CustomerOrderWrite({ origCustomerId: 4001, origCustomerPo: 'PO-E2E' }),
    items: [new OrderItemWrite({ enduserPartNum: 'PN-E2E', alloy2: '3003', sheetType: 'FLAT' })],
  });
  const detail = await client.createOrderWithItems(body);
  assert.ok(detail.order.orderAbcNum > 0);
  assert.equal(detail.items.length, 1);
  assert.equal(detail.items[0].enduserPartNum, 'PN-E2E');
});

// The downtime SPA's flow: create an instance, then load + replace it (typed).
test('downtime flow: create, get, update instance (typed)', async () => {
  const created = await client.createDowntimeInstance(new DowntimeInstanceWrite({
    abJobNum: 25000, lineNum: 1, startingTime: new Date(), note: 'E2E downtime',
  }));
  assert.ok(created.instanceNum > 0);
  const got = await client.getDowntimeInstance(created.instanceNum);
  assert.equal(got.instanceNum, created.instanceNum);
  const updated = await client.updateDowntimeInstance(created.instanceNum, new DowntimeInstanceWrite({
    abJobNum: 25000, lineNum: 1, startingTime: new Date(), note: 'E2E downtime edited',
  }));
  assert.equal(updated.note, 'E2E downtime edited');
});

// The dies SPA's flow: create a die, then load + replace it (typed).
test('dies flow: create, get, update die (typed)', async () => {
  const created = await client.createDie(new DieWrite({ dieName: 'E2E-DIE', status: 0, toolNum: 'T-E2E' }));
  assert.ok(created.dieId > 0);
  const got = await client.getDie(created.dieId);
  assert.equal(got.dieId, created.dieId);
  const updated = await client.updateDie(created.dieId, new DieWrite({ dieName: 'E2E-DIE', status: 1, location: 'BAY-9' }));
  assert.equal(updated.location, 'BAY-9');
});

// The receiving SPA's flow: create a BOL, then load + replace it (typed).
test('receiving flow: create, get, update receiving BOL (typed)', async () => {
  const created = await client.createReceivingBol(new ReceivingBolWrite({
    bol: 'E2E-BOL', customerId: 4001, createdBy: 'e2e', status: 0,
  }));
  assert.ok(created.receivingBolId > 0);
  const got = await client.getReceivingBol(created.receivingBolId);
  assert.equal(got.bol, 'E2E-BOL');
  const updated = await client.updateReceivingBol(created.receivingBolId, new ReceivingBolWrite({
    bol: 'E2E-BOL', customerId: 4001, createdBy: 'e2e', status: 1,
  }));
  assert.equal(updated.status, 1);
});

// The OPC log flow: sessions, their captured readings (host/device/item), and the item catalog (typed).
test('opc-log flow: sessions, readings, item catalog (typed)', async () => {
  const logs = await client.getOpcLogs();
  assert.ok(Array.isArray(logs) && logs.length > 0);
  const details = await client.getOpcLogDetails(1);
  assert.ok(details.length > 0);
  assert.ok(details.every((d) => typeof d.itemName === 'string' && typeof d.remoteHost === 'string'));
  const items = await client.getOpcItems();
  assert.ok(items.includes('Line110.Status'));
});

// The quality/recovery flow: defect catalog, product types, recovery customers, per-customer defects (typed).
test('quality flow: recovery catalog + customer defects (typed)', async () => {
  const scrap = await client.getScrapTypes();
  assert.ok(Array.isArray(scrap) && scrap.length > 0);
  const prods = await client.getProductTypes();
  assert.ok(Array.isArray(prods) && prods.length > 0);
  const custs = await client.getRecoveryCustomers();
  assert.ok(custs.some((c) => c.customerId === 4001));
  const defects = await client.getCustomerDefects(4001);
  assert.equal(defects.length, 2);
  assert.ok(defects.every((d) => typeof d.scrapCode === 'string'));
});

// The reporting flow: per-line production summary aggregation (typed, read-only).
test('reporting flow: production summary by line (typed)', async () => {
  const rows = await client.getProductionSummary(undefined, undefined);
  assert.ok(Array.isArray(rows) && rows.length > 0);
  // Every line row carries a numeric job count; at least one line has run jobs.
  assert.ok(rows.every((r) => typeof r.jobCount === 'number'));
  assert.ok(rows.some((r) => r.jobCount > 0));
});

// The accounting/invoicing flow: a job's rejected/rebanded coils that drive its invoice (typed).
test('accounting flow: invoice rej/reband coils for a job (typed)', async () => {
  const coils = await client.getInvoiceCoils(1002);
  assert.ok(Array.isArray(coils) && coils.length > 0);
  assert.ok(coils.every((c) => c.processCoilStatus === 3 || c.processCoilStatus === 7));
  assert.equal(coils[0].coilAbcNum, 5003);
});

// The warehouse SPA's flow: list sheet skids + a warehouse update (location/ticket/status) (typed).
test('warehouse flow: list sheet skids + warehouse update (typed)', async () => {
  const list = await client.listSheetSkids(1, 5, undefined, undefined);
  assert.ok(Array.isArray(list.items));
  const updated = await client.updateSheetSkidWarehouse(3001, new SheetSkidWarehousePatch({
    skidLocation: 'WH-E2E', skidTicketIfWhed: 'T-E2E', skidSheetStatus: 2,
  }));
  assert.equal(updated.skidLocation, 'WH-E2E');
  assert.equal(updated.skidSheetStatus, 2);
});

// The EDI monitor's flow: list transactions, log, customer-edi setup, and types (typed, read-only).
test('edi flow: list transactions, log, customer-edi, types (typed)', async () => {
  const tx = await client.listEdiTransactions(1, 5, undefined, undefined, undefined, undefined);
  assert.ok(Array.isArray(tx.items));
  const log = await client.listEdiLog(1, 5, undefined, undefined, undefined);
  assert.ok(Array.isArray(log.items));
  const types = await client.listEdiTypes();
  assert.ok(Array.isArray(types));
  const custEdi = await client.listCustomerEdi();
  assert.ok(Array.isArray(custEdi));
});

// The skids SPA's flow: list each skid type + create a sheet and a scrap skid (typed).
test('skids flow: list + create sheet & scrap skids (typed)', async () => {
  const sheet = await client.listSheetSkids(1, 5, undefined, undefined);
  assert.ok(Array.isArray(sheet.items));
  const createdSheet = await client.createSheetSkid(new SheetSkidWrite({
    abJobNum: 1001, sheetSkidDisplayNum: 'E2E-1', sheetNetWt: 100, skidPieces: 50,
  }));
  assert.ok(createdSheet.sheetSkidNum > 0);
  const createdScrap = await client.createScrapSkid(new ScrapSkidWrite({
    scrapAbJobNum: '1001', scrapAlloy2: '3003', scrapNetWt: 10, scrapType: 1,
  }));
  assert.ok(createdScrap.scrapSkidNum > 0);
  const partials = await client.listPartialSkids(1, 5, undefined, undefined);
  assert.ok(Array.isArray(partials.items));
});

// The production-jobs SPA's flow: list, open a job + its contents, patch it (typed).
test('jobs flow: list, get, children, patch (typed)', async () => {
  const page = await client.listJobs(1, 5, undefined, undefined, undefined);
  assert.ok(page.items.length > 0);
  const job = await client.getJob(1001);
  assert.equal(job.abJobNum, 1001);
  const coils = await client.getJobCoils(1001);
  assert.ok(Array.isArray(coils) && coils.length > 0);
  const skids = await client.getJobSkids(1001);
  assert.ok(Array.isArray(skids));
  const patched = await client.patchJob(1001, new JobPatch({ jobStatus: 2, numberOfMenUsed: 4 }));
  assert.equal(patched.jobStatus, 2);
});

// The shifts SPA's flow: create a shift, then load + replace it (typed).
test('shifts flow: create, get, update shift (typed)', async () => {
  const created = await client.createShift(new ShiftWrite({
    startTime: new Date(), lineNum: 110, operatorInitial: 'E2E', dtTotal: 0.5, shiftDataStatus: 1,
  }));
  assert.ok(created.shiftNum > 0);
  const got = await client.getShift(created.shiftNum);
  assert.equal(got.lineNum, 110);
  const updated = await client.updateShift(created.shiftNum, new ShiftWrite({
    startTime: new Date(), lineNum: 110, operatorInitial: 'E2E', dtTotal: 1.25, shiftDataStatus: 2,
  }));
  assert.equal(updated.shiftDataStatus, 2);
});

// The sketches SPA's flow: create a sketch, then load + replace it (typed).
test('sketches flow: create, get, update sketch (typed)', async () => {
  const created = await client.createSketch(new SketchWrite({
    sketchName: 'E2E-SKETCH', sketchStatus: 1, sketchNotes: 'e2e notes',
  }));
  assert.ok(created.sketchId > 0);
  const got = await client.getSketch(created.sketchId);
  assert.equal(got.sketchName, 'E2E-SKETCH');
  const updated = await client.updateSketch(created.sketchId, new SketchWrite({
    sketchName: 'E2E-SKETCH', sketchStatus: 0, sketchNotes: 'updated',
  }));
  assert.equal(updated.sketchStatus, 0);
});

// The scan SPA's flow: record a scan (append-only), then read it + list by job (typed).
test('scan flow: record a scan, get, list by job (typed)', async () => {
  const created = await client.createScanLog(new ScanLogWrite({
    abJobNum: 1001, scanStation: 'E2E-ST', note: 'e2e scan',
  }));
  assert.ok(created.scanId > 0);
  const got = await client.getScanLog(created.scanId);
  assert.equal(got.note, 'e2e scan');
  const page = await client.listScanLogs(1, 50, 1001, 'scanDatetime', 'desc');
  assert.ok(page.items.some((s) => s.scanId === created.scanId));
});

// The carriers SPA's flow: create a carrier, then load + replace it (typed).
test('carriers flow: create, get, update carrier (typed)', async () => {
  const created = await client.createCarrier(new CarrierWrite({
    carrierFullName: 'E2E Freight Lines', scac: 'E2EF', carrierTypeCode: 'LTL', status: 1,
  }));
  assert.ok(created.carrierId > 0);
  const got = await client.getCarrier(created.carrierId);
  assert.equal(got.carrierFullName, 'E2E Freight Lines');
  const updated = await client.updateCarrier(created.carrierId, new CarrierWrite({
    carrierFullName: 'E2E Freight Lines', scac: 'E2EF', carrierCity: 'Toledo', status: 0,
  }));
  assert.equal(updated.carrierCity, 'Toledo');
});

// The parts SPA's flow: create a part, then load + replace it (typed).
test('parts flow: create, get, update part (typed)', async () => {
  const created = await client.createPart(new PartWrite({
    customerId: 4001, enduserPartNum: 'E2E-PN', sheetType: 'SHEET', alloy: '3003', temper: 'H14', gauge: 0.05, itemStatus: 1,
  }));
  assert.ok(created.partNumId > 0);
  const got = await client.getPart(created.partNumId);
  assert.equal(got.enduserPartNum, 'E2E-PN');
  const updated = await client.updatePart(created.partNumId, new PartWrite({
    customerId: 4001, enduserPartNum: 'E2E-PN', alloy: '5052', itemStatus: 0,
  }));
  assert.equal(updated.alloy, '5052');
});

// The customers SPA's flow: create a customer, load + replace it, add a contact (typed).
test('customers flow: create, get, update customer + add contact (typed)', async () => {
  const created = await client.createCustomer(new CustomerWrite({
    customerName: 'E2E Customer', customerShortName: 'E2E', customerState: 'OH',
  }));
  assert.ok(created.customerId > 0);
  const got = await client.getCustomer(created.customerId);
  assert.equal(got.customerName, 'E2E Customer');
  const updated = await client.updateCustomer(created.customerId, new CustomerWrite({
    customerName: 'E2E Customer', customerShortName: 'E2E2', customerCity: 'Toledo',
  }));
  assert.equal(updated.customerShortName, 'E2E2');
  const contact = await client.createCustomerContact(created.customerId, new CustomerContactWrite({
    lastName: 'Smith', firstName: 'Pat', department: 'QA',
  }));
  assert.ok(contact.contactId > 0);
  const contacts = await client.getCustomerContacts(created.customerId);
  assert.ok(contacts.some((k) => k.contactId === contact.contactId));
});

// The maintenance SPA's flow: create a log, then load + replace it (typed).
test('maintenance flow: create, get, update maint log (typed)', async () => {
  const created = await client.createMaintLog(new MaintLogWrite({
    maintLogStatus: 'Completed', probDateTime: new Date(), probDetails: 'E2E fault', author: 'e2e',
  }));
  assert.ok(created.maintLogId > 0);
  const got = await client.getMaintLog(created.maintLogId);
  assert.equal(got.maintLogId, created.maintLogId);
  const updated = await client.updateMaintLog(created.maintLogId, new MaintLogWrite({
    maintLogStatus: 'Completed', probDateTime: new Date(), probDetails: 'E2E fault', author: 'e2e', assignedTo: 'tech-2',
  }));
  assert.equal(updated.assignedTo, 'tech-2');
});

// The shipping SPA's flow: list shipments, open one, record dispatch (patch).
test('shipping flow: listShipments, getShipment, patch dispatch (typed)', async () => {
  const page = await client.listShipments(1, 10, undefined, undefined, undefined);
  assert.ok(Array.isArray(page.items));
  if (page.items.length > 0) {
    const id = page.items[0].packingList;
    const s = await client.getShipment(id);
    assert.equal(s.packingList, id);
    const updated = await client.patchShipment(id, new ShipmentStatusPatch({ shipmentNotes: 'E2E dispatch' }));
    assert.equal(updated.shipmentNotes, 'E2E dispatch');
  }
});

// The QA-results SPA's flow: posted + in-progress mechanical test results.
test('qa-results flow: listTestResults + listTempTestResults (typed)', async () => {
  const posted = await client.listTestResults(1, 10, undefined, undefined, undefined, undefined, undefined, undefined);
  assert.ok(Array.isArray(posted.items));
  const temp = await client.listTempTestResults(1, 10, undefined, undefined, undefined, undefined, undefined, undefined);
  assert.ok(Array.isArray(temp.items));
});

// The coil-inventory SPA's flow: weight rollup, processing history, inline patch.
test('coil-inventory flow: summary, processing, and patch (typed)', async () => {
  const groups = await client.coilInventorySummary('alloy');
  assert.ok(Array.isArray(groups));
  const proc = await client.getCoilProcessing(5001);
  assert.ok(Array.isArray(proc));
  const updated = await client.patchCoil(5001, new CoilPatch({ coilLocation: 'E2E-BAY' }));
  assert.equal(updated.coilLocation, 'E2E-BAY');
});

// The order-entry SPA's read flow: search → open an order's full detail.
test('order-entry read flow: listOrders then getOrderDetail (typed)', async () => {
  const page = await client.listOrders(1, 25, undefined, undefined, undefined, undefined);
  assert.ok(page.totalCount >= 1);
  assert.ok(page.items.length >= 1);
  const id = page.items[0].orderAbcNum;
  const detail = await client.getOrderDetail(id);
  assert.equal(detail.order.orderAbcNum, id);
  assert.ok(Array.isArray(detail.items));
});

// The Sales SPA's read flow: pending-quote list carries the joined customer/contact and
// the latest win probability; opening a quote returns the typed header.
test('sales flow: listQuotes carries latest probability, getQuote header (typed)', async () => {
  const quotes = await client.getSalesQuotes(undefined);
  assert.ok(quotes.length >= 3);
  const q1 = quotes.find((q) => q.quoteId === 7001 && q.quoteRevisionId === 1);
  assert.ok(q1, 'seeded quote 7001-1 present');
  assert.equal(q1.customerShortName !== undefined, true);
  assert.equal(q1.latestProbability, 65); // newest of the two seeded reviews
  const header = await client.getSalesQuote(7001, 1);
  assert.equal(header.alloy, '3003');
  assert.equal(header.approvalSales, 'Y');
});

// Sales search filters by customer / end-use / alloy.
test('sales flow: getSalesQuotes(search) filters (typed)', async () => {
  const hit = await client.getSalesQuotes('5052');
  assert.ok(hit.length >= 1);
  assert.ok(hit.every((q) => q.quoteId === 7002));
  const miss = await client.getSalesQuotes('nope-no-match');
  assert.equal(miss.length, 0);
});

// Sales contacts: the address book, optionally scoped to a customer.
test('sales flow: getSalesContacts all + by customer (typed)', async () => {
  const all = await client.getSalesContacts(undefined);
  assert.ok(all.length >= 3);
  const scoped = await client.getSalesContacts(4002);
  assert.ok(scoped.length >= 1);
  assert.ok(scoped.every((c) => c.customerId === 4002));
});

// The Sales CRM write flow: log a follow-up event, then record a probability review —
// the recorded review becomes the quote's new latest probability.
test('sales flow: createSalesReminder + createSalesProbability (typed)', async () => {
  const events0 = await client.getSalesReminders(7002, 2);
  const ev = await client.createSalesReminder(7002, 2, new SalesReminderWrite({
    eventNotes: 'E2E follow-up', eventStatus: 'OPEN', userId: 'e2e',
  }));
  assert.ok(ev.eventId > 0);
  assert.equal(ev.eventStatus, 'OPEN');
  const events1 = await client.getSalesReminders(7002, 2);
  assert.equal(events1.length, events0.length + 1);

  const review = await client.createSalesProbability(7002, 2, new SalesProbabilityWrite({
    salesProbabilityPercent: 90, probabilityNote: 'E2E very likely',
  }));
  assert.equal(review.salesProbabilityPercent, 90);
  const quotes = await client.getSalesQuotes(undefined);
  const q = quotes.find((x) => x.quoteId === 7002 && x.quoteRevisionId === 2);
  assert.equal(q.latestProbability, 90); // the just-recorded review is now newest
});

// Probability validation: percent must be 0–100. The generated client surfaces a
// declared 400 validation body by throwing the typed HttpValidationProblemDetails.
test('sales flow: createSalesProbability rejects out-of-range percent (typed)', async () => {
  await assert.rejects(
    () => client.createSalesProbability(7001, 1, new SalesProbabilityWrite({ salesProbabilityPercent: 150 })),
    (err) => err?.status === 400 && !!err?.errors?.salesProbabilityPercent,
  );
});
