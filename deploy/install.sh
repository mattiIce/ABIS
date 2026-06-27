#!/usr/bin/env bash
#
# install.sh — install/upgrade ABIS as a native systemd service on Ubuntu.
#
# Run from the extracted release tarball (this script sits next to app/ and
# abis.service). Idempotent: re-run it to upgrade in place — it stops the
# service, swaps the binaries, and restarts, preserving existing config unless
# you pass new values.
#
#   sudo ./install.sh                      # interactive
#   sudo ./install.sh --unattended \       # no prompts (CI / config mgmt)
#        --answers /path/abis.answers
#   sudo ABIS_DB_CONNECTION='...' ABIS_API_KEY='...' ./install.sh --unattended
#
# Config inputs (env var / answers-file key — answers file is sourced, so quote
# values with spaces, e.g. ABIS_DB_CONNECTION="Data Source=..."):
#   ABIS_DB_CONNECTION   Oracle connection string                 (required)
#   ABIS_API_KEY         X-Api-Key value clients send   (generated if omitted)
#   ABIS_PORT            loopback port Kestrel binds              (default 8080)
#   ABIS_DB_PROVIDER     Oracle | Sqlite                        (default Oracle)
#
# What it does NOT do yet: expose the service off-host. Kestrel binds 127.0.0.1
# only; public HTTPS access is added in Phase 3 (nginx + Let's Encrypt). Until
# then, verify locally with curl on the box. See docs/INSTALL_PLAN.md.
#
set -euo pipefail

# --- constants ---------------------------------------------------------------
SERVICE_NAME="abis"
SERVICE_USER="abis"
INSTALL_ROOT="/opt/abis"
APP_DIR="${INSTALL_ROOT}/app"
CONFIG_DIR="/etc/abis"
ENV_FILE="${CONFIG_DIR}/abis.env"
UNIT_DEST="/etc/systemd/system/${SERVICE_NAME}.service"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_APP_DIR="${SCRIPT_DIR}/app"
SRC_UNIT="${SCRIPT_DIR}/abis.service"

# --- defaults / args ---------------------------------------------------------
UNATTENDED=0
ANSWERS_FILE=""

die()  { echo "error: $*" >&2; exit 1; }
info() { echo "==> $*"; }
warn() { echo "warning: $*" >&2; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    --unattended)   UNATTENDED=1; shift ;;
    --answers)      ANSWERS_FILE="${2:-}"; shift 2 ;;
    --answers=*)    ANSWERS_FILE="${1#*=}"; shift ;;
    -h|--help)      grep '^#' "$0" | grep -v '^#!' | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)              die "unknown argument: $1 (try --help)" ;;
  esac
done

# --- preflight ---------------------------------------------------------------
[[ "$(id -u)" -eq 0 ]] || die "must run as root (use sudo)."
command -v systemctl >/dev/null 2>&1 || die "systemd (systemctl) not found; this installer targets systemd hosts."
# Check existence, not the +x bit: some extraction tools drop modes, and we
# chmod the apphost ourselves after copying it into place.
[[ -f "${SRC_APP_DIR}/ABIS.Api" ]] || die "release payload missing: ${SRC_APP_DIR}/ABIS.Api not found. Run this from the extracted tarball."
[[ -f "$SRC_UNIT" ]] || die "unit template missing: ${SRC_UNIT}."

if [[ -n "$ANSWERS_FILE" ]]; then
  [[ -f "$ANSWERS_FILE" ]] || die "answers file not found: ${ANSWERS_FILE}"
  info "loading answers from ${ANSWERS_FILE}"
  # shellcheck disable=SC1090
  set -a; . "$ANSWERS_FILE"; set +a
fi

# --- read an existing env-file value (for upgrade-preserves-config) ----------
existing_value() {
  # $1 = exact KEY in ENV_FILE; echoes the unquoted value, or empty.
  [[ -f "$ENV_FILE" ]] || return 0
  local line; line="$(grep -m1 -E "^$1=" "$ENV_FILE" 2>/dev/null || true)"
  [[ -z "$line" ]] && return 0
  local val="${line#*=}"
  val="${val%\"}"; val="${val#\"}"   # strip one layer of surrounding quotes
  printf '%s' "$val"
}

generate_key() {
  if command -v openssl >/dev/null 2>&1; then
    openssl rand -base64 32 | tr -d '\n'
  else
    head -c 32 /dev/urandom | base64 | tr -d '\n'
  fi
}

# prompt VAR "label" "default"  — only prompts when interactive and VAR is empty
prompt() {
  local __var="$1" __label="$2" __default="${3:-}"
  local __current="${!__var:-}"
  [[ -n "$__current" ]] && return 0
  if [[ "$UNATTENDED" -eq 1 ]]; then
    printf -v "$__var" '%s' "$__default"
    return 0
  fi
  local __ans
  if [[ -n "$__default" ]]; then
    read -r -p "${__label} [${__default}]: " __ans
    __ans="${__ans:-$__default}"
  else
    read -r -p "${__label}: " __ans
  fi
  printf -v "$__var" '%s' "$__ans"
}

IS_UPGRADE=0
[[ -f "$ENV_FILE" ]] && IS_UPGRADE=1

# --- resolve configuration ---------------------------------------------------
# Seed defaults from any existing env file so an upgrade keeps current settings.
: "${ABIS_DB_CONNECTION:=$(existing_value Database__ConnectionString)}"
: "${ABIS_API_KEY:=$(existing_value ApiKeys__Keys__0)}"
: "${ABIS_DB_PROVIDER:=$(existing_value Database__Provider)}"
ABIS_PORT_EXISTING=""
if [[ -f "$ENV_FILE" ]]; then
  # parse the port back out of ASPNETCORE_URLS=http://127.0.0.1:<port>
  ABIS_PORT_EXISTING="$(existing_value ASPNETCORE_URLS | sed -n 's#.*:\([0-9]\{1,5\}\).*#\1#p')"
fi
: "${ABIS_PORT:=$ABIS_PORT_EXISTING}"

prompt ABIS_DB_PROVIDER   "Database provider (Oracle/Sqlite)" "Oracle"
prompt ABIS_DB_CONNECTION "Oracle connection string"         ""
prompt ABIS_PORT          "HTTP port (loopback, nginx fronts it in Phase 3)" "8080"

# API key: keep existing, else accept provided, else offer to generate.
if [[ -z "${ABIS_API_KEY:-}" ]]; then
  if [[ "$UNATTENDED" -eq 1 ]]; then
    ABIS_API_KEY="$(generate_key)"
    info "generated a new API key (unattended)."
  else
    read -r -p "API key (blank = auto-generate a strong one): " ABIS_API_KEY
    if [[ -z "$ABIS_API_KEY" ]]; then
      ABIS_API_KEY="$(generate_key)"
      info "generated a strong API key."
    fi
  fi
fi

# --- validate ----------------------------------------------------------------
[[ -n "${ABIS_DB_CONNECTION:-}" ]] || die "ABIS_DB_CONNECTION is required (Oracle connection string)."
[[ "$ABIS_PORT" =~ ^[0-9]+$ ]] && (( ABIS_PORT >= 1 && ABIS_PORT <= 65535 )) || die "ABIS_PORT must be 1-65535 (got: ${ABIS_PORT})."
case "${ABIS_DB_PROVIDER}" in Oracle|Sqlite) ;; *) die "ABIS_DB_PROVIDER must be Oracle or Sqlite (got: ${ABIS_DB_PROVIDER})." ;; esac

info "Configuration:"
echo "    mode      : $([[ "$IS_UPGRADE" -eq 1 ]] && echo upgrade || echo fresh install)"
echo "    provider  : ${ABIS_DB_PROVIDER}"
echo "    port      : 127.0.0.1:${ABIS_PORT}"
echo "    api key   : $([[ -n "$ABIS_API_KEY" ]] && echo '(set)' || echo '(none)')"

# --- stop existing service (idempotent upgrade) ------------------------------
if systemctl list-unit-files "${SERVICE_NAME}.service" >/dev/null 2>&1 \
   && systemctl is-active --quiet "$SERVICE_NAME"; then
  info "stopping running ${SERVICE_NAME} service for upgrade"
  systemctl stop "$SERVICE_NAME"
fi

# --- port availability (best effort, after stopping our own service) ---------
if command -v ss >/dev/null 2>&1; then
  if ss -ltnH 2>/dev/null | awk '{print $4}' | grep -qE "[:.]${ABIS_PORT}\$"; then
    if [[ "$UNATTENDED" -eq 1 ]]; then
      die "port ${ABIS_PORT} is already in use."
    else
      warn "port ${ABIS_PORT} appears to be in use by another process."
    fi
  fi
fi

# --- service user ------------------------------------------------------------
if ! id -u "$SERVICE_USER" >/dev/null 2>&1; then
  info "creating system user '${SERVICE_USER}'"
  useradd --system --user-group --no-create-home --home-dir /nonexistent \
          --shell /usr/sbin/nologin "$SERVICE_USER"
fi

# --- lay down application files ----------------------------------------------
info "installing application to ${APP_DIR}"
mkdir -p "$APP_DIR"
# Clean swap of binaries so removed files don't linger across upgrades.
rm -rf "${APP_DIR:?}/"*
cp -R "${SRC_APP_DIR}/." "$APP_DIR/"
chmod +x "${APP_DIR}/ABIS.Api"
chown -R "${SERVICE_USER}:${SERVICE_USER}" "$INSTALL_ROOT"

# --- write config (root-owned, group-readable by the service user) -----------
info "writing config to ${ENV_FILE}"
mkdir -p "$CONFIG_DIR"
umask 027
cat > "$ENV_FILE" <<EOF
# ABIS service configuration — written by install.sh. Root-owned, 0640.
# Re-run install.sh to change these; do not edit binaries under ${APP_DIR}.
ASPNETCORE_ENVIRONMENT=Production
ASPNETCORE_URLS="http://127.0.0.1:${ABIS_PORT}"
Database__Provider=${ABIS_DB_PROVIDER}
Database__Seed=false
Database__ConnectionString="${ABIS_DB_CONNECTION}"
ApiKeys__Enabled=true
ApiKeys__Keys__0="${ABIS_API_KEY}"
EOF
chown "root:${SERVICE_USER}" "$ENV_FILE"
chmod 0640 "$ENV_FILE"

# --- install + start the unit ------------------------------------------------
info "installing systemd unit ${UNIT_DEST}"
install -m 0644 "$SRC_UNIT" "$UNIT_DEST"
systemctl daemon-reload
systemctl enable "$SERVICE_NAME" >/dev/null 2>&1 || true
info "starting ${SERVICE_NAME}"
systemctl restart "$SERVICE_NAME"

# --- health gate -------------------------------------------------------------
HEALTH_URL="http://127.0.0.1:${ABIS_PORT}/health/ready"
info "waiting for readiness at ${HEALTH_URL} (Oracle must be reachable)"
get_code() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsS -o /dev/null -w '%{http_code}' --max-time 3 "$1" 2>/dev/null || true
  elif command -v wget >/dev/null 2>&1; then
    wget -q -T 3 -O /dev/null "$1" >/dev/null 2>&1 && echo 200 || true
  else
    echo "SKIP"
  fi
}

ready=0
for _ in $(seq 1 30); do
  code="$(get_code "$HEALTH_URL")"
  if [[ "$code" == "SKIP" ]]; then
    warn "neither curl nor wget present; skipping the health check."
    ready=2; break
  fi
  if [[ "$code" == "200" ]]; then ready=1; break; fi
  if ! systemctl is-active --quiet "$SERVICE_NAME"; then
    die "service ${SERVICE_NAME} exited during startup. Inspect: journalctl -u ${SERVICE_NAME} -n 50 --no-pager"
  fi
  sleep 2
done

echo
if [[ "$ready" -eq 1 ]]; then
  info "ABIS is up and Oracle is reachable."
elif [[ "$ready" -eq 2 ]]; then
  info "ABIS service started (health check skipped)."
else
  warn "service is running but ${HEALTH_URL} did not return 200 within the timeout."
  warn "the app is up but likely can't reach Oracle yet. Check the connection string and:"
  warn "  journalctl -u ${SERVICE_NAME} -n 50 --no-pager"
fi

cat <<EOF

ABIS ${SERVICE_NAME} service installed.
  Status : systemctl status ${SERVICE_NAME}
  Logs   : journalctl -u ${SERVICE_NAME} -f
  Local  : http://127.0.0.1:${ABIS_PORT}/health/ready
           http://127.0.0.1:${ABIS_PORT}/ui/order-entry.html
  Config : ${ENV_FILE}
  API key (X-Api-Key header):
    ${ABIS_API_KEY}

Public HTTPS access (nginx + Let's Encrypt) is added in Phase 3. For now the
service is reachable on loopback only.
EOF
