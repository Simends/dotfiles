#!/bin/sh
# ICON=" "
# mem="$(free | awk '/Mem/ {printf "%d Mib\n", $3 / 1024.0}')"
# printf "\x0c$ICON$mem\x0b"
declare interval mem

# Error message in STDERR
_err() {
  printf -- '%s\n' "[$(date +'%Y-%m-%d %H:%M:%S')]: $*" >&2
}

# Display tags before yambar fetch the updates number
printf -- '%s\n' "used|int|0"
printf -- '%s\n' ""


while true; do
  # Change interval
  # NUMBER[SUFFIXE]
  # Possible suffix:
  #  "s" seconds / "m" minutes / "h" hours / "d" days 
  interval="3s"

  mem="$(free | awk '/Mem/ {printf "%d", $3 / 1024.0}')"

  printf -- '%s\n' "used|int|${mem}"
  printf -- '%s\n' ""

  sleep "${interval}"

done

unset -v interval mem
unset -f _err
