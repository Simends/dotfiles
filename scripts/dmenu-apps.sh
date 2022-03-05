#!/bin/sh

MenuOpts="$1"
MenuProg="dmenu $MenuOpts"
Terminal="$2"
Browser="$3"

SelAppsGames() {
    AppGamesOpts="Lutris\nOpen Lutris\nSteam\nMinecraft"
    AppGamesMenu=$(echo -e "$AppGamesOpts" | $MenuProg)
    case "$AppGamesMenu" in
        "Lutris")
            SelGame=$(lutris -l | $MenuProg | awk '{print $1}')
            lutris "lutris:rungameid/$SelGame"
            ;;
        "Open Lutris")
            lutris
            ;;
        "Steam")
            steam
            ;;
        "Minecraft")
            multimc
            ;;
    esac
}

SelAppsNetwork() {
    AppNetworkOpts="Email\nNewsfeed\nFirefox\nQutebrowser\nNetsurf\nDiscord\nMicrosoft Teams"
    AppNetworkMenu=$(echo -e "$AppNetworkOpts" | $MenuProg)
    case "$AppNetworkMenu" in
        "Email")
            $Terminal neomutt
            ;;
        "Newsfeed")
            $Terminal rss
            ;;
        "Firefox")
            firefox
            ;;
        "Qutebrowser")
            qutebrowser
            ;;
        "Netsurf")
            netsurf
            ;;
        "Discord")
            discord
            ;;
        "Microsoft Teams")
            teams
            ;;
    esac
}

SelAppsMultimedia() {
    AppMultimediaOpts="Music Player\nMpv\nAni-cli\nSpotify\nYoutube Playlists\nlofi hip hop radio - beats to relax/study to"
    AppMultimediaMenu=$(echo -e "$AppMultimediaOpts" | $MenuProg)
    case "$AppMultimediaMenu" in
        "Music Player")
            deadbeef
            ;;
        "Mpv")
            mpv
            ;;
        "Ani-cli")
            $Terminal ani-cli -H
            ;;
        "Spotify")
            spotify
            ;;
        "Youtube Playlists")
            ls "$(xdg-user-dir VIDEOS)/YouTube" | $MenuProg | sed "s|^|$(xdg-user-dir VIDEOS)/YouTube/|" | xargs -r cat | $MenuProg | cut -d" " -f1 | sed 's|^|https://www.youtube.com/watch?v=|' | xargs -r mpv
            ;;
        "lofi hip hop radio - beats to relax/study to")
            mpv "https://www.youtube.com/watch?v=5qap5aO4i9A"
            ;;
    esac
}

SelAppsOffice() {
    AppOfficeOpts="Libreoffice\nGnu Radio\nGnu Cash\nDarktable\nArdour\nPinta"
    AppOfficeMenu=$(echo -e "$AppOfficeOpts" | $MenuProg)
    case "$AppNetworkMenu" in
        "Libreoffice")
            libreoffice
            ;;
        "Gnu Radio")
            gnuradio-companion
            ;;
        "Gnu Cash")
            gnucash
            ;;
        "Darktable")
            darktable
            ;;
        "Ardour")
            ardour6
            ;;
        "Pinta")
            pinta
            ;;
    esac
}

SelAppsDevel() {
    AppDevelOpts="Alternative Terminal\nNeovim\nTmux\nOctave-gui\nOctave\nPython\nLua\nHaskell"
    AppDevelMenu=$(echo -e "$AppDevelOpts" | $MenuProg)
    case "$AppDevelMenu" in
        "Alternative Terminal")
            alacritty
            ;;
        "Neovim")
            $Terminal nvim
            ;;
        "Tmux")
            SelTmux
            ;;
        "Octave-gui")
            octave
            ;;
        "Octave")
            $Terminal octave-cli
            ;;
        "Python")
            $Terminal python
            ;;
        "Lua")
            $Terminal lua
            ;;
        "Haskell")
            $Terminal ghci
            ;;
    esac
}

SelTmux() {
    TmuxOpts="New Session\nAttach Session\nDelete Session"
    TmuxMenu=$(echo -e "$TmuxOpts" | $MenuProg)
    case "$TmuxMenu" in
        "New Session")
            echo "" | $MenuProg | xargs -r $Terminal tmux new-session -s
            ;;
        "Attach Session")
            tmux list-sessions | $MenuProg | cut -d":" -f1 | xargs -r $Terminal tmux attach -t
            ;;
        "Delete Session")
            tmux list-sessions | $MenuProg | cut -d":" -f1 | xargs -r $Terminal tmux kill-session -t
    esac
}

AppOpts="Network\nMultimedia\nOffice\nDevelopment\nGames\nTerminal\nFile Manager\nView Images\nOpen Document\nAll"
AppMenu=$(echo -e "$AppOpts" | $MenuProg)
case "$AppMenu" in
    "Network")
        SelAppsNetwork
        ;;
    "Multimedia")
        SelAppsMultimedia
        ;;
    "Office")
        SelAppsOffice
        ;;
    "Development")
        SelAppsDevel
        ;;
    "Games")
        SelAppsGames
        ;;
    "Terminal")
        $Terminal
        ;;
    "File Manager")
        pcmanfm
        ;;
    "View Images")
        SelImg=$(sxiv -r "$(xdg-user-dir PICTURES)")
        if ! [[ -z "$SelImg" ]]; then
            echo "$SelImg" | xclip && notify-send "Image Copied!" "$SelImg has been copied to clipboard"
        fi
        ;;
    "Open Document")
        SelDoc=$(find "$(xdg-user-dir DOCUMENTS)" -type f -name '*.pdf' | $MenuProg)
        xdg-open "$SelDoc"
        ;;
    "All")
        dmenu_run $MenuOpts
        ;;
esac
