#!/bin/bash
set -euo pipefail

# Simple rofi-based power menu for i3
# Actions: Lock, Suspend, Hibernate, Reboot, Shutdown, Logout, Screen Off, Cancel

ROFI_CMD=(rofi -dmenu -i -p "System" -no-fixed-num-lines)

lock_cmd() {
  if [ -x "$HOME/.config/i3/scripts/i3lock-color.sh" ]; then
    "$HOME/.config/i3/scripts/i3lock-color.sh"
  elif command -v i3lock >/dev/null 2>&1; then
    i3lock -c 000000
  fi
}

confirm() {
  local prompt="$1"
  local choice
  choice=$(printf "No\nYes" | "${ROFI_CMD[@]}" -p "$prompt") || true
  [ "$choice" = "Yes" ]
}

power_menu() {
  printf "%s\n" \
    "Lock" \
    "Suspend" \
    "Reboot" \
    "Shutdown" \
    "Logout"
}

main() {
  local selection
  selection=$(power_menu | "${ROFI_CMD[@]}") || exit 0

  case "$selection" in
    "Lock")
      lock_cmd
      ;;
    "Suspend")
      lock_cmd || true
      systemctl suspend
      ;;
    "Reboot")
      if confirm "Reboot?"; then systemctl reboot; fi
      ;;
    "Shutdown")
      if confirm "Power off?"; then systemctl poweroff; fi
      ;;
    "Logout")
      if confirm "Logout i3?"; then i3-msg exit >/dev/null; fi
      ;;
    *)
      # Cancel or empty selection
      ;;
  esac
}

main "$@"
