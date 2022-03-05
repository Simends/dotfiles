#!/bin/sh

#
# A script to work as a general system menu
#

#MenuOpts="-iwl 20 \
#    -p Menu"

    # --fn SourceCodePro-Regular,10 \
    # --nb #1d2021 \
    # --nf #ebdbb2 \
    # --hb #cc241d \
    # --hf #282828 \
    # --tb #282828 \
    # --tf #cc241d \
    # --fb #282828 \
    # --ff #cc241d \
#MenuProg="bemenu $MenuOpts"
MenuOpts="-i -p Menu $@"
MenuProg="dmenu $MenuOpts"
MenuPath="$HOME/.local/dotfiles/scripts"
Terminal="st -e"
Browser="qutebrowser"

SelPower() {
    PowerOpts="Lock\nLog Out\nReboot\nShutdown\nReboot to UEFI Menu"
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
    esac
}

MainMenu=$(echo -e "Applications\nDirectory\nMedia Player\nWebsearch\nScreenshot\nPasswords\nSSH Sessions\nManuals\nDeadbeef\nToggle Do Not Disturb\nSystray\nSettings\nPower" | $MenuProg)
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
    "Websearch")
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