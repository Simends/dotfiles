#!/bin/sh

#  __  __
#  \ \/ /_ __ ___   ___ _ __  _   _
#   \  /| '_ ` _ \ / _ \ '_ \| | | |
#   /  \| | | | | |  __/ | | | |_| |
#  /_/\_\_| |_| |_|\___|_| |_|\__,_|
#

# SET NOEXPANDTAB!!!!

cat <<EOF | xmenu | sh &


 Communication
	IMG:/usr/share/icons/hicolor/48x48/apps/firefox.png	Web browser	firefox
	IMG:/usr/share/icons/hicolor/48x48/apps/qutebrowser.png	Qutebrowser	qutebrowser
	Discord	discord
	Slack	slack
	Microsoft Teams	teams
	Zoom	zoom
 Productivity
	IMG:/usr/share/icons/hicolor/48x48/apps/onlyoffice-desktopeditors.png	Office	onlyoffice-desktopeditors
	IMG:/usr/share/icons/hicolor/48x48/apps/emacs.png	Emacs	emacsclient -c
	IMG:/usr/share/icons/hicolor/48x48/apps/calibre-gui.png	Calibre	calibre
	Anki	anki
	IMG:/usr/share/icons/hicolor/48x48/apps/octave.png	GNU Octave	octave --gui
 Multimedia
	IMG:/usr/share/icons/hicolor/48x48/apps/spotify.png	Spotify	spotify
	IMG:/home/simen/.local/share/icons/hicolor/48x48/apps/appimagekit-pocket-casts-linux.png	Pocket Casts	/home/simen/.local/bin/Appimages/pocket-casts.AppImage
	IMG:/usr/share/icons/hicolor/48x48/apps/vlc.png	Vlc	vlc
	IMG:/usr/share/icons/hicolor/48x48/apps/darktable.png	Darktable	darktable
	IMG:/usr/share/icons/hicolor/48x48/apps/krita.png	Krita	krita
 Games
	IMG:/usr/share/icons/hicolor/48x48/apps/steam.png	Steam	steam
	IMG:/usr/share/icons/hicolor/48x48/apps/lutris.png	Lutris	lutris
	IMG:/usr/share/icons/hicolor/48x48/apps/itch.png	Itch.io	itch
	Minecraft	multimc
	Godot Engine	godot
 Utilities
	Files	nemo
	Terminal	kitty
	IMG:/usr/share/icons/hicolor/48x48/apps/qbittorrent.png	Torrent	qbittorrent
	IMG:/usr/share/icons/hicolor/48x48/apps/virt-manager.png	Virtual Machine	virt-manager
	IMG:/usr/share/icons/hicolor/48x48/apps/timeshift.png	Timeshift	timeshift-launcher
	CoreCtrl	corectrl



Lock	/home/simen/.local/bin/lock.sh
Log out	killall xinit
Shutdown		loginctl poweroff
Reboot			loginctl reboot


EOF
