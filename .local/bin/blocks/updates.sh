#!/bin/sh
ICON=" "
upd="$(checkupdates | wc -l)"
printf "\x0f$ICON$upd Updates\x0b"
