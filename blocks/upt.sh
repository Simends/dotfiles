#!/bin/sh

printf -- '%s\n' "upt|string|0:0"
printf -- '%s\n' ""

while true; do
    interval="1m"
    utime="$(uptime | awk '{print $3}' | sed 's/,//')"
    printf -- '%s\n' "upt|string|${utime}"
    printf -- '%s\n' ""

    sleep "${interval}"

done
