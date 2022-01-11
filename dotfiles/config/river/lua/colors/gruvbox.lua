local M = {}

M.bg_image = "~/Multimedia/Pictures/Wallpapers/minimalism-logo-devil-6r.jpg"
M.bg_color = "0x282828"
M.color_focused = "0xebdbb2"
M.color_unfocused = "0x928374"
M.color_urgent = "0xcc241d"

M.gtk_theme = "Gruvbox-Material-Dark-HIDPI"
M.icon_theme = "Gruvbox-Material-Dark"
M.cursor_theme = "default"
M.font = "Noto Sans"

M.square = {
    active = {
        bg_color = "0xffffff",
        border_color = "0x928374",
        occupied_color = "0x282828",
    },
    inactive = {
        bg_color = "0x282828",
        border_color = "0x928374",
        occupied_color = "0x282828",
    },
    urgent = {
        bg_color = "0x282828",
        border_color = "0x928374",
        occupied_color = "0x282828",
    }
}

return M
