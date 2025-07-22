#!/bin/bash

# If a Firefox window exists, focus it, else launch Firefox
if hyprctl clients | grep -q "class: firefox"; then
  hyprctl dispatch focuswindow "class:^(firefox)$"
else
  firefox &
fi
