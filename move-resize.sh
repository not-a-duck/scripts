#!/bin/sh

# requires
# slop
# xdotool (xorg)

xysize=$(slop -c 0,0.5,1.0,0.3 -l -f "%x %y %w %h")
if [ -z "$xysize" ]; then
    exit 1;
fi

set $xysize
x=$1
y=$2
width=$3
height=$4
xdotool getactivewindow windowmove $x $y windowsize $width $height
