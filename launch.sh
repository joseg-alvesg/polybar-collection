#!/usr/bin/env bash

THEME="murplez"

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

CONFIG_DIR=~/polybar-collection/themes/$THEME/config.ini
polybar -r main -c $CONFIG_DIR &
polybar -r second -c $CONFIG_DIR &
