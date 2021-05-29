#!/bin/sh
ICON=" "
wtr="$(curl -s 'wttr.in/?format=%t')"
printf "\x0d$ICON$wtr\x0b"
