#!/bin/bash

if hyprctl clients | grep -q "class: com.mitchellh.ghostty"; then
  hyprctl dispatch focuswindow "class:^(com.mitchellh.ghostty)$"
else
  ghostty &
fi
