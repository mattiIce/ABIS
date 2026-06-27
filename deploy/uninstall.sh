#!/usr/bin/env bash
#
# uninstall.sh — remove the ABIS systemd service.
#
#   sudo ./uninstall.sh            # stop + remove service and /opt/abis;
#                                   # KEEPS config (/etc/abis) and the abis user
#   sudo ./uninstall.sh --purge    # also remove /etc/abis and the abis user
#
# Config is preserved by default so a later reinstall keeps the connection
# string + API key. Use --purge for a clean teardown.
#
set -euo pipefail

SERVICE_NAME="abis"
SERVICE_USER="abis"
INSTALL_ROOT="/opt/abis"
CONFIG_DIR="/etc/abis"
UNIT_DEST="/etc/systemd/system/${SERVICE_NAME}.service"

PURGE=0
die()  { echo "error: $*" >&2; exit 1; }
info() { echo "==> $*"; }

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

if [[ -d "$INSTALL_ROOT" ]]; then
  info "removing ${INSTALL_ROOT}"
  rm -rf "$INSTALL_ROOT"
fi

if [[ "$PURGE" -eq 1 ]]; then
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
  info "ABIS service removed. Config kept at ${CONFIG_DIR} (use --purge to remove)."
fi
