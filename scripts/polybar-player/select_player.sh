#!/bin/bash

# NOTE: set a sxhkd keybinding to run this script is recommended

players=$(playerctl -ls | cut -d '.' -f1)

if [ -z "$players" ]; then
	notify-send "No active players found."
	exit 1
fi

# WARN: the position of rofi box is static and need to be adjusted manually
# in window > x-offset inside rasi file

selected_player=$(
	echo "none
$players" | rofi -dmenu -i -p "Select player" \
		-mesg "Select player" \
		-font "Symbols Nerd Font 12" \
		-config "~/polybar-collection/scripts/polybar-player/select_player.rasi" \
		-width "15" \
		-lines 5 -line-margin 3 -line-padding 10 -scrollbar-width "0"
)

if [ -n "$selected_player" ]; then
	if [ "$selected_player" == "None" ]; then
		echo "none" >/tmp/selected_player.txt
		notify-send "Player deselected."
		exit 0
	fi
	echo $selected_player >/tmp/selected_player.txt
	notify-send "Selected player: $selected_player"
else
	exit 1
fi
