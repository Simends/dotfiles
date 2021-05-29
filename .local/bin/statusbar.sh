#! /bin/bash
# Change Dwm status bar

dte(){
	# Show date and time
	dte="$(date +"%a, %b %d - %H:%M")"
	echo -e "\x05  $dte"
}

upd(){
	# Check for updates
	upd=`checkupdates | wc -l`
	echo -e "\x03  $upd Updates \x01"
}

mem(){
	# Show used and available memory
	mem=`free | awk '/Mem/ {printf "%d MiB\n", $3 / 1024.0 }'`
	echo -e "\x04  $mem \x01"
}

tmp(){
	# Show CPU thermals
	tmp=`sensors | awk '/^Core 0:/ {print $3}'`
	echo -e "\x06  $tmp \x01"
}

#cna(){
#	# Show latest coronainfo in Trondheim
#	cna=`cat /home/simen/.local/bin/Coronatracker/latestcoronanum.txt`
#	echo -e "\x07 $cna New\x01"
#}

fnc(){
	# Show latest price of Oslo stock exchange
    osebx=`curl -s https://finance.yahoo.com/quote/OSEBX.OL\?p\=OSEBX.OL\&.tsrc\=fin-srch | sed 's/,/\n/g' | sed 's/</\n/g' | grep 'data-reactid="33"' | sed -n 3p | sed 's/.*>//'`
	echo -e "\x07  $osebx \x01"
}

while true; do
	xsetroot -name "$(fnc)~$(upd)~$(mem)~$(tmp)~$(dte)"
	sleep 10s	# Update every 10s
done &
