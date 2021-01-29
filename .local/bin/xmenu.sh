#!/bin/sh

#  __  __
#  \ \/ /_ __ ___   ___ _ __  _   _
#   \  /| '_ ` _ \ / _ \ '_ \| | | |
#   /  \| | | | | |  __/ | | | |_| |
#  /_/\_\_| |_| |_|\___|_| |_|\__,_|
#

# SET NOEXPANDTAB!!!!

cat <<EOF | xmenu | sh &
Communication
	Web browser	firefox
	Surf	surf
	Discord	discord
	Slack	slack
Productivity
	Office	onlyoffice-desktopeditors
	PDF Viewer	evince
	Emacs	emacs
	Calibre	calibre
	Anki	anki
	GNU Octave	octave --gui
	Gramps	gramps
Multimedia
	Spotify	spotify
	Pocket Casts	/home/simen/.local/bin/Appimages/pocket-casts-linux-1.2.1-x86_64.AppImage
	Vlc	vlc
	Stremio	stremio
	Darktable	darktable
	Krita	krita
Games
	Steam	steam
	Lutris	lutris
	Itch.io	itch
	Minecraft	multimc
	Godot Engine	godot
Utilities
	Files	nemo
	Terminal	st
	Torrent	qbittorrent
	Virtual Machine	virt-manager
	Timeshift	timeshift-launcher


Lock	/home/simen/.local/bin/lock.sh
Log out	killall xinit
Shutdown		loginctl poweroff
Reboot			loginctl reboot
EOF
