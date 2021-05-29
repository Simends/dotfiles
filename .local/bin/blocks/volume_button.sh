#!/bin/sh
case $1 in
    1) pactl set-sink-mute @DEFAULT_SINK@ toggle && notify-send Mute "Toggled mute" ;;
    3) pavucontrol ;;
esac
