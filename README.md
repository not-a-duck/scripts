# Scripts

Requirements are listed at the top of the script

## Quick summary

* Record screen (Xorg + ffmpeg + scrot)
    * record-area.sh
        * Fixed size area on your screen
    * record-mouse.sh
        * Fixed size (1080x1080) area around cursor
    * record-screen.sh
        * Record $DISPLAY

* move-resize.sh (Xorg + xdotool)
    * Move and resize a _focused_ window in one go (set a hotkey with your mouse to make this very fast and comfortable)

* recursive-diff.sh (ripgrep + bash + nvim)
    * Given two directories, find the similarities and differences
        1. Any file that exists in both directories and is similar will be skipped
        2. Any file that exists in both directories but are dissimilar, will be opened using `nvim -d`
