#!/bin/sh

seperator=" | "
delay="1s"

while true; do
    # Date
    dteicon=" "
	dteval=$(date +'%a %d/%m/%Y %H:%M')
    dte="${dteicon}${dteval}"

    # Memory usage
    memicon=" "
	memval=$(free -h --si | grep Mem | awk '{print $3}')
    mem="${memicon}${memval}${seperator}"

    # CPU Temp
    tmpicon=" "
	tmpval=$(cat /sys/class/thermal/thermal_zone2/temp | sed 's|$| / 1000|' | bc)
    tmp="${tmpicon}${tmpval}°C${seperator}"

    # Do not disturb
    dndicon=""
    dndeval=$(dunstctl is-paused)
    if [ "${dndeval}" == "false" ]; then
        dnd=""
    else
        dnd="${dndicon}${seperator}"
    fi

    # MPRIS
    mpricon=$(playerctl -f '{{emoji(status)}}' status || echo "")
    if [ "${mpricon}" ];then
        mprartist=$(playerctl metadata artist)
        mprsong=$(playerctl metadata title)
        mpr="${mpricon} ${mprartist}: ${mprsong}${seperator}"
    else
        mpr=""
    fi

    # TODO: Audio

    # TODO: Battery

    # TODO: Net

	xsetroot -name " ${dnd}${mpr}${tmp}${mem}${dte} "
	sleep "${delay}"
done
