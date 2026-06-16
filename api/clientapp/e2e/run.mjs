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
    items: [new OrderItemWrite({ enduserPartNum: 'PN-E2E', alloy2: '3003' })],
  });
  const detail = await client.createOrderWithItems(body);
  assert.ok(detail.order.orderAbcNum > 0);
  assert.equal(detail.items.length, 1);
  assert.equal(detail.items[0].enduserPartNum, 'PN-E2E');
});
