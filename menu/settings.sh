#!/bin/sh

MenuOpts="$1"
MenuProg="bemenu $MenuOpts"
Terminal="$2"
Browser="$3"

SelGtkTheme() {
    Themes=$(ls /usr/share/themes)
    Icons=$(ls /usr/share/icons)
    ThemeMenu=$(echo -e "Theme\nIcon\nCursor" | $MenuProg)
    case "$ThemeMenu" in
        "Theme")
            echo "$Themes" | $MenuProg | xargs -r gsettings set org.gnome.desktop.interface gtk-theme
            ;;
        "Icon")
            echo "$Icons" | $MenuProg | xargs -r gsettings set org.gnome.desktop.interface icon-theme
            ;;
        "Cursor")
            echo "$Icons" | $MenuProg | xargs -r gsettings set org.gnome.desktop.interface cursor-theme
            ;;
    esac
}

SelRiverLayoutNS() {
    case $(echo -e "Stacktile\nFloating" | $MenuProg) in
        "Stacktile")
            echo "stacktile"
            ;;
        "Floating")
            echo ""
            ;;
    esac
}

SelRiver() {
    RiverOpts="Set Layout Current Display\nSet Layout All\nSwitch Mode\nSet Border Width"
    RiverMenu=$(echo -e "$RiverOpts" | $MenuProg)
    case "$RiverMenu" in
        "Set Layout Current Display")
            riverctl output-layout "$(SelRiverLayoutNS)"
            ;;
        "Set Layout All")
            riverctl default-layout "$(SelRiverLayoutNS)"
            ;;
        "Switch Mode")
            SelMode=$(echo -e "Passthrough" | $MenuProg | tr '[:upper:]' '[:lower:]' )
            riverctl enter-mode "$SelMode"
            ;;
        "Set Border Width")
            SelWidth=$(echo "" | $MenuProg)
            riverctl border-width "$SelWidth"
            ;;
    esac
}

SettingsOpts="System Info\nTask Manager\nAudio\nNetwork\nDisplay\nDisks\nVirtual Machines\nDisk Usage\nChange Wallpaper\nChange Theme\nWindow Manager\nShow Fonts"
SettingsMenu=$(echo -e "$SettingsOpts" | $MenuProg)
case "$SettingsMenu" in
    "System Info")
        cpu-x
        ;;
    "Task Manager")
        $Terminal btop
        ;;
    "Audio")
        pavucontrol
        ;;
    "Network")
        connman-gtk
        ;;
    "Display")
        wdisplays
        ;;
    "Disks")
        gparted
        ;;
    "Virtual Machines")
        virt-manager
        ;;
    "Disk Usage")
        $Terminal ncdu -x --exclude-kernfs /
        ;;
    "Change Wallpaper")
        setwlwp
        ;;
    "Change Theme")
        SelGtkTheme
        ;;
    "Window Manager")
        SelRiver
        ;;
    "Show Fonts")
        fntnme=$(fc-list | awk '{$1=""; print $0}' | $MenuProg)
        fntpth=$(fc-list | grep "$fntnme" | sed '1!d' | awk '{print $1}' | sed 's/://g')
        display "$fntpth"
        ;;
esac
