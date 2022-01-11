local M = {}

M.cursor_size = "24"
M.border_width = "2"
M.randr = "--output eDP-1 --preferred --mode 3000x2000 --scale 1.8"
M.font_size = "10"

M.default_layout = {
    primary = {
        count = "1",
        sublayout = "rows",
        position = "left",
        ratio = "0.60",
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

M.input_devices = {
    ['1739:52552:SYNA2393:00_06CB:CD48_Touchpad'] = {
        ['accel-profile'] = "adaptive",
        ['click-method'] = "clickfinger",
        ['drag'] = "enabled",
        ['disable-while-typing'] = "enabled",
        ['middle-emulation'] = "enabled",
        ['natural-scroll'] = "enabled",
        ['tap'] = "enabled",
        ['tap-button-map'] = "left-right-middle",
        ['scroll-method'] = "two-finger"
    },
    -- ['1739:6572:HQTL2393:00_06CB:19AC'] = {}
}

return M
