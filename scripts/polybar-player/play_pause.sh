#!/bin/bash

if [ ! -f /tmp/selected_player.txt ]; then exit 1; fi
PLAYER="$(cat /tmp/selected_player.txt)"

if [ "$1" == "play-pause" ]; then
	playerctl -p $PLAYER play-pause
	exit 1
fi

if [ "$(
	playerctl -p $PLAYER status >/dev/null 2>&1
	echo $?
)" -eq 1 ] || [ "$(playerctl -p $PLAYER metadata 2>&1)" == "No player could handle this command" ]; then
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
