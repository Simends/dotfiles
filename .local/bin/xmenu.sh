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
	Qutebrowser	qutebrowser
	Discord	discord
	Slack	slack
	Microsoft Teams	teams
	Zoom	zoom
Productivity
	Office	onlyoffice-desktopeditors
	PDF Viewer	evince
	Emacs	emacsclient -c
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
	Terminal	kitty
	Torrent	qbittorrent
	Virtual Machine	virt-manager
	Timeshift	timeshift-launcher
	Wine	playonlinux


Lock	/home/simen/.local/bin/lock.sh
Log out	killall xinit
Shutdown		loginctl poweroff
Reboot			loginctl reboot
EOF
