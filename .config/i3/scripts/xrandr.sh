#!/bin/sh

# My dual-monitor setup script using xrandr.
# If both external monitors are connected, turn off laptop screen and use both externals.
need_outputs="DP-1 HDMI-1-0"

all_up=true
for o in $need_outputs; do
  if ! xrandr | grep -q "^$o connected"; then
    all_up=false
    break
  fi
done

if $all_up; then
  # Both external monitors present: apply layout
  echo "[+] Both monitors connected, applying layout" | tee -a /tmp/xrandr.log
  xrandr --output eDP-1 --off \
         --output DP-1 --mode 2560x1440 --pos 2560x0 --rotate normal \
         --output HDMI-1-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
         --output DP-2 --off --output DP-1-0 --off --output DP-1-1 --off \
         --output DP-1-2 --off
else
  # Fallback: enable laptop panel
  echo "[-] One or both monitors not connected, using laptop screen only" | tee -a /tmp/xrandr.log
  xrandr --output eDP-1 --auto --primary
fi
