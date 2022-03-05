#!/bin/sh

sel=$(grep -oP "(:|^|\s*)(\w|-|_|\d)*\(\d\)" | sed 's/ /\n/g' | sed 's/://g' | sed '/^[[:space:]]*$/d' | dmenu -l 10 -p Man)
section=$(echo $sel | grep -oe "(.*)" | sed 's/(//g' | sed 's/)//g' )
page=$(echo $sel | sed "s/^/$section /g" | sed 's/(.*)//g')
st -e man $page
