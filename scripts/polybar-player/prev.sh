#!/bin/bash

PLAYER="$(cat /tmp/selected_player.txt)"

if [ "$1" == "prev" ]; then
	playerctl -p $PLAYER previous
	exit 1
fi

if [ "$(
	playerctl -p $PLAYER status >>/dev/null 2>&1
	echo $?
)" == "1" ]; then
	echo ""
else
	echo ""
fi
