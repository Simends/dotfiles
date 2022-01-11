#!/bin/sh

#
# A script to work as a general system menu
#

MenuOpts="-iwl 20 \
    -p Menu"

    # --fn SourceCodePro-Regular,10 \
    # --nb #1d2021 \
    # --nf #ebdbb2 \
    # --hb #cc241d \
    # --hf #282828 \
    # --tb #282828 \
    # --tf #cc241d \
    # --fb #282828 \
    # --ff #cc241d \
MenuProg="bemenu $MenuOpts"
MenuPath="$HOME/.local/bin/menu"
Terminal="footclient"
Browser="qutebrowser"

SelPower() {
    PowerOpts="Lock\nLog Out\nReboot\nShutdown\nReboot to UEFI Menu"
    PowerMenu=$(echo -e "$PowerOpts" | $MenuProg)
    case "$PowerMenu" in
        "Lock")
            swaylock -l -s fill -c 000000
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

MainMenu=$(echo -e "Applications\nDirectory\nMedia Player\nWebsearch\nScreenshot\nPasswords\nSSH Sessions\nManuals\nSystray\nSettings\nPower" | $MenuProg)
case "$MainMenu" in
    "Applications")
        "$MenuPath/apps.sh" "$MenuOpts" "$Terminal" "$Browser"
    ;;
"Directory")
        awk -F "|" '{print $2 " " $1}' "$XDG_DATA_HOME/z" | sort -nr | cut -d" " -f2 | $MenuProg | xargs -r footclient -D
        ;;
    "Media Player")
        "$MenuPath/media.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Websearch")
        "$MenuPath/web.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Screenshot")
        "$MenuPath/screenshot.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Passwords")
        "$MenuPath/passwords.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "SSH Sessions")
        SshSessions="KissVM: simen@192.168.122.149\nAlpine Linux: simen@192.168.122.180"
        echo -e "$SshSessions" | $MenuProg | awk '{print $NF}' | xargs -r $Terminal ssh
        ;;
    "Manuals")
        man -k . | $MenuProg | awk '{print $2 " " $1}' | tr -d "()" | xargs -r man -Tpdf | zathura -
        ;;
    "Systray")
        killall trayer
        trayer --width 25
        ;;
    "Settings")
        "$MenuPath/settings.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Power")
        SelPower
        ;;
esac
