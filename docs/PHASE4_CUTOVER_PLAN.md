# ABIS — Phase 4 Cutover Plan (module-by-module migration)

How we move from the legacy PowerBuilder `lion` client to the Path-C stack
**one module at a time**, with both running side-by-side against the same Oracle
database and **no big-bang switch**. This operationalizes Phase 4 of the
[`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md) and leads into Phase 5
(retire `lion.exe`).

> **Guiding rule — keep the plant running.** Every step is additive and
> reversible. The new screen and the legacy window read/write the *same* tables,
> so "rollback" is just sending an operator back to the legacy screen — no data
> migration, ever.

## Why coexistence is safe here

- **One database, two clients.** Both stacks issue SQL against the same Oracle
  schema. Nothing is forked or copied.
- **Writes are guarded.** The API validates input (400, not a DB 500), assigns ids
  from the real sequences, and uses **`If-Match` optimistic concurrency** — so if
  the legacy app changed a row since the operator loaded it, the API write is
  rejected (412) instead of silently clobbering. (See
  [`ORACLE_VALIDATION.md`](ORACLE_VALIDATION.md).)
- **History still records both.** Auditing/history is **trigger-based on the DB**
  (`*_HISTORY_LOG`, `*_TRACK`), so changes from either client are logged the same
  way regardless of which screen made them.
- **Hardware stays put.** Serial scales / OPC are owned by the
  [edge service](EDGE_SERVICE.md); the central API never touches a COM port.

## Cutover inventory (built greenfield, ready to pilot)

| Legacy module | New screen | Write surface | Risk to cut over |
|---|---|---|---|
| `qa` | `/ui/qa-results.html` | read-only | **lowest** |
| `inv_coil` | `/ui/coil-inventory.html` | status/location PATCH | low |
| `die_tool` | `/ui/dies.html` | create/replace | low |
| `maintenance` | `/ui/maintenance.html` | create/replace | low |
| `downtime` | `/ui/downtime.html` | create/replace | low |
| `order_entry` | `/ui/order-entry.html` | transactional create | medium |
| shipping | `/ui/shipping.html` | dispatch PATCH | medium |

Not in this wave (need more work first): anything touching the **scale-capture**
flow (gated on the edge service in production) and the giant `silverdome3` core.

## Sequencing — least-risk first

Order the rollovers so confidence compounds. Each tier ships only after the prior
one has soaked in production.

1. **Read-only first.** `qa-results`, then the read paths of `coil-inventory`.
   Zero write risk — operators just *view* in the new UI. Proves auth, performance,
   and screen ergonomics on real data with nothing to roll back.
2. **Low-volume master/log writes.** `dies`, `maintenance`, `downtime`. Bounded
   blast radius, few concurrent editors; exercises the create/replace + `If-Match`
   path in anger.
3. **Operational PATCH.** `coil-inventory` status/location moves, `shipping`
   dispatch. Higher use, but single-field updates with concurrency protection.
4. **Transactional core.** `order_entry` (header + lines in one transaction).
   Highest value/churn — cut over only after tiers 1–3 are proven.
5. **Hardware-bound flows.** Skid/coil **weight capture** — gated on the edge
   service being deployed and validated against the real indicators.

Dependency note: read screens can flip independently; write screens should flip
*after* their upstream reference data (customers, alloys, lines, departments) is
comfortably served by the API (it already is).

## Per-module cutover procedure

For each module, in order:

1. **Pilot (shadow).** Point a *small* group of operators at the new screen for
   that module while everyone else stays on legacy. Both write the same tables.
2. **Watch.** Monitor for a defined soak window (e.g. 1–2 weeks):
   - API logs / `X-Request-Id` correlation; any 4xx/5xx spikes.
   - `412` rate (concurrent-edit collisions — expected low; a spike means the
     legacy app is heavily co-editing the same rows → keep both a bit longer).
   - DB history/track rows look right vs. the legacy path.
   - Operator feedback vs. the legacy window (UX/perf parity).
3. **Flip.** Move all users of that module to the new screen; legacy window stays
   reachable as the fallback.
4. **Retire the legacy screen** only after the new one is proven (see exit
   criteria) — remove it from the legacy menu so it isn't used by habit.

## Rollback

- **Per module, instant:** send operators back to the legacy window. No data
  changes are needed — it's the same database.
- **Trigger to roll back:** a correctness bug, a `412`/error-rate spike, or a
  data-integrity discrepancy found in the history/track tables.
- Because rollback is free, **prefer shipping small and often** over big batches.

## Exit criteria (per module → Phase 5)

A module is "migrated" when:

- The new screen reaches **feature parity** for that module's real workflows.
- It has run in production through the soak window with **no fallback usage** and
  no open correctness/integrity issues.
- Any hardware steps it needs are served by the **edge service** in production.

When **every** module clears these and the edge service owns all hardware I/O,
Phase 5 begins: retire `lion.exe`/PB. Until the last module clears, the legacy app
stays installed as the safety net.

## Open items feeding this plan

- **Soft-delete policy** (NEXT_STEPS write-hardening) — decide before retiring any
  screen that deletes.
- **Auth** — swap the API key for OAuth/OIDC before a plant-wide rollout.
- **Edge service** — finish per-device parsing + the OPC source against real
  hardware before tier 5.
- **Path B** was dropped (greenfield committed) — no PowerServer step in this plan.
