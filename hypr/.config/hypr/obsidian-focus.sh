#!/bin/bash

if hyprctl clients | grep -q "class: obsidian"; then
  hyprctl dispatch focuswindow "class:^(obsidian)$"
else
  obsidian &
fi
