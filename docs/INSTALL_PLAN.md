# ABIS — Server install package (plan)

A one-command install of the ABIS API + web UIs on a single **Ubuntu** server,
sitting next to the plant Oracle DB. "Single-click" in practice = an admin runs
one script, answers a couple of prompts (or supplies an answer file), and the
service comes up healthy behind a known HTTPS URL.

**Status: implemented (Phases 1–4 ✅).** This doc is the design record + status
tracker; the user-facing quick start is [`INSTALL.md`](INSTALL.md). It pairs with
the container-based [`DEPLOY.md`](DEPLOY.md), which stays as the documented Docker
alternative.

## Decision: native systemd service (Path A)

Install a self-contained `linux-x64` build under `systemd`, fronted by nginx for
TLS. Chosen over the Docker-wrapped path because:

- **No Docker dependency** to install/secure/maintain on the plant server.
- **Sidesteps `ORA-01882`.** The `tzdata`/`TZ` workaround in `DEPLOY.md` exists
  only because a bare container has no timezone DB. A real Ubuntu host already
  has `/usr/share/zoneinfo`, so the problem disappears.
- `Oracle.ManagedDataAccess.Core` is fully managed → the self-contained publish
  has **no native dependencies** to install.
- `systemd` gives start-on-boot, auto-restart, `journalctl` logs, and
  `systemctl status abis` for free.

## Topology

```
client ──HTTPS──> nginx (:443, TLS terminate) ──HTTP──> Kestrel (127.0.0.1:8080)
                                                         └─ abis.service (systemd)
                                                              └─ Oracle (plant DB)
```

Kestrel binds **loopback only**; nginx is the sole public listener.

## What the installer does

`sudo ./install.sh` — idempotent, safe to re-run for upgrades.

1. **Preflight** — Ubuntu version, root/sudo, target port free, optional TCP
   reachability test to the Oracle listener.
2. **Config** — interactive prompts, or non-interactive from an answer file /
   env vars (see Unattended mode):
   - `Database__ConnectionString` (Oracle)
   - API key — offer to **auto-generate** a strong one; print once
   - HTTP port (default `8080`, loopback)
   - Public server name (for the nginx `server_name` + cert)
   - Admin email for Let's Encrypt registration/expiry notices
3. **Files** — copy the self-contained publish to `/opt/abis/app`; write config
   to a systemd **`EnvironmentFile`** at `/etc/abis/abis.env` (`0640`,
   `root:abis`) with the answers as `Database__*` / `ApiKeys__*` / `ASPNETCORE_*`
   env vars. `Database__Seed=false` always. (Config lives outside the swappable
   `app/` dir so upgrades replace binaries without touching settings/secrets.)
4. **Service identity** — non-login `abis` system user; `/opt/abis` owned by it.
5. **systemd unit** — `abis.service`, `Type=notify` (pairs with `UseSystemd()`),
   `Restart=on-failure`, `EnvironmentFile=/etc/abis/abis.env`, hardening
   (`NoNewPrivileges`, `ProtectSystem=strict`, `PrivateTmp`, …).
   `systemctl enable --now abis`.
6. **nginx + TLS** — write `/etc/nginx/sites-available/abis` (proxy to
   `127.0.0.1:<port>`, forwarded headers), symlink into `sites-enabled`,
   `nginx -t`, reload. Then obtain the cert via `certbot --nginx` (Let's Encrypt)
   for the server name, which rewrites the site to HTTPS and installs the
   auto-renew timer. The server has internet access, so the ACME HTTP-01
   challenge works directly (port 80 must reach the box); an admin-provided cert
   stays as a fallback for anyone deploying internal-only.
7. **Verify** — poll `https://<server>/health/ready` until 200 (Oracle
   reachable), then print the order-entry URL + API key. Fail loudly with a
   `journalctl -u abis` hint if it never goes healthy.

**Uninstall** (`uninstall.sh`): `systemctl disable --now abis`, remove unit +
`/opt/abis` + nginx site; optionally preserve config.
**Upgrade**: re-run `install.sh` → stop service, swap files, restart, re-verify.

## Unattended mode

`install.sh --unattended --answers /path/abis.answers` (or all values via
`ABIS_*` env vars). Required values absent in unattended mode → fail fast, no
prompts. The answer file is sourced shell (`KEY="value"`), template at
[`deploy/abis.answers.example`](../deploy/abis.answers.example):
`ABIS_DB_CONNECTION` (required), `ABIS_API_KEY` (auto-generated if omitted),
`ABIS_PORT`, `ABIS_DB_PROVIDER`, and the nginx/TLS inputs `ABIS_SERVER_NAME`
(blank = loopback only), `ABIS_TLS_MODE` (`letsencrypt`/`provided`/`none`),
`ABIS_LETSENCRYPT_EMAIL`, `ABIS_TLS_CERT`, `ABIS_TLS_KEY`.

## Repo changes (status)

| Change | Where | Status | Notes |
|---|---|---|---|
| `builder.Host.UseSystemd()` | [`Program.cs`](../api/src/ABIS.Api/Program.cs) | ✅ Phase 1 | via `Microsoft.Extensions.Hosting.Systemd`; no-op off-systemd, so Docker/console paths untouched |
| `app.UseForwardedHeaders(...)` | [`Program.cs`](../api/src/ABIS.Api/Program.cs) | ✅ Phase 1 | trust the nginx proxy so scheme/host are correct (redirects, OIDC) |
| Self-contained publish profile | [`…/PublishProfiles/linux-x64.pubxml`](../api/src/ABIS.Api/Properties/PublishProfiles/linux-x64.pubxml) | ✅ Phase 1 | `linux-x64`, `SelfContained=true` |
| `build-release.sh` | [`build-release.sh`](../build-release.sh) | ✅ Phase 1 | `dotnet publish` → `abis-<version>-linux-x64.tar.gz` (publish + deploy assets) |
| `deploy/install.sh`, `deploy/uninstall.sh` | [`deploy/`](../deploy/) | ✅ Phase 2 | interactive + unattended; idempotent upgrade; health-gated start |
| `deploy/abis.service` | [`deploy/abis.service`](../deploy/abis.service) | ✅ Phase 2 | `Type=notify` unit + sandbox hardening |
| nginx site templates | [`deploy/nginx/abis.conf`](../deploy/nginx/abis.conf), [`abis-tls.conf`](../deploy/nginx/abis-tls.conf), [`abis-pending.conf`](../deploy/nginx/abis-pending.conf) | ✅ Phase 3 | HTTP base (certbot upgrades) + provided-cert variant + TLS-pending 503 fallback; wired into `install.sh`/`uninstall.sh` with `certbot --nginx` |
| Docs | [`docs/INSTALL.md`](INSTALL.md) + README/DEPLOY links | ✅ Phase 4 | native quick start; `DEPLOY.md` kept as the Docker alternative |
| CI release job | [`.github/workflows/release.yml`](../.github/workflows/release.yml) | ✅ Phase 4 | tag `v*` → test → `build-release.sh` → tarball + SHA256SUMS on a GitHub Release |

## Distribution

`build-release.sh` produces `abis-x.y.z-linux-x64.tar.gz`. Primary route is a
**CI release job**: on a version tag, CI runs `build-release.sh` and attaches the
tarball to a **GitHub Release**; the admin downloads it, untars, and runs
`sudo ./install.sh`. (`build-release.sh` stays runnable from a local clone too —
needs the .NET SDK on the box — for offline/air-gapped builds.)

A `.deb` (for `apt install` + clean upgrade semantics) is a natural follow-on,
but more packaging machinery than v1 needs.

## Phasing

- **Phase 1 ✅** — `UseSystemd()` + forwarded headers + publish profile +
  `build-release.sh` ([#76](https://github.com/mattiIce/ABIS/pull/76)). Final
  manual smoke test against non-prod Oracle (`192.168.1.230:1521/abc11`) happens
  on the Ubuntu box.
- **Phase 2 ✅** — `install.sh`/`uninstall.sh` + `abis.service`: prompts,
  unattended mode, health-gated start, idempotent upgrade. Binds loopback only
  (nginx fronts it in Phase 3).
- **Phase 3 ✅** — nginx site templates + `certbot --nginx` (Let's Encrypt) wired
  into `install.sh` (driven by `ABIS_SERVER_NAME`/`ABIS_TLS_MODE`), with the
  `provided`-cert variant for internal CA / DNS-01 and a `none` mode. Settings
  persist to `/etc/abis/install.state` for upgrades; `uninstall.sh` removes the
  site (and the cert on `--purge`).
- **Phase 4 ✅** — [`docs/INSTALL.md`](INSTALL.md) (linked from README + DEPLOY);
  CI release job [`release.yml`](../.github/workflows/release.yml) (tag `v*` →
  test → `build-release.sh` → tarball + `SHA256SUMS` on a GitHub Release). A
  `.deb` remains an optional future follow-on.

## Parallel plan: edge service installer

The OPC/scale [edge service](../edge/AbisEdge) is a **separate deployable** with
a different shape, so it gets its own (lighter) installer rather than riding in
this one:

- **Where it runs** — on the shop floor, not the app server: a Windows box (or
  IoT gateway) with line-of-sight to the serial scales/gauges and the plant OPC
  servers. Per project notes those OPC servers are **Classic OPC DA/DCOM**, not
  UA — so the edge host needs a DA→UA bridge or a DA client path before this is
  real. That gating question is upstream of packaging.
- **Likely target is Windows, not Ubuntu** — serial `COM` ports + DCOM live on
  Windows. So the edge installer is probably the *native Windows Service +
  installer* idea (self-contained `win-x64` publish, Windows Service hosting,
  Inno Setup `.exe`) that we set aside for the app server.
- **Config** — serial port/baud + OPC endpoint/tags (see
  [`EDGE_SERVICE.md`](EDGE_SERVICE.md)); plus the app API base URL + API key so
  it can publish readings.
- **Sequencing** — do the app-server installer (this plan) first; revisit the
  edge installer once the Classic-OPC bridge path is decided.

## Decisions locked

- **TLS** — `certbot --nginx` (Let's Encrypt); the server has internet access so
  ACME HTTP-01 works directly. Admin-provided cert kept as a fallback for
  internal-only deployments.
- **Release** — built by a CI job on a version tag and attached to a GitHub
  Release; `build-release.sh` also runnable from a local clone.
