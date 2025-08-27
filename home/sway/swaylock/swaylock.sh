#!/usr/bin/env bash

outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active) | .name')
swaylock_args=()

for output_name in $outputs; do
    blur_path="/tmp/swaylock-${output_name}.png"
    swaylock_args+=(-i "${output_name}:${blur_path}")
    (grim -o "${output_name}" - | magick - -scale 10% -blur 0x2.5 -resize 1000% "${blur_path}") &
done

wait

/run/current-system/sw/bin/swaylock "${swaylock_args[@]}"
