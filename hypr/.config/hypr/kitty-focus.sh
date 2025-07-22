#!/bin/bash

if hyprctl clients | grep -q "class: kitty"; then
  hyprctl dispatch focuswindow "class:^(kitty)$"
else
  kitty &
fi
