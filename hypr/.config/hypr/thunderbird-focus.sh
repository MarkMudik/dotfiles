#!/bin/bash

if hyprctl clients | grep -q "class: thunderbird"; then
  hyprctl dispatch focuswindow "class:^(thunderbird)$"
else
  thunderbird &
fi
