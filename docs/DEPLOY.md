# ABIS — Deploying the API + web UIs on a server

The Path-C stack is **one self-contained container**: the ASP.NET Core API plus
the greenfield web screens it serves (`/ui/order-entry.html`,
`/ui/coil-inventory.html`, …). This is the "build our own on a server" target —
run it on-prem next to the plant Oracle DB; the legacy PowerBuilder app keeps
running beside it (additive, no cutover).

> Hardware I/O (serial scales/gauges, OPC/PLC) is **not** in this container — it
> stays on the shop floor in a future edge service (see
> [`INTEGRATIONS.md`](INTEGRATIONS.md) and the roadmap). This unit is the
> data/business API + UI.

## Prerequisites

- A Linux host (or any Docker host) that can **reach the Oracle listener**.
- **Docker** + the Compose plugin.
- A DB account for the app (start with a **non-prod** copy of the schema).

## Quick start

```sh
cp .env.example .env          # fill in ABIS_DB_CONNECTION + ABIS_API_KEY
docker compose up -d --build  # build the image and start it
docker compose ps             # STATUS should become healthy (waits on /health/ready)
```

Then browse (replace `<host>` / port from `ABIS_PORT`):

| URL | What |
|---|---|
| `http://<host>:8080/ui/order-entry.html` | Order entry (greenfield) |
| `http://<host>:8080/ui/coil-inventory.html` | Coil inventory (greenfield) |
| `http://<host>:8080/swagger` | API explorer |
| `http://<host>:8080/health/ready` | Readiness (200 = Oracle reachable) |

Paste the `ABIS_API_KEY` value into each screen's **X-Api-Key** field.

## Configuration (env)

| Variable | Purpose |
|---|---|
| `ABIS_PORT` | Host port to publish (container always listens on 8080) |
| `ABIS_DB_CONNECTION` | Oracle connection string (`Database__ConnectionString`) |
| `ABIS_API_KEY` | A key clients send as `X-Api-Key` (`ApiKeys__Keys__0`) |
| `ABIS_TZ` | Container timezone (default `America/New_York`); a region Oracle recognizes |

All standard `Database__*` / `ApiKeys__*` settings can be overridden as env vars
(double-underscore form) in `docker-compose.yml` if needed.

## Security checklist (before production)

- **TLS** — terminate HTTPS at a reverse proxy (nginx/Caddy/Traefik) in front of
  the container; don't expose plain `:8080` off-host.
- **API keys** — long random values; rotate via `ApiKeys__Keys__1`, …; never
  commit `.env`. Keep these for machine clients (the edge service, scripts).
- **User auth (JWT/OIDC)** — for interactive users, enable JWT bearer by setting
  `Auth__Jwt__Authority` (your OIDC issuer) + `Auth__Jwt__Audience`; `/api` then
  accepts a valid token *or* an API key. See `api/README.md` §Authentication.
- **DB account** — least privilege (the API needs SELECT + INSERT/UPDATE on the
  modeled tables + sequence use; not DBA).
- **Non-prod first** — point at a staging copy, verify, then production with
  sign-off. Writes share the API's validation + `If-Match` optimistic concurrency.

## Updating

```sh
git pull
docker compose up -d --build   # rebuild + rolling restart
```

The committed web bundles under `wwwroot/ui/app/` are what's served; CI compiles
the TypeScript and runs the e2e on every change, so a green build is deployable.

## Notes

- `Database__Seed=false` in Compose — never seed against a real DB.
- Auditing self-disables (the live `DBO` schema has no `opc_action_log`); history
  is trigger-based on the DB side (see [`ORACLE_VALIDATION.md`](ORACLE_VALIDATION.md)).
- The image declares a Docker `HEALTHCHECK` against `/health/ready`, so
  orchestrators hold traffic until Oracle is actually reachable.
- **Timezone (`ORA-01882`).** The image ships `tzdata` and sets `TZ`
  (`America/New_York` by default) so the ODP.NET session adopts a timezone region
  Oracle 11g recognizes. A bare container has no timezone DB, which surfaces as
  `ORA-01882: timezone region not found` on connect — set `ABIS_TZ` to your
  plant's zone. *(Verified live: the container connected to the production-shaped
  Oracle and served the full UI once `TZ` was set.)*
