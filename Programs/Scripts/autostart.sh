#! /bin/bash

# Set wallpaper
feh --bg-fill --no-fehbg --randomize ~/Multimedia/Pictures/Wallpapers/* &

# Start compositor
picom --config ~/.config/picom.conf &

# Mount the clouds
rclone mount msod:/ --daemon /home/simen/Cloud/OneDrive/ &
rclone mount drbo:/ --daemon /home/simen/Cloud/Dropbox/ &
rclone mount gldr:/ --daemon /home/simen/Cloud/GDrive/ &

# Start the clipboard deamon
clipmenud &

# Change Dwm status bar
dte(){
	dte="$(date +"%A, %B %d - %H:%M")"
	echo -e "\x05$dte"
}

upd(){
	upd=`checkupdates | wc -l`
	echo -e "\x03$upd Updates\x01"
}

mem(){
	mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
	echo -e "\x04$mem\x01"
}

while true; do
	xsetroot -name "$(upd) | $(mem) | $(dte)  "
	sleep 10s	# Update every 10s
done &
