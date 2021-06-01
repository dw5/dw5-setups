#!/bin/bash
# SCREENSHOT="/home/purism/Pictures/$(date +%Y-%m-%d-%H%M%S).png"
INPUT=`yad --title Screenshot --text="Take screenshot after X seconds" --form --field=seconds:NUM "5" --focus-field=2`
#SCREENSHOT=`echo $INPUT | cut -d '|' -f1`
SECONDS=`echo $INPUT | cut -d '|' -f1`
if [ "$SECONDS" -eq 0 ]; then
  exit
fi
notify-send -t 1000 screenshot "Taking a screenshot in $SECONDS seconds"
sleep $SECONDS
grim #"$SCREENSHOT"
notify-send screenshot "Screenshot is saved."
