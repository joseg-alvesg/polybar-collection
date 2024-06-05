#!/bin/bash

# see man zscroll for documentation of the following parameters
echo "212"
zscroll -l 30 \
	--delay 0.1 \
	--match-command "$(dirname $0)/get_status.sh --status" \
	--match-text "Playing" "--scroll 1" \
	--match-text "Paused" "--scroll 0" \
	--update-check true "$(dirname $0)/get_status.sh" &

sleep 3
wait
