#!/bin/sh

#  __  __
#  \ \/ /_ __ ___   ___ _ __  _   _
#   \  /| '_ ` _ \ / _ \ '_ \| | | |
#   /  \| | | | | |  __/ | | | |_| |
#  /_/\_\_| |_| |_|\___|_| |_|\__,_|
#

# SET NOEXPANDTAB!!!!

cat <<EOF | xmenu "$1" | sh &


 Communication
	Web browser	firefox
	Qutebrowser	firejail --env=LD_PRELOAD='/usr/lib/libhardened_malloc.so' /usr/bin/qutebrowser
	Discord	firejail discord
	Slack	slack
	Microsoft Teams	teams
	Zoom	zoom
 Productivity
	Office	onlyoffice-desktopeditors
	Emacs	emacsclient -c
	Pdf reader	evince
	Calibre	calibre
	Anki	anki
	GNU Octave	octave --gui
	Arduino	arduino
	KiCAD	kicad
 Multimedia
	Spotify	firejail spotify
	Pocket Casts	firejail --appimage /home/simen/.local/bin/Appimages/pocket-casts.AppImage
	Vlc	vlc
	Sxiv	sxiv -rt ~/Multimedia/Pictures
	Darktable	darktable
	Krita	krita
	Inkscape	inkscape
	Kdenlive	kdenlive
 Games
	Steam	steam
	Lutris	lutris
	Itch.io	itch
	multimc
	Godot Engine	godot
 Utilities
	Files	nautilus
	Terminal	st
	Calculator	gnome-calculator
	Torrent	qbittorrent
	Virtual Machine	virt-manager
 Settings
	Display	arandr
	Network	connman-gtk
	Disk	gparted
	Sound	pavucontrol
	Appearance	lxappearance
	Timeshift	timeshift-launcher
	CoreCtrl	corectrl



Spotify
	Play/Pause	playerctl play-pause
	Stop	playerctl stop
	Previous	playerctl previous
	Next	playerctl next
Moc
	Play/Pause	mocp -O MOCDir=/home/sig/moc --toggle-pause
	Previous	mocp -O MOCDir=/home/sig/moc --previous
	Next	mocp -O MOCDir=/home/sig/moc --next



Lock	slock
Log out	loginctl kill-user simen
Shutdown		loginctl poweroff
Reboot			loginctl reboot
Suspend	loginctl suspend


EOF
