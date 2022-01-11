local M = {}

M.cursor_size = "16"
M.border_width = "3"
M.randr = "--output DP-1 --preferred --mode 2560x1440 --pos 0,240 --transform normal --output HDMI-A-1 --mode 1920x1080 --pos 2560,0 --transform 270"
M.font_size = "10"

M.default_layout = {
    primary = {
        count = "2",
        sublayout = "columns",
        position = "left",
        ratio = "0.75",
    },
    secondary = {
        count = "5",
        sublayout = "rows",
        ratio = "0.8",
    },
    remainder = {
        sublayout = "stack",
    },
    padding = {
        outer = "10",
        inner = "10",
    }
}

M.input_devices = {}

return M
