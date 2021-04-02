#!/bin/sh

# requires
# slop
# ffmpeg
# xorg

xysize=$(slop -c 0,0.5,1.0,0.3 -l -f "%x %y %wx%h")
if [ -z "$xysize" ]; then
    exit 1;
fi

set $xysize
x=$1
y=$2
size=$3

# NOTE we cannot gracefully quit recording if activated on background
# to quit recording we would have to pkill ffmpeg
filename=$(date +"%Y-%m-%d_%H:%M:%S.mp4")
ffmpeg -draw_mouse 0 -f x11grab -video_size "$size" -i $DISPLAY+$x,$y -c:v libx264 -preset ultrafast "$filename"
