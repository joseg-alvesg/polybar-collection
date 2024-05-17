#!/bin/bash

# NOTE: check $HOME/polybar-collection/scripts/polybar-spotify/get_spotify_status.sh
PLAYER="$(playerctl -ls | grep -E 'spotify|spotifyd' | head -n 1 | cut -d '.' -f1)"

if [ "$(
	playerctl -p $PLAYER status >>/dev/null 2>&1
	echo $?
)" == "1" ]; then
	echo ""
	exit 0
fi

if [ "$(playerctl -p $PLAYER status)" == "Playing" ]; then
	echo "%{T1}%{T-}"
elif [ "$(playerctl -p $PLAYER status)" == "Paused" ]; then
	echo "%{T1}%{T1}"
else
	exit 0
fi
