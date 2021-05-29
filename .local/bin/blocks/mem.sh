#!/bin/sh
ICON=" "
mem="$(free | awk '/Mem/ {printf "%d Mib\n", $3 / 1024.0}')"
printf "\x0c$ICON$mem\x0b"
