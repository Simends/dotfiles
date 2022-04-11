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

SelKb() {
  KbMenu=$(echo -e "Norwegian Colemak-DHm\nOther" | $MenuProg)
  case "$KbMenu" in
    "Norwegian Colemak-DHm")
      setxkbmap -layout no -variant cmk_ed_ks -option lv5:caps_switch_lock,misc:extend,misc:cmk_curl_dh
      ;;
    "Other")
      SelKbLayout
      ;;
  esac
}

SelKbLayout() {
  KbList="/usr/share/X11/xkb/rules/base.lst"
  KbLayout=$(cat "$KbList" \
    | awk '/! layout/,/! variant/&&++c' \
    | sed '/^!.*/d' | sed '/^$/d' \
    | sed 's/^ *//' \
    | $MenuProg \
    | cut -d' ' -f1)

  if [ "$KbLayout" == "" ]; then
    exit
  fi
  KbVariant=$(cat "$KbList" \
    | grep "$KbLayout: " \
    | sed 's/^ *//' \
    | $MenuProg \
    | cut -d' ' -f1)

  if [ "$KbVariant" != "" ]; then
    if [ -f "/usr/bin/setxkb.sh" ]; then
      setxkbmap -layout "$KbLayout" -variant "$KbVariant" -option lv5:caps_switch_lock,misc:extend
    else
      setxkbmap -layout "$KbLayout" -variant "$KbVariant"
    fi
  else
    setxkbmap "$KbLayout"
  fi
}

ToggleDPMS() {
  dpmstat=$(xset q | grep -oP "(?<=DPMS is )\w*$")
  if [ "${dpmstat}" == "Enabled" ]; then
    xset s off -dpms
  else
    xset s on +dpms
  fi
}

SettingsOpts="System Info\nToggle Screensaver\nTask Manager\nSound\nNetwork\nDisplay\nDisks\nVirtual Machines\nDisk Usage\nChange Keymap\nChange Wallpaper\nChange Theme\nCompositor\nShow Fonts"
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
