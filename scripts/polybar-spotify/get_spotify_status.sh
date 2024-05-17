#!/usr/bin/env bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="now-playing"
PARENT_BAR_PID=$(pgrep -a "polybar" | cut -d" " -f1)

PLAYER="$(playerctl -ls | grep -E 'spotify|spotifyd' | head -n 1 | cut -d '.' -f1)"

FORMAT="{{ title }} - {{ artist }}"

# TODO: check later
update_hooks() {
	while IFS= read -r id; do
		polybar-msg -p "$id" hook spotify-play-pause $2 1>/dev/null 2>&1
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
