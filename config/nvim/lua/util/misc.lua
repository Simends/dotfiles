local M = {}

M.create_statusline_hl = function(name, fg)
    local colorfg = vim.api.nvim_get_hl_by_name(fg, true).foreground
    local colorbg = vim.api.nvim_get_hl_by_name("StatusLine", true).background
    vim.api.nvim_set_hl(0, name, {fg = colorfg, bg = colorbg})
    return name
end

return M
