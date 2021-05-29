#!/bin/sh
ICON=" "
finance="$(curl -s https://finance.yahoo.com/quote/OSEBX.OL\?p\=OSEBX.OL\&.tsrc\=fin-srch | grep -oE '[(][+|-|0]\S{3,4}[%][)]' | sed 's/\([(|)]\)//g')"
printf "\x10$ICON%s\x0b" "$finance"
