#!/usr/bin/env bash

sessiondir="$XDG_CONFIG_HOME/X11/Sessions"
echo ""
# sessions=$(find $sessiondir -type f | sed 's/-xinit//g' | sed "s+$sessiondir/++g")
# sessionsel=$(echo "$sessions" | smenu -l -N -d -m "Pick Session")
# echo "$sessionsel"
# selfile=$(ls $sessiondir | grep "$sessionsel")
# selfile="$sessiondir/$selfile"
# echo "$selfile"
# Check if session is x11
sessionsel=$(ls $sessiondir | smenu -l -N -d -m "Pick Session")
sessionsel="$sessiondir/$sessionsel"
echo "$sessionsel"
isx=$(echo $sessionsel | grep "xinit")
echo "$isx"
if [ -n "$isx" ]; then
   exec startx "$sessionsel"
else
   exec $sessionsel
fi
