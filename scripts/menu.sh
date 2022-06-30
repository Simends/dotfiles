#!/bin/sh

#
# A script to work as a general system menu
#

MenuOpts="-i -p Menu $@"
MenuProg="dmenu $MenuOpts"
MenuPath="$HOME/.local/dotfiles/scripts"
Terminal="st -e"
Browser="qutebrowser"
Bookmarkdir="$HOME/Documents/notatsys/bokmerker/web"

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
            efibootmgr \
                | tail -n +4 \
                | $MenuProg \
                | grep -Po "(?<=Boot)\w{4}" \
                | xargs sudo efibootmgr -n \
                && sudo reboot
            ;;
    esac
}

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

WebSearch() {
    SearchEngines="Ducduckgo: duckduckgo.com/?q=
Wikipedia (NO): no.wikipedia.org/w/index.php?search=
Wikipedia (EN): en.wikipedia.org/w/index.php?search=
Store Norske Leksikon: snl.no/
Arch Linux Wiki: wiki.archlinux.org/index.php?search=
Arch Linux Packages: archlinux.org/packages/?sort=&q=
Arch Linux AUR: aur.archlinux.org/packages/?O=0&K=
Norske Akademikers Ordbok: naob.no/søk/
Gentoo Linux Wiki: wiki.gentoo.org/index.php?Search&search=
Distrowatch: distrowatch.com/table.php?distribution=
Github: github.com/search?q=
Sourcehut: sr.ht/projects?search=
Youtube: youtube.com/results?search_query=
Standard Ebooks: standardebooks.org/ebooks?query=
Z-Library: 1lib.sk/s/"

    SelEngine=$(echo -e "$SearchEngines" | $MenuProg | awk '{print $NF}')
    if [ "$SelEngine" == "" ]; then
        exit
    fi
    SearchTerm=$(echo "" | $MenuProg)
    $Browser "https://$SelEngine$SearchTerm"
}

WebBookmarks() {
    cat $Bookmarkdir/* | $MenuProg -l 20 | awk '{print $NF}' | xargs $Browser
}

MainMenu=$(echo -e "Applications\
\nDirectory\
\nMedia Player\
\nWeb Search\
\nWeb Bookmarks\
\nScreenshot\
\nPasswords\
\nSSH Sessions\
\nManuals\
\nToggle Do Not Disturb\
\nCopy Emoji\
\nSystray\
\nLutris\
\nOpen Lutris\
\nSteam\
\nMinecraft\
\nEmail\
\nNewsfeed\
\nFirefox\
\nQutebrowser\
\nNetsurf\
\nDiscord\
\nMicrosoft Teams\
\nMusic Player\
\nSpotify\
\nYoutube Playlists\
\nlofi hip hop radio - beats to relax/study to\
\nLibreoffice\
\nGnu Radio\
\nGnu Cash\
\nDarktable\
\nArdour\
\nKrita\
\nTerminal\
\nCheat.sh\
\nFile Manager\
\nView Images\
\nOpen Document\
\nSystem Info\
\nToggle Screensaver\
\nSet keymap norwegian qwerty\
\nSet keymap us qwerty\
\nSet keymap norwegian colemak-dh\
\nTask Manager\
\nSound Settings\
\nNetwork Settings\
\nDisplay Settings\
\nDisks Settings\
\nVirtual Machines\
\nDisk Usage\
\nChange Wallpaper\
\nTheme Settings\
\nCompositor\
\nShow Fonts\
\nAll Settings\
\nPower" | $MenuProg)
case "$MainMenu" in
    "Applications")
        dmenu_run $MenuOpts
        ;;
    "Directory")
        awk -F "|" '{print $2 " " $1}' "$XDG_DATA_HOME/z" \
            | sort -nr \
            | cut -d" " -f2 \
            | $MenuProg \
            | xargs -r st -d
        ;;
    "Media Player")
        "$MenuPath/dmenu-media.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Web Search")
        WebSearch
        ;;
    "Web Bookmarks")
        WebBookmarks
        ;;
    "Screenshot")
        "$MenuPath/dmenu-screenshot.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "Passwords")
        "$MenuPath/dmenu-passwords.sh" "$MenuOpts" "$Terminal" "$Browser"
        ;;
    "SSH Sessions")
        SshSessions="KissVM: simen@192.168.122.149\nAlpine Linux: simen@192.168.122.180"
        echo -e "$SshSessions" \
            | $MenuProg \
            | awk '{print $NF}' \
            | xargs -r $Terminal ssh
        ;;
    "Manuals")
        man -k . \
            | $MenuProg \
            | awk '{print $2 " " $1}' \
            | tr -d "()" \
            | xargs -r man -Tpdf \
            | zathura -
        ;;
    "Systray")
        killall trayer
        trayer --width 25
        ;;
    "Toggle Do Not Disturb")
        dunstctl set-paused toggle
        ;;
    "Copy Emoji")
        "$MenuPath/dmenu-unicode.sh" "$MenuOpts"
        ;;
    "Lutris")
        SelGame=$(lutris -l | $MenuProg | awk '{print $1}')
        lutris "lutris:rungameid/$SelGame"
        ;;
    "Open Lutris")
        lutris
        ;;
    "Steam")
        steam
        ;;
    "Minecraft")
        multimc
        ;;
    "Email")
        $Terminal neomutt
        ;;
    "Newsfeed")
        $Terminal rss
        ;;
    "Firefox")
        firefox
        ;;
    "Qutebrowser")
        qutebrowser
        ;;
    "Netsurf")
        netsurf
        ;;
    "Discord")
        discord
        ;;
    "Microsoft Teams")
        teams
        ;;
    "Music Player")
        strawberry
        ;;
    "Spotify")
        spotify
        ;;
    "Youtube Playlists")
        ls "$(xdg-user-dir VIDEOS)/YouTube" \
            | $MenuProg \
            | sed "s|^|$(xdg-user-dir VIDEOS)/YouTube/|" \
            | xargs -r cat \
            | $MenuProg \
            | cut -d" " -f1 \
            | sed 's|^|https://www.youtube.com/watch?v=|' \
            | xargs -r mpv
        ;;
    "lofi hip hop radio - beats to relax/study to")
        mpv "https://www.youtube.com/watch?v=5qap5aO4i9A"
        ;;
    "Libreoffice")
        libreoffice
        ;;
    "Gnu Radio")
        gnuradio-companion
        ;;
    "Gnu Cash")
        gnucash
        ;;
    "Darktable")
        darktable
        ;;
    "Ardour")
        pw-jack ardour6
        ;;
    "Krita")
        krita
        ;;
    "Terminal")
        $Terminal
        ;;
    "Cheat.sh")
        $Terminal fzcht
        ;;
    "File Manager")
        pcmanfm-qt
        ;;
    "View Images")
        SelImg=$(sxiv -r "$(xdg-user-dir PICTURES)")
        if ! [[ -z "$SelImg" ]]; then
            echo "$SelImg" | xclip && notify-send "Image Copied!" "$SelImg has been copied to clipboard"
        fi
        ;;
    "Open Document")
        SelDoc=$(find "$(xdg-user-dir DOCUMENTS)" -type f -name '*.pdf' | $MenuProg)
        xdg-open "$SelDoc"
        ;;
    "System Info")
        cpu-x
        ;;
    "Toggle Screensaver")
        ToggleDPMS
        ;;
    "Set keymap norwegian qwerty")
        setxkbmap no -option '' && \
          setxkbmap no -option 'misc:extend,lv5:caps_switch_lock'
        ;;
    "Set keymap us qwerty")
        setxkbmap us -option '' && \
          setxkbmap us -option 'misc:extend,lv5:caps_switch_lock'
        ;;
    "Set keymap norwegian colemak-dh")
        setxkbmap -model 'pc105' -layout 'no(cmk_ed_ks)' -option 'misc:extend,lv5:caps_switch_lock,grp:shifts_toggle,compose:menu,misc:cmk_curl_dh'
        ;;
    "Task Manager")
        $Terminal btop
        ;;
    "Sound Settings")
        pavucontrol
        ;;
    "Network Settings")
        connman-gtk
        ;;
    "Display Settings")
        arandr
        ;;
    "Disks Settings")
        sudo gparted
        ;;
    "Virtual Machines")
        SelVm
        ;;
    "Disk Usage")
        $Terminal ncdu -x --exclude-kernfs /
        ;;
    "Change Keymap")
        SelKb
        ;;
    "Change Wallpaper")
        setwp
        ;;
    "Theme Settings")
        lxqt-config-appearance
        ;;
    "Compositor")
        SelWm
        ;;
    "Show Fonts")
        fntnme=$(fc-list | awk '{$1=""; print $0}' | $MenuProg)
        fntpth=$(fc-list | grep "$fntnme" | sed '1!d' | awk '{print $1}' | sed 's/://g')
        display "$fntpth"
        ;;
    "All Settings")
        lxqt-config
        ;;
    "Power")
        SelPower
        ;;
esac
