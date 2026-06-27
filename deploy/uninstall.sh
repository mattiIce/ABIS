#!/usr/bin/env bash
#
# uninstall.sh — remove the ABIS systemd service.
#
#   sudo ./uninstall.sh            # stop + remove service, /opt/abis, nginx site;
#                                   # KEEPS config (/etc/abis), the abis user, and
#                                   # any Let's Encrypt certificate
#   sudo ./uninstall.sh --purge    # also remove /etc/abis, the abis user, and the
#                                   # certbot certificate for the stored server name
#
# Config is preserved by default so a later reinstall keeps the connection
# string + API key. Use --purge for a clean teardown. nginx/certbot packages are
# left installed (they may serve other sites).
#
set -euo pipefail

SERVICE_NAME="abis"
SERVICE_USER="abis"
INSTALL_ROOT="/opt/abis"
CONFIG_DIR="/etc/abis"
STATE_FILE="${CONFIG_DIR}/install.state"
UNIT_DEST="/etc/systemd/system/${SERVICE_NAME}.service"
NGINX_SITE_AVAIL="/etc/nginx/sites-available/${SERVICE_NAME}"
NGINX_SITE_ENABLED="/etc/nginx/sites-enabled/${SERVICE_NAME}"

PURGE=0
die()  { echo "error: $*" >&2; exit 1; }
info() { echo "==> $*"; }

# Read a value from the install state file (nginx/TLS settings), or empty.
state_value() {
  [[ -f "$STATE_FILE" ]] || return 0
  local line; line="$(grep -m1 -E "^$1=" "$STATE_FILE" 2>/dev/null || true)"
  [[ -z "$line" ]] && return 0
  local val="${line#*=}"; val="${val%\"}"; val="${val#\"}"
  printf '%s' "$val"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --purge)   PURGE=1; shift ;;
    -h|--help) grep '^#' "$0" | grep -v '^#!' | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)         die "unknown argument: $1 (try --help)" ;;
  esac
done

[[ "$(id -u)" -eq 0 ]] || die "must run as root (use sudo)."
command -v systemctl >/dev/null 2>&1 || die "systemd (systemctl) not found."

if systemctl list-unit-files "${SERVICE_NAME}.service" >/dev/null 2>&1; then
  info "stopping and disabling ${SERVICE_NAME}"
  systemctl disable --now "$SERVICE_NAME" >/dev/null 2>&1 || true
fi

if [[ -f "$UNIT_DEST" ]]; then
  info "removing unit ${UNIT_DEST}"
  rm -f "$UNIT_DEST"
  systemctl daemon-reload
fi

# Remove the nginx site (leave nginx itself installed for any other vhosts).
SERVER_NAME="$(state_value ABIS_SERVER_NAME)"
if [[ -e "$NGINX_SITE_ENABLED" || -e "$NGINX_SITE_AVAIL" ]]; then
  info "removing nginx site for ${SERVER_NAME:-abis}"
  rm -f "$NGINX_SITE_ENABLED" "$NGINX_SITE_AVAIL"
  if command -v nginx >/dev/null 2>&1 && nginx -t >/dev/null 2>&1; then
    systemctl reload nginx 2>/dev/null || true
  fi
fi

if [[ -d "$INSTALL_ROOT" ]]; then
  info "removing ${INSTALL_ROOT}"
  rm -rf "$INSTALL_ROOT"
fi

if [[ "$PURGE" -eq 1 ]]; then
  # Delete the Let's Encrypt certificate for the stored server name (best effort).
  if [[ -n "$SERVER_NAME" ]] && command -v certbot >/dev/null 2>&1; then
    info "deleting certbot certificate for ${SERVER_NAME}"
    certbot delete --cert-name "$SERVER_NAME" --non-interactive >/dev/null 2>&1 || true
  fi
  if [[ -d "$CONFIG_DIR" ]]; then
    info "purging config ${CONFIG_DIR}"
    rm -rf "$CONFIG_DIR"
  fi
  if id -u "$SERVICE_USER" >/dev/null 2>&1; then
    info "removing user ${SERVICE_USER}"
    userdel "$SERVICE_USER" >/dev/null 2>&1 || true
  fi
  info "ABIS fully removed."
else
  info "ABIS service + nginx site removed. Config kept at ${CONFIG_DIR}, certificate kept (use --purge to remove)."
fi
