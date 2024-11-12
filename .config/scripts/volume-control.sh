#!/bin/bash

argument=$1;
getVolume="$(pamixer --get-volume @DEFAULT_SINK@)"

if [ $(($getVolume + ${argument%?})) -gt 100 ] ; then
  pactl -- set-sink-volume @DEFAULT_SINK@ 100%
else
  pactl -- set-sink-volume @DEFAULT_SINK@ $argument
fi

paplay ~/Documents/select.mp3 #to be changed
