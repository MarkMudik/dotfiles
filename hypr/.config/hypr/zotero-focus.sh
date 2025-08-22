#!/bin/bash

if hyprctl clients | grep -q "class: Zotero"; then
  hyprctl dispatch focuswindow "class:^(Zotero)$"
else
  Zotero &
fi
