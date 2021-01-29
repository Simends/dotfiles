#! /bin/bash
# Change Dwm status bar

dte(){
	# Show date and time
	dte="$(date +"%A, %B %d - %H:%M")"
	echo -e "\x05 $dte"
}

upd(){
	# Check for updates
	upd=`checkupdates | wc -l`
	echo -e "\x03 $upd Updates\x01"
}

mem(){
	# Show used and available memory
	mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
	echo -e "\x04 $mem\x01"
}

tmp(){
	# Show CPU thermals
	tmp=`sensors | awk '/^Core 0:/ {print $3}'`
	echo -e "\x06 Cpu: $tmp\x01"
}

while true; do
	xsetroot -name "$(upd) | $(tmp) | $(mem) | $(dte)  "
	sleep 10s	# Update every 10s
done &
