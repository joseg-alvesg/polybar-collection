#!/usr/bin/env bash

# original code from polybar-spotify
# https://github.com/PrayagS/polybar-spotify

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="now-playing"
PARENT_BAR_PID=$(pgrep -a "polybar" | cut -d" " -f1)

if [ ! -f /tmp/selected_player.txt ]; then exit 1; fi
PLAYER="$(cat /tmp/selected_player.txt)"

FORMAT="{{ title }} - {{ artist }}"

update_hooks() {
	while IFS= read -r id; do
		polybar-msg -p "$id" hook player-play-pause $2 1>/dev/null 2>&1
	done < <(echo "$1")
}

PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
	STATUS=$PLAYERCTL_STATUS
else
	STATUS="No player"
fi

if [ "$1" == "--status" ]; then
	echo "$STATUS"
else
	if [ "$STATUS" = "Stopped" ]; then
		echo ""
	elif [ "$STATUS" = "Playing" ]; then
		update_hooks "$PARENT_BAR_PID" 1
		playerctl --player=$PLAYER metadata --format "$FORMAT"
	elif [ "$STATUS" = "Paused" ]; then
		update_hooks "$PARENT_BAR_PID" 2
		playerctl --player=$PLAYER metadata --format "$FORMAT"
	elif [ "$STATUS" = "No player" ]; then
		update_hooks "$PARENT_BAR_PID" 3
	else
		echo "NA"
		update_hooks "$PARENT_BAR_PID" 2
	fi
fi
