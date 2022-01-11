#!/bin/sh

# ICONn=" " # icon for normal temperatures
# ICONc=" " # icon for critical temperatures
# 
# crit=70 # critical temperature
# 
# read -r temp </sys/class/thermal/thermal_zone2/temp
# temp=${temp%???}
# 
# if [ "$temp" -lt "$crit" ] ; then
#     printf "\x0e$ICONn$temp°C\x0b"
# else
#     printf "\x0c$ICONc$temp°C\x0b"
# fi

declare interval temp

# Error message in STDERR
_err() {
  printf -- '%s\n' "[$(date +'%Y-%m-%d %H:%M:%S')]: $*" >&2
}

# Display tags before yambar fetch the updates number
printf -- '%s\n' "cpu|int|0"
printf -- '%s\n' ""


while true; do
  # Change interval
  # NUMBER[SUFFIXE]
  # Possible suffix:
  #  "s" seconds / "m" minutes / "h" hours / "d" days 
  interval="3s"

  read -r temp </sys/class/thermal/thermal_zone2/temp
  temp=${temp%???}
  
  printf -- '%s\n' "cpu|int|${temp}"
  printf -- '%s\n' ""

  sleep "${interval}"

done

unset -v interval temp
unset -f _err
