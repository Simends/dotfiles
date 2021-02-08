#!/bin/sh
# Script to start dwm. Used by xinitrc

# Set screen resolution
xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 0x240 --rotate normal --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 2560x0 --rotate right

# Set norwegian keymap
setxkbmap no &

#---Start applications/daemons---

# Start redshift
redshift -c ~/.config/redshift/redshift.conf &

# Set wallpaper
feh --bg-fill --no-fehbg --randomize ~/Multimedia/Pictures/Wallpapers/* &

# Start compositor
picom --config ~/.config/picom.conf &

# Start the polkit agent
lxsession &

# Start the notification server
dunst &

# Start the clipboard deamon
clipmenud &

# Start emacs daemon
emacs --daemon &

# ---Mount the clouds---
# Onedrive
rclone mount msod:/ --daemon /home/simen/Cloud/OneDrive/ &
# Dropbox
#rclone mount drbo:/ --daemon /home/simen/Cloud/Dropbox/ &
# Google Drive
#rclone mount gldr:/ --daemon /home/simen/Cloud/GDrive/ &

# ---Start DWM---
while true; do
    # Log stderror to a file
    dwm 2> ~/.cache/dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
