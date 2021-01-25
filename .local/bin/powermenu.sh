#!/usr/bin/env bash

case "$(printf "Lock\\nReboot\\nShutdown" | dmenu -p "Powermenu:")" in
    "Lock") ~/.local/bin/lock.sh ;;
    "Reboot") loginctl reboot ;;
    "Shutdown") loginctl poweroff ;;
esac
