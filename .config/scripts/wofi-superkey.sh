#!/bin/bash

if pgrep -x "wofi" > /dev/null; then
  killall wofi
else
  wofi --width 500 --height 400 --show drun -a --insensitive -I --hide-scroll
fi
