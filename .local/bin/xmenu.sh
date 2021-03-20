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
	IMG:/usr/share/icons/hicolor/48x48/apps/firefox.png	Web browser	firefox
	IMG:/usr/share/icons/hicolor/48x48/apps/qutebrowser.png	Qutebrowser	qutebrowser
	IMG:/home/simen/.local/share/icons/Papirus/discord.png	Discord	discord
	IMG:/home/simen/.local/share/icons/Papirus/slack.png	Slack	slack
	IMG:/home/simen/.local/share/icons/Papirus/teams.png	Microsoft Teams	teams
	IMG:/home/simen/.local/share/icons/Papirus/zoom.png	Zoom	zoom
 Productivity
	IMG:/usr/share/icons/hicolor/48x48/apps/onlyoffice-desktopeditors.png	Office	onlyoffice-desktopeditors
	IMG:/usr/share/icons/hicolor/48x48/apps/emacs.png	Emacs	emacsclient -c
	IMG:/home/simen/.local/share/icons/Papirus/evince.png	Pdf reader	evince
	IMG:/usr/share/icons/hicolor/48x48/apps/calibre-gui.png	Calibre	calibre
	IMG:/home/simen/.local/share/icons/Papirus/anki.png	Anki	anki
	IMG:/usr/share/icons/hicolor/48x48/apps/octave.png	GNU Octave	octave --gui
	IMG:/home/simen/.local/share/icons/Papirus/arduino.png	Arduino	arduino
	IMG:/home/simen/.local/share/icons/Papirus/kicad.png	KiCAD	kicad
 Multimedia
	IMG:/usr/share/icons/hicolor/48x48/apps/spotify.png	Spotify	spotify
	IMG:/home/simen/.local/share/icons/hicolor/48x48/apps/appimagekit-pocket-casts-linux.png	Pocket Casts	/home/simen/.local/bin/Appimages/pocket-casts.AppImage
	IMG:/usr/share/icons/hicolor/48x48/apps/vlc.png	Vlc	vlc
	IMG:/home/simen/.local/share/icons/Papirus/sxiv.png	Sxiv	sxiv -rt ~/Multimedia/Pictures
	IMG:/usr/share/icons/hicolor/48x48/apps/darktable.png	Darktable	darktable
	IMG:/usr/share/icons/hicolor/48x48/apps/krita.png	Krita	krita
	IMG:/home/simen/.local/share/icons/Papirus/inkscape.png	Inkscape	inkscape
	IMG:/home/simen/.local/share/icons/Papirus/kdenlive.png	Kdenlive	kdenlive
 Games
	IMG:/usr/share/icons/hicolor/48x48/apps/steam.png	Steam	steam
	IMG:/usr/share/icons/hicolor/48x48/apps/lutris.png	Lutris	lutris
	IMG:/usr/share/icons/hicolor/48x48/apps/itch.png	Itch.io	itch
	IMG:/home/simen/.local/share/icons/Papirus/minecraft.png	Minecraft	multimc
	IMG:/home/simen/.local/share/icons/Papirus/godot.png	Godot Engine	godot
 Utilities
	IMG:/home/simen/.local/share/icons/Papirus/files.png	Files	nautilus
	IMG:/home/simen/.local/share/icons/Papirus/terminal.png	Terminal	st
	IMG:/home/simen/.local/share/icons/Papirus/accessories-calculator.png	Calculator	gnome-calculator
	IMG:/usr/share/icons/hicolor/48x48/apps/qbittorrent.png	Torrent	qbittorrent
	IMG:/usr/share/icons/hicolor/48x48/apps/virt-manager.png	Virtual Machine	virt-manager
 Settings
	IMG:/home/simen/.local/share/icons/Papirus/display.png	Display	arandr
	IMG:/home/simen/.local/share/icons/Papirus/network-wired.png	Network	connman-gtk
	IMG:/home/simen/.local/share/icons/Papirus/drive-harddisk.png	Disk	gparted
	IMG:/home/simen/.local/share/icons/Papirus/audio-speaker-left-side-testing.png	Sound	pavucontrol
	IMG:/home/simen/.local/share/icons/Papirus/colors.png	Appearance	lxappearance
	IMG:/usr/share/icons/hicolor/48x48/apps/timeshift.png	Timeshift	timeshift-launcher
	IMG:/home/simen/.local/share/icons/Papirus/corectrl.png	CoreCtrl	corectrl



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
