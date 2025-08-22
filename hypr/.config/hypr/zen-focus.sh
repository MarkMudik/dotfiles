#!/bin/bash

# If a Brave window exists, focus it, else launch Brave
if hyprctl clients | grep -q "class: zen"; then
  hyprctl dispatch focuswindow "class:^(zen)$"
else
  zen-browser &
fi
