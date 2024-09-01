#!/bin/bash

if pgrep -x "wofi" > /dev/null; then
  killall wofi
else
  cliphist list | wofi --dmenu | cliphist decode | wl-copy
fi

