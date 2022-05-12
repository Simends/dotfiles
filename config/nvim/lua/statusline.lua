local util = require('util.misc')

local function git_status_component()
    local branch = vim.b.gitsigns_head
    if branch == nil then
        return ''
    else
        local gitsigns = vim.b.gitsigns_status_dict
        local branch_color = util.create_statusline_hl("GitBranchColorStatusLine", 'Conditional')
        local add_color    = util.create_statusline_hl("GitAddColorStatusLine", 'GitSignsAdd')
        local change_color = util.create_statusline_hl("GitChangeColorStatusLine", 'GitSignsChange')
        local remove_color = util.create_statusline_hl("GitRemoveColorStatusLine", 'GitSignsDelete')
        return
            '%#' .. branch_color .. '#   ' .. branch .. '%#' .. add_color ..
                '# +' .. tostring(gitsigns.added) .. '%#' .. change_color ..
                '# ~' .. tostring(gitsigns.changed) .. '%#' .. remove_color ..
                '# -' .. tostring(gitsigns.removed) .. '%#StatusLine#'
    end
end

local function lsp_diagnostic_component()
    local output = {}
    local err_color  = util.create_statusline_hl('ErrorStatusline', 'DiagnosticSignError')
    local warn_color = util.create_statusline_hl('WarnStatusLine', 'DiagnosticSignWarn')
    local info_color = util.create_statusline_hl('InfoStatusLine', 'DiagnosticSignInfo')
    local hint_color = util.create_statusline_hl('HintStatusLine', 'DiagnosticSignHint')
    local diags = {
        ['%#' .. err_color .. '#  '] = vim.tbl_count(
            vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})),
        ['%#' .. warn_color .. '#  '] = vim.tbl_count(
            vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})),
        ['%#' .. info_color .. '#  '] = vim.tbl_count(
            vim.diagnostic.get(0, {severity = vim.diagnostic.severity.INFO})),
        ['%#' .. hint_color .. '# '] = vim.tbl_count(
            vim.diagnostic.get(0, {severity = vim.diagnostic.severity.HINT}))
    }
    for k, lvl in pairs(diags) do
        if lvl > 0 then table.insert(output, k .. ':' .. tostring(lvl)) end
    end
    return ' ' .. table.concat(output) .. '%#StatusLine#'
end

local function gps_status_component()
    local gps = require("nvim-gps")
    if gps.is_available() and gps.get_location() ~= '' then
        return '  ' .. gps.get_location() .. '%#StatusLine#'
    else
        return ''
    end
end

local function devicon_component()
    local devicons = require("nvim-web-devicons")
    local current_ft = vim.bo.filetype
    local icon, colorgroup = devicons.get_icon_by_filetype(current_ft,
                                                           {default = true})
    if icon then
        local color = util.create_statusline_hl("FtIconStatusLine", colorgroup)
        return '%#' .. color .. '#' .. icon .. '%#StatusLine# '
    else
        return ''
    end
end

local function position_component()
    local pos_color = util.create_statusline_hl('PositionStatusLine', 'LineNR')
    return '%#' .. pos_color .. '#%l/%L:%c %p%%%#StatusLine#'
end


function status_line()
    return table.concat {
        "▊ ", " ", devicon_component(), "%f", -- Filename and path
        "%h%q%m%r", -- Modified flag
        "%<", gps_status_component(),
        "%=", "%=",
        position_component(),
        lsp_diagnostic_component(), git_status_component(),
        '  %{&fileencoding?&fileencoding:&encoding}',
        '[%{&fileformat}]',
        "  ▊"
    }
end
vim.o.statusline = "%!luaeval('status_line()')"
