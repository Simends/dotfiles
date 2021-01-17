#!/bin/sh

# SET NOEXPANDTAB!!!!

cat <<EOF | xmenu | sh &
Communication
	Web browser	firefox
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
	Pocket Casts	/home/simen/Programs/Appimages/pocket-casts-linux-1.2.1-x86_64.AppImage
	Vlc	vlc
	Stremio	stremio
	Audacity	audacity
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


Lock	/home/simen/Programs/Scripts/lock.sh
Shutdown		poweroff
Reboot			reboot
EOF
