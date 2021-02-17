#!/bin/bash

sessiondir="$XDG_CONFIG_HOME/X11/Sessions"

sessions=$(find $sessiondir -regex .\*-xinit | sed 's/-xinit//g' | sed "s+$sessiondir/++g")
sessionsel=$(echo "$sessions" | smenu -l -N -M -d -m "Pick Session")
selfile=$(find $sessiondir -regex .\*$sessionsel"-xinit")
exec startx "$selfile"
