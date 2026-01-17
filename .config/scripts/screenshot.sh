#!/bin/bash

if pgrep -x slurp > /dev/null; then
  pkill slurp
  exit 0
fi

if [ $1 == "mono" ]; then
  grim -o "$(hyprctl activeworkspace -j | jq -r '.monitor // empty')" - | wl-copy
  exit 0
fi

selection=$(slurp -d) || exit 0

# if slurp did good:
grim -g "$selection" - | wl-copy
