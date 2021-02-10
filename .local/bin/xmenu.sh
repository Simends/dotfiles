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
	IMG:/home/simen/.local/share/icons/Papirus/discord.png	Discord	discord
	IMG:/home/simen/.local/share/icons/Papirus/slack.png	Slack	slack
	IMG:/home/simen/.local/share/icons/Papirus/teams.png	Microsoft Teams	teams
	IMG:/home/simen/.local/share/icons/Papirus/zoom.png	Zoom	zoom
 Productivity
	IMG:/usr/share/icons/hicolor/48x48/apps/onlyoffice-desktopeditors.png	Office	onlyoffice-desktopeditors
	IMG:/usr/share/icons/hicolor/48x48/apps/emacs.png	Emacs	emacsclient -c
	IMG:/usr/share/icons/hicolor/48x48/apps/calibre-gui.png	Calibre	calibre
	IMG:/home/simen/.local/share/icons/Papirus/anki.png	Anki	anki
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
	IMG:/home/simen/.local/share/icons/Papirus/minecraft.png	Minecraft	multimc
	IMG:/home/simen/.local/share/icons/Papirus/godot.png	Godot Engine	godot
 Utilities
	IMG:/home/simen/.local/share/icons/Papirus/files.png	Files	kitty nnn -daoQH -P p
	IMG:/home/simen/.local/share/icons/Papirus/terminal.png	Terminal	kitty
	IMG:/usr/share/icons/hicolor/48x48/apps/qbittorrent.png	Torrent	qbittorrent
	IMG:/usr/share/icons/hicolor/48x48/apps/virt-manager.png	Virtual Machine	virt-manager
	IMG:/usr/share/icons/hicolor/48x48/apps/timeshift.png	Timeshift	timeshift-launcher
	IMG:/home/simen/.local/share/icons/Papirus/corectrl.png	CoreCtrl	corectrl



Lock	/home/simen/.local/bin/lock.sh
Log out	killall xinit
Shutdown		loginctl poweroff
Reboot			loginctl reboot


EOF
