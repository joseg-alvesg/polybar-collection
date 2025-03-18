#!/bin/bash

cmd="${0%/*}/get_status.sh $1"

zscroll -l 30 \
	--scroll-padding "$(printf ' %.0s' {1..8})" \
	-d 0.3 \
	-M "$cmd status" \
	-m "Playing" "--scroll 1" \
	-m "Paused" "--scroll 0" \
	-U 10 -u t "$cmd" &

wait
