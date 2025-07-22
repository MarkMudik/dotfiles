#!/bin/bash

if hyprctl clients | grep -q "class: Emacs"; then
  hyprctl dispatch focuswindow "class:^(Emacs)$"
else
  emacs &
fi
