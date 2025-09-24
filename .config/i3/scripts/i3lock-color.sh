#!/bin/sh

# Pick a theme by exporting I3LOCK_THEME before running this script.
# Supported: catppuccin, nord, gruvbox, tokyo, dracula
# Default is fixed to 'tokyo' (no random selection) for faster startup.
if [ -n "$I3LOCK_THEME" ]; then
	THEME="$I3LOCK_THEME"
else
	THEME="tokyo"
fi

case "$THEME" in
	catppuccin)
		# Catppuccin Mocha
		BLANK='#00000000'
		CLEAR='#1e1e2e99'      # overlay (60% alpha)
		DEFAULT='#89b4faff'    # accent (blue)
		TEXT='#cdd6f4ff'       # text (latte)
		WRONG='#f38ba8ff'      # red
		VERIFYING='#a6e3a1ff'  # green
		KEYHL='#fab387ff'      # peach
		BSHL='#f38ba8ff'       # red
		;;
	nord)
		BLANK='#00000000'
		CLEAR='#2e344099'
		DEFAULT='#88c0d0ff'
		TEXT='#e5e9f0ff'
		WRONG='#bf616aff'
		VERIFYING='#a3be8cff'
		KEYHL='#d08770ff'
		BSHL='#bf616aff'
		;;
	gruvbox)
		BLANK='#00000000'
		CLEAR='#28282899'
		DEFAULT='#83a598ff'
		TEXT='#fbf1c7ff'
		WRONG='#fb4934ff'
		VERIFYING='#b8bb26ff'
		KEYHL='#d79921ff'
		BSHL='#fb4934ff'
		;;
	tokyo)
		BLANK='#00000000'
		CLEAR='#1a1b2699'
		DEFAULT='#7aa2f7ff'
		TEXT='#c0caf5ff'
		WRONG='#f7768eff'
		VERIFYING='#9ece6aff'
		KEYHL='#bb9af7ff'
		BSHL='#f7768eff'
		;;
	dracula)
		BLANK='#00000000'
		CLEAR='#282a3699'
		DEFAULT='#bd93f9ff'
		TEXT='#f8f8f2ff'
		WRONG='#ff5555ff'
		VERIFYING='#50fa7bff'
		KEYHL='#ffb86cff'
		BSHL='#ff5555ff'
		;;
	*)
		# Sensible fallback
		BLANK='#00000000'
		CLEAR='#00000088'
		DEFAULT='#5294e2ff'
		TEXT='#f0f0f0ff'
		WRONG='#ff6b6bff'
		VERIFYING='#8bd5aaff'
		KEYHL='#ffae56ff'
		BSHL='#ff6b6bff'
		;;
esac

i3lock \
--blur 12 \
--radius 120 \
--ring-width 9 \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$KEYHL         \
--bshl-color=$BSHL           \
\
--screen 2                   \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%A, %Y-%m-%d"       \
--keylayout 1                \