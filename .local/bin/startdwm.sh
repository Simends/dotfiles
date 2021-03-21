#!/bin/sh
# Script to start dwm. Used by xinitrc

#---Start applications/daemons---

# Start redshift
redshift -c ~/.config/redshift/redshift.conf &

# Set wallpaper
setwp -d ~/.config/Rice/Palenight/wallpaper/lightsym.jpg &

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
