#!/usr/bin/env bash

case "$(printf "Lock\\nLog out\\nReboot\\nShutdown" | dmenu -p "Powermenu:")" in
    "Lock") ~/.local/bin/lock.sh ;;
    "Log out") loginctl kill-user simen ;;
    "Reboot") loginctl reboot ;;
    "Shutdown") loginctl poweroff ;;
esac
