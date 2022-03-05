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
	tmpval=$(cat /sys/class/thermal/thermal_zone10/temp | sed 's|$| / 1000|' | bc)
    tmp="${tmpicon}${tmpval}°C${seperator}"

    # Net
    netstat=$(connmanctl state | grep -oP '(?<=State = )\w*$')
    if [ "$netstat" == "online" ] || [ "$netstat" == "ready" ]; then
        neticon=""
    else
        neticon=""
    fi
    net="${neticon}${seperator}"

    # Battery
    batdir="/sys/class/power_supply/BAT0"
    if [ -d "$batdir" ]; then
        baticon=" "
        batstaus=$(cat "$batdir/status")
        if [ "$batstaus" == "Charging" ]; then
            baticon=" "
        fi
        batcap=$(cat "$batdir/capacity")
        bat="${baticon}${batcap}%${seperator}"
    else
        bat=""
    fi

    # Backlight
    if [ -f /usr/bin/light ]; then
        balicon=" "
        balstat=$(light -G | sed 's/\..*$/%/')
        bal="${balicon}${balstat}${seperator}"
    else
        bal=""
    fi

    # Audio
    audstat=$(awk -F"[][]" '/Left:/ { print $4 }' <(amixer sget Master))
    if [ "${audstat}" == "off" ]; then
        audicon=""
        aud="${audicon}${seperator}"
    else
        audicon=" "
        audlvl=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
        aud="${audicon}${audlvl}${seperator}"
    fi

    # Mic
    micstat=$(awk -F"[][]" '/Left:/ { print $4 }' <(amixer sget Capture))
    if [ "${micstat}" == "off" ]; then
        micicon=""
        mic="${micicon}${seperator}"
    else
        mic=""
    fi

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

	xsetroot -name " ${mpr}${dnd}${mic}${aud}${bal}${bat}${net}${tmp}${mem}${dte} "
	sleep "${delay}"
done
