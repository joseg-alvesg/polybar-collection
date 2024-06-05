#!/bin/bash

# NOTE: check $HOME/polybar-collection/scripts/polybar-spotify/get_spotify_status.sh

if [ ! -f /tmp/selected_player.txt ]; then exit 1; fi
PLAYER="$(cat /tmp/selected_player.txt)"

if [ "$1" == "next" ]; then
	playerctl -p $PLAYER next
	exit 1
fi

if [ "$(
	playerctl -p $PLAYER status >>/dev/null 2>&1
	echo $?
)" == "1" ]; then
	echo ""
else
	echo ""
fi
