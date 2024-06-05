#!/usr/bin/env bash
if [ ! -f /tmp/selected_player.txt ]; then
	PLAYER="none"
else
	PLAYER=$(cat /tmp/selected_player.txt)
fi

if [ "$PLAYER" == "spotify" ]; then
	echo " %{T1} %{T-}"
elif [ "$PLAYER" == "chromium" ]; then
	echo "%{T1} %{T-}"
elif [ "$PLAYER" == "firefox" ]; then
	echo "%{T1} %{T-}"
elif [ "$PLAYER" == "vlc" ]; then
	echo "echo %{T1} %{T-}"
elif [ "$PLAYER" == "none" ]; then
	if [ -n "$(playerctl -ls | cut -d '.' -f1)" ]; then
		echo "%{T1}󰝚 %{T-}"
	else
		echo ""
	fi
else
	echo ""
fi
