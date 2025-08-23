#!/bin/bash

if hyprctl clients | grep -q "class: emacs"; then
  hyprctl dispatch focuswindow "class:^(emacs)$"
else
  emacsclient -nc
fi
