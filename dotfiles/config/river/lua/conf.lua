local M = {}

M.mod = "Mod4"
local terminal = "footclient"
-- local theme = require('colors/gruvbox')
local device = require('devices/' .. os.getenv("RIVERCONF_DEVICE"))

local scripts = "$XDG_CONFIG_HOME/river/scripts"
local all_tags = tostring(math.floor((2^(32)) - 1))

local bg_color = '0x232136'
local color_focused = '0xe0def4'
local color_unfocused = '0x817c9c'
local color_urgent = '0xeb6f92'
local gtk_theme = 'Adwaita-dark'
local icon_theme = 'Papirus-dark'
local cursor_theme = 'default'
local font = 'Noto Sans'
M.default_layout = device.default_layout
M.input_devices = device.input_devices
M.maps = {
    W = "spawn qutebrowser",
    Escape = "spawn 'swaylock -l -s fill -i ~/Multimedia/Pictures/Wallpapers/current'",
    Q = "close",
    J = "focus-view next",
    K = "focus-view previous",
    H = "send-layout-cmd stacktile 'primary_ratio -0.05'",
    L = "send-layout-cmd stacktile 'primary_ratio +0.05'",
    Period = "focus-output next",
    Comma = "focus-output previous",
    -- Space = "spawn 'wofi -S drun -Ii --width=25% --prompt='",
    Space = "spawn 'menu.sh'",
    Return = "zoom",
    Backspace = "spawn 'fnottctl dismiss'",
    F1 = "spawn 'playerctl previous'",
    F2 = "spawn 'playerctl play-pause'",
    F3 = "spawn 'playerctl next'",
    F10 = "enter-mode passthrough",
    F11 = "toggle-fullscreen",
    F12 = "spawn '" .. scripts .. "/reset-layout.lua'",
    ['0'] = "set-focused-tags " .. all_tags,
    B = "border-width 0",
    -- Change padding
    T = "send-layout-cmd stacktile 'all_padding 0'",
    Y = "send-layout-cmd stacktile 'outer_padding -10'",
    U = "send-layout-cmd stacktile 'inner_padding -10'",
    I = "send-layout-cmd stacktile 'inner_padding +10'",
    O = "send-layout-cmd stacktile 'outer_padding +10'",
    p = "spawn '" .. scripts .. "/reset-padding.lua'",
    -- Change layout
    F = "toggle-float",
    A = "send-layout-cmd stacktile 'all_primary toggle'",
    S = "send-layout-cmd stacktile 'primary_sublayout stack'",
    D = "send-layout-cmd stacktile 'primary_sublayout dwindle'",
    M = "send-layout-cmd stacktile 'primary_sublayout full'",
    G = "send-layout-cmd stacktile 'primary_sublayout grid'",
    C = "send-layout-cmd stacktile 'primary_sublayout columns'",
    R = "send-layout-cmd stacktile 'primary_sublayout rows'",
    -- Change primary position
    Up = "send-layout-cmd stacktile 'primary_position top'",
    Right = "send-layout-cmd stacktile 'primary_position right'",
    Down = "send-layout-cmd stacktile 'primary_position bottom'",
    Left = "send-layout-cmd stacktile 'primary_position left'",
    Shift = {
        Return = "spawn " .. terminal,
        E = "exit",
        -- R = "send-layout-cmd stacktile 'reset'",
        J = "swap next",
        K = "swap previous",
        H = "send-layout-cmd stacktile 'primary_count +1'",
        L = "send-layout-cmd stacktile 'primary_count -1'",
        Period = "send-to-output next",
        Comma = "send-to-output previous",
        F1 = "spawn 'playerctl position 5-'",
        F3 = "spawn 'playerctl position 5+'",
        ['0'] = "set-view-tags " .. all_tags,
        B = "border-width " .. device.border_width,
        -- Change secondary layout
        S = "send-layout-cmd stacktile 'secondary_sublayout stack'",
        D = "send-layout-cmd stacktile 'secondary_sublayout dwindle'",
        F = "send-layout-cmd stacktile 'secondary_sublayout full'",
        G = "send-layout-cmd stacktile 'secondary_sublayout grid'",
        C = "send-layout-cmd stacktile 'secondary_sublayout columns'",
        R = "send-layout-cmd stacktile 'secondary_sublayout rows'",
    },
    Mod1 = {
        H = "move left 100",
        J = "move down 100",
        K = "move up 100",
        L = "move right 100",
        B = "border-width 1",
        -- Change remainder layout
        S = "send-layout-cmd stacktile 'remainder_sublayout stack'",
        D = "send-layout-cmd stacktile 'remainder_sublayout dwindle'",
        F = "send-layout-cmd stacktile 'remainder_sublayout full'",
        G = "send-layout-cmd stacktile 'remainder_sublayout grid'",
        C = "send-layout-cmd stacktile 'remainder_sublayout columns'",
        R = "send-layout-cmd stacktile 'remainder_sublayout rows'",
        Shift = {
            H = "resize horizontal -100",
            J = "resize vertical 100",
            K = "resize vertical -100",
            L = "resize horizontal 100"
        },
        Control = {
            H = "snap left",
            J = "snap down",
            K = "snap up",
            L = "snap right"
        }
    },
    Control = {
        P = "spawn '" .. terminal .. " python'",
        O = "spawn '" .. terminal .. " octave'",
        L = "spawn '" .. terminal .. " lua'",
        M = "spawn '" .. terminal .. " neomutt'",
        N = "spawn '" .. terminal .. " newsboat'",
    }
}

M.noModMaps = {
    ['XF86AudioMute'] = "spawn 'amixer -q set Master Playback Volume toggle'",
    ['XF86AudioRaiseVolume'] = "spawn 'amixer -q set Master Playback Volume 10%+'",
    ['XF86AudioLowerVolume'] = "spawn 'amixer -q set Master Playback Volume 10%-'",
    ['XF86MonBrightnessUp'] = "spawn 'light -A 10'",
    ['XF86MonBrightnessDown'] = "spawn 'light -U 10'",
    ['XF86AudioMicMute'] = "spawn 'amixer -q set Capture Volume toggle'",
    ['XF86Wlan'] = "spawn 'rfkill toggle all'",
}

M.sets = {
    ['xcursor-theme'] = cursor_theme .. " " .. device.cursor_size,
    ['background-color'] = bg_color,
    ['border-color-focused'] = color_focused,
    ['border-color-unfocused'] = color_unfocused,
    ['border-width'] = device.border_width,
    ['border-color-urgent'] = color_urgent,
    ['attach-mode'] = "bottom",
    ['set-repeat'] = "50 300",
    ['declare-mode'] = "passthrough",
    -- Stacktile settings
    ['default-layout'] = "stacktile",
    ['map-pointer'] = { -- Mouse mappings
        "normal " .. M.mod .. " BTN_LEFT move-view",
        "normal " .. M.mod .. " BTN_RIGHT resize-view",
    },
    spawn = { -- Programs that should be run on startup
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "'swaybg -m fill -i ~/Multimedia/Pictures/Wallpapers/current'",
        "'gsettings set org.gnome.desktop.interface gtk-theme " .. gtk_theme .. "'",
        "'gsettings set org.gnome.desktop.interface icon-theme " .. icon_theme .. "'",
        "'gsettings set org.gnome.desktop.interface cursor-theme " .. cursor_theme .. "'",
        "'gsettings set org.gnome.desktop.interface cursor-size " .. device.cursor_size .. "'",
        "'gsettings set org.gnome.desktop.interface font-name " .. font .. ", " .. device.font_size .. "'",
        "'wlr-randr " .. device.randr .. "'",
        "'foot --server'",
        "fnott",
        "yambar",
        "'wlsunset -S 06:00 -s 19:00 -d 1800'",
        "'batsignal -w 15 -c 5 -d 2 -f 100 -a Battery'",
    },
    ['float-filter-add'] = { -- Programs that should always be floating
        "virt-manager",
        "float",
        "popup"
    }
}

return M
