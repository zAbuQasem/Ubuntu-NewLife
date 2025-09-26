#!/usr/bin/env bash
# WireGuard toggle script (MetaCTF) with dunst notifications (dunstify)
# Requires a sudoers NOPASSWD rule, e.g. (visudo -f /etc/sudoers.d/wireguard-metactf):
#   yourusername ALL=(root) NOPASSWD: /usr/bin/wg-quick up MetaCTF, /usr/bin/wg-quick down MetaCTF
#
# Optional logging: set VPN_TOGGLE_LOG=1

set -euo pipefail

IFACE="MetaCTF"
WG_QUICK_BIN="$(command -v wg-quick || true)"
ICON_UP="network-vpn"
ICON_DOWN="network-offline"
TAGFILE="/tmp/dunst-vpn-${IFACE}.id"
LOGFILE="/tmp/wg-toggle-${IFACE}.log"

have() { command -v "$1" >/dev/null 2>&1; }
fail() { echo "Error: $*" >&2; exit 1; }

[ -n "$WG_QUICK_BIN" ] || fail "wg-quick not found"
have sudo      || fail "sudo not found"
have dunstify  || fail "dunstify not found (install dunst)"

log() { [ "${VPN_TOGGLE_LOG:-0}" = 1 ] && echo "$(date --iso=seconds) $*" >>"$LOGFILE"; }

notify() {
  # notify <urgency> <title> [body] [icon]
  local urgency="$1" title="$2" body="${3:-}" icon="${4:-}"
  local oldid="" nid="" idopts=() icon_args=()
  [ -f "$TAGFILE" ] && oldid="$(<"$TAGFILE")" && [ -n "$oldid" ] && idopts=(-r "$oldid")
  [ -n "$icon" ] && icon_args=(-i "$icon")
  nid=$(dunstify -u "$urgency" "${icon_args[@]}" "${idopts[@]}" "$title" "$body" || true)
  [ -n "$nid" ] && echo "$nid" >"$TAGFILE"
}

is_up() {
  # Interface exists and is wireguard type
  ip link show "$IFACE" >/dev/null 2>&1 && ip -d link show "$IFACE" 2>/dev/null | grep -qi wireguard
}

wg_do() {
  # wg_do <up|down>
  local action="$1" output rc=0
  if output=$(sudo -n "$WG_QUICK_BIN" "$action" "$IFACE" 2>&1); then
    return 0
  else
    rc=$?
    # Idempotent benign cases -> treat as success
    if [ "$action" = up ]   && grep -qi "already exists" <<<"$output"; then return 0; fi
    if [ "$action" = down ] && grep -Eqi "(No such device|Cannot find device)" <<<"$output"; then return 0; fi
    if grep -qi "password is required" <<<"$output"; then
      notify critical "VPN Error" "Missing sudo NOPASSWD rule" "$ICON_DOWN"
    fi
    log "ERROR ($action): $output"
    return $rc
  fi
}

bring_up() {
  if wg_do up; then
    notify normal "VPN Connected" "$IFACE up" "$ICON_UP"
    log "UP"
  else
    notify critical "VPN Error" "Failed to bring up $IFACE" "$ICON_DOWN"
    log "UP FAIL"
    exit 1
  fi
}

bring_down() {
  if wg_do down; then
    notify normal "VPN Disconnected" "$IFACE down" "$ICON_DOWN"
    log "DOWN"
  else
    notify critical "VPN Error" "Failed to bring down $IFACE" "$ICON_DOWN"
    log "DOWN FAIL"
    exit 1
  fi
}

if is_up; then
  bring_down
else
  bring_up
fi