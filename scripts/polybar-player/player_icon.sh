#!/usr/bin/env bash
if [ ! -f /tmp/selected_player.txt ]; then
	PLAYER="none"
else
	CMD=$(exec $(dirname "$0")/get_status.sh main icon)
fi

# echo "222 $CMD 222"

case "$CMD" in
spotify*) echo " %{T1} %{T-}" ;;
*VLC*) echo "%{T1}󰕼 %{T-}" ;;
mpv*) echo "%{T1} %{T-}" ;;
*Netflix*) echo "%{T1}ﱄ %{T-}" ;;
*YouTube*) echo "%{T1} %{T-}" ;;
*"Prime Video"*) echo "%{T1} %{T-}" ;;
chromium*) echo "%{T1} %{T-}" ;;
firefox*) echo "%{T1} %{T-}" ;;
*) echo "%{T1} %{T-}" ;;
esac
