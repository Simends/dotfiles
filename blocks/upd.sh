#!/usr/bin/env bash
#
# pacman.sh - display number of packages update available
#             by default check every hour
#
# USAGE: pacman.sh
#
# TAGS:
#  Name      Type  Return
#  -------------------------------------------
#  {pkg}     int   sum of both
#
# Exemples configuration:
#  - script:
#      path: /absolute/path/to/pacman.sh
#      args: [] 
#      content: { string: { text: "{pacman} + {aur} = {pkg}" } }
#
# To display a message when there is no update:
#  - script:
#      path: /absolute/path/to/pacman.sh
#      args: [] 
#      content:
#        map:
#          tag: pkg
#          default: { string: { text: "{pacman} + {aur} = {pkg}" } }
#          values:
#            0: {string: {text: no updates}}

declare interval pkg_num

# Error message in STDERR
_err() {
  printf -- '%s\n' "[$(date +'%Y-%m-%d %H:%M:%S')]: $*" >&2
}

# Display tags before yambar fetch the updates number
printf -- '%s\n' "pkg|int|0"
printf -- '%s\n' ""

while true; do
  # Change interval
  # NUMBER[SUFFIXE]
  # Possible suffix:
  #  "s" seconds / "m" minutes / "h" hours / "d" days 
  interval="1h"
  
  # Get number of packages to update
  pkg_num=$(checkupdates | wc -l)

  printf -- '%s\n' "pkg|int|${pkg_num}"
  printf -- '%s\n' ""

  sleep "${interval}"
done

unset -v interval pkg_num
unset -f _err
