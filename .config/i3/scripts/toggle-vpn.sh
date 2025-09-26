#!/usr/bin/env bash

# WireGuard toggle (MetaCTF) – idempotent + dunst notifications
# Sudoers (visudo -f /etc/sudoers.d/wireguard-metactf):
#   yourusername ALL=(root) NOPASSWD: /usr/bin/wg-quick up MetaCTF, /usr/bin/wg-quick down MetaCTF

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
have sudo || fail "sudo not found"
have dunstify || fail "dunstify not found (install dunst)"

log() { [ "${VPN_TOGGLE_LOG:-0}" = 1 ] && echo "$(date --iso=seconds) $*" >>"$LOGFILE"; }

notify() {
	local urgency="$1"; shift
	local title="$1"; shift
	local body="$1"; shift || true
	local icon="${1:-}" idopts=() oldid new_id
	[ -f "$TAGFILE" ] && oldid="$(cat "$TAGFILE" 2>/dev/null || true)" && [ -n "$oldid" ] && idopts=( -r "$oldid" )
	[ -n "$icon" ] && icon=( -i "$icon" ) || icon=()
	# shellcheck disable=SC2068
	new_id=$(dunstify -u "$urgency" "${icon[@]}" ${idopts[@]} "$title" "$body" || true)
	[ -n "$new_id" ] && echo "$new_id" >"$TAGFILE"
}

is_up() { ip link show "$IFACE" >/dev/null 2>&1; }

wg_do() {
	# wg_do <up|down>
	local action="$1" output rc=0
	if output=$(sudo -n "$WG_QUICK_BIN" "$action" "$IFACE" 2>&1); then
		return 0
	else
		rc=$?
		# Idempotent cases -> treat as success
		if [ "$action" = up ] && [[ "$output" == *"already exists"* ]]; then
			return 0
		fi
		if [ "$action" = down ] && [[ "$output" =~ (No\ such\ device|Cannot\ find\ device) ]]; then
			return 0
		fi
		if [[ "$output" == *"a password is required"* || "$output" == *"password is required"* ]]; then
			notify critical "VPN Error" "NOPASSWD sudo rule missing" "$ICON_DOWN"
		fi
		echo "$output" >>"$LOGFILE"
		return $rc
	fi
}

up() {
	if wg_do up; then
		notify normal "VPN Connected" "$IFACE up" "$ICON_UP"
		log "UP"
	else
		notify critical "VPN Error" "Failed to bring up $IFACE" "$ICON_DOWN"
		log "UP FAIL"
		exit 1
	fi
}

down() {
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
	down
else
	up
fi