#!/bin/sh

xmenu <<EOF | sh &
Applications
	Web Browser	firefox
	Image editor	gimp
Terminal		st

Shutdown		loginctl poweroff
Reboot			loginctl reboot
EOF
