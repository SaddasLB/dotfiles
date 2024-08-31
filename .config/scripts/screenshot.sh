#!/bin/bash

if pgrep -x "grim" > /dev/null; then
  killall grim
else
  grim -g "$(slurp -d)" - | wl-copy  
fi
