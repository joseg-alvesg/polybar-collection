#!/bin/bash

if [ "$(
	playerctl -p spotify status >>/dev/null 2>&1
	echo $?
)" == "1" ]; then
	echo ""
	exit 0
fi

if [ "$(playerctl -p spotify status)" == "Playing" ]; then
	echo "%{T1}%{T-}"
elif [ "$(playerctl -p spotify status)" == "Paused" ]; then
	echo "%{T1}%{T1}"
else
	exit 0
fi
