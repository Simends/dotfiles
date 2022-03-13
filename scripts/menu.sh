#!/bin/sh

#
# A script to work as a general system menu
#

MenuOpts="-i -p Menu $@"
MenuProg="dmenu $MenuOpts"
MenuPath="$HOME/.local/dotfiles/scripts"
Terminal="st -e"
Browser="$BROWSER"

SelPower() {
    PowerOpts="Lock\nLog Out\nReboot\nShutdown\nReboot to UEFI Menu\nReboot to something else"
    PowerMenu=$(echo -e "$PowerOpts" | $MenuProg)
    case "$PowerMenu" in
        "Lock")
            slock
            ;;
        "Log Out")
            loginctl kill-user $(whoami)
            ;;
        "Reboot")
            loginctl reboot
            ;;
        "Shutdown")
            loginctl poweroff
            ;;
        "Reboot to UEFI Menu")
            loginctl reboot --firmware-setup
            ;;
        "Reboot to something else")
            efibootmgr | tail -n +4 | $MenuProg | grep -Po "(?<=Boot)\w{4}" | xargs sudo efibootmgr -n && loginctl reboot
            ;;
    esac
}

MainMenu=$(echo -e "Applications\nDirectory\nMedia Player\nWeb\nScreenshot\nPasswords\nSSH Sessions\nManuals\nDeadbeef\nToggle Do Not Disturb\nSystray\nSettings\nPower" | $MenuProg)
case "$MainMenu" in
    "Applications")
        "$MenuPath/dmenu-apps.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Directory")
        awk -F "|" '{print $2 " " $1}' "$XDG_DATA_HOME/z" | sort -nr | cut -d" " -f2 | $MenuProg | xargs -r st -d
        ;;
    "Media Player")
        "$MenuPath/dmenu-media.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Web")
        "$MenuPath/dmenu-web.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Screenshot")
        "$MenuPath/dmenu-screenshot.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Passwords")
        "$MenuPath/dmenu-passwords.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "SSH Sessions")
        SshSessions="KissVM: simen@192.168.122.149\nAlpine Linux: simen@192.168.122.180"
        echo -e "$SshSessions" | $MenuProg | awk '{print $NF}' | xargs -r $Terminal ssh
        ;;
    "Manuals")
        man -k . | $MenuProg | awk '{print $2 " " $1}' | tr -d "()" | xargs -r man -Tpdf | zathura -
        ;;
    "Deadbeef")
        find "${HOME}/Multimedia/Music" -type f | $MenuProg | xargs -I{} deadbeef --queue '{}'
        ;;
    "Systray")
        killall trayer
        trayer --width 25
        ;;
    "Toggle Do Not Disturb")
        dunstctl set-paused toggle
        ;;
    "Settings")
        "$MenuPath/dmenu-settings.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Power")
        SelPower
        ;;
esac
