#!/bin/bash

# Get monitor height
monitor_height=$(hyprctl monitors -j | jq -r '.[0].height')
terminal_height=$((monitor_height * 45 / 100))

# Get monitor width
monitor_width=$(hyprctl monitors -j | jq -r '.[0].width')

TERMINATOR_WINDOW=$(hyprctl clients | jq -r '.[] | select(.class == "terminator") | .address')

if [ -n "$TERMINATOR_WINDOW" ]; then
  hyprctl dispatch togglefloating "$TERMINATOR_WINDOW"
else
  terminator -c dropdown_config --geometry="${monitor_width}x${terminal_height}+0+0" --name=dropdown_terminator
  sleep 0.1
  TERMINATOR_WINDOW=$(hyprctl clients | jq -r '.[] | select(.class == "terminator") | .address')
  hyprctl dispatch togglefloating "$TERMINATOR_WINDOW"
  hyprctl dispatch focuswindow "$TERMINATOR_WINDOW"
fi
