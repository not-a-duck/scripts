#!/bin/sh

# requires
# ffmpeg
# xorg

# NOTE we cannot gracefully quit recording if activated on background
# to quit recording we would have to pkill ffmpeg
filename=$(date +"%Y-%m-%d_%H:%M:%S.mp4")
ffmpeg -draw_mouse 0 -follow_mouse centered -f x11grab -video_size 1080x1080 -i $DISPLAY -c:v libx264 -preset ultrafast "$filename"
