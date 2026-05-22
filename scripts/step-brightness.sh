#!/usr/bin/env bash

steps=(0 1 2 3 5 10 15 25 40 60 80 100)

current=$(brightnessctl -d intel_backlight g)
max=$(brightnessctl -d intel_backlight m)
cur_percent=$((100 * current / max))

if [[ $1 == "up" ]]; then
    for s in "''${steps[@]}"; do
        if (( s > cur_percent )); then
            brightnessctl -d intel_backlight s "''${s}%"
            exit 0
        fi
    done
elif [[ $1 == "down" ]]; then
    prev=0
    for s in "''${steps[@]}"; do
        if (( s >= cur_percent )); then
            brightnessctl -d intel_backlight s "''${prev}%"
            exit 0
        fi
        prev=$s
    done
fi