local function git_status_component()
    local branch = vim.b.gitsigns_head
    if branch == nil then
        return ''
    else
        local gitsigns = vim.b.gitsigns_status_dict
        return ' ' .. branch .. ' +' .. tostring(gitsigns.added) .. ' ~' .. tostring(gitsigns.changed) .. ' -' .. tostring(gitsigns.removed) .. ' '
    end
end

local function lsp_diagnostic_component()
    local output = {}
    local diags = {
        [' '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })),
        [' '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })),
        [' '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })),
        [' '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }))
    }
    for k, lvl in pairs(diags) do
        if lvl > 0 then
            table.insert(output, k .. ':' .. tostring(lvl) .. ' ')
        end
    end
    return table.concat(output)
end

local function gps_status_component()
    local gps = require("nvim-gps")
    if gps.is_available() and gps.get_location() ~= '' then
        return ' > ' .. gps.get_location()
    else
        return ''
    end
end

function status_line()
    return table.concat {
        "▊",
        " ",
        "%f", -- Filename and path
        gps_status_component(),
        "%m ", -- Modified flag
        "%y ", -- Filetype
        -- " ",
        "%p%% ", -- Percentage through file
        "%=",
        "%=",
        -- "%l/%L:%c ", -- Line number and column
        git_status_component(),
        lsp_diagnostic_component(),
        "▊"
    }
end
vim.o.statusline = "%!luaeval('status_line()')"
