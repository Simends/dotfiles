#!/bin/sh

MenuOpts="$1"
MenuProg="dmenu $MenuOpts"
Terminal="$2"
Browser="$3"

SelWm() {
    WmOpts="Stop compositor\nStart compositor"
    WmMenu=$(echo -e "$WmOpts" | $MenuProg)
    case "$WmMenu" in
        "Stop compositor")
            svctl down picom
            ;;
        "Start compositor")
            svctl up picom
            ;;
    esac
}

SelVm() {
    VmOpts="Start virtual machine\nStop virtual machine\nManager"
    VmMenu=$(echo -e "$VmOpts" | $MenuProg)
    case "$VmMenu" in
        "Start virtual machine")
            sudo virsh list --inactive --name | sed '/^$/d' | $MenuProg | xargs sudo virsh start
            ;;
        "Stop virtual machine")
            sudo virsh list --name | sed '/^$/d' | $MenuProg | xargs sudo virsh shutdown
            ;;
        "Manager")
            virt-manager
            ;;
    esac
}

ToggleDPMS() {
    dpmstat=$(xset q | grep -oP "(?<=DPMS is )\w*$")
    if [ "${dpmstat}" == "Enabled" ]; then
        xset s off -dpms
    else
        xset s on +dpms
    fi
}

SettingsOpts="System Info\nToggle Screensaver\nTask Manager\nSound\nNetwork\nDisplay\nDisks\nVirtual Machines\nDisk Usage\nChange Wallpaper\nChange Theme\nCompositor\nShow Fonts"
SettingsMenu=$(echo -e "$SettingsOpts" | $MenuProg)
case "$SettingsMenu" in
    "System Info")
        cpu-x
        ;;
    "Toggle Screensaver")
        ToggleDPMS
        ;;
    "Task Manager")
        $Terminal btop
        ;;
    "Sound")
        pavucontrol
        ;;
    "Network")
        connman-gtk
        ;;
    "Display")
        arandr
        ;;
    "Disks")
        gparted
        ;;
    "Virtual Machines")
        SelVm
        ;;
    "Disk Usage")
        $Terminal ncdu -x --exclude-kernfs /
        ;;
    "Change Wallpaper")
        setwp
        ;;
    "Change Theme")
        lxappearance
        ;;
    "Compositor")
        SelWm
        ;;
    "Show Fonts")
        fntnme=$(fc-list | awk '{$1=""; print $0}' | $MenuProg)
        fntpth=$(fc-list | grep "$fntnme" | sed '1!d' | awk '{print $1}' | sed 's/://g')
        display "$fntpth"
        ;;
esac
