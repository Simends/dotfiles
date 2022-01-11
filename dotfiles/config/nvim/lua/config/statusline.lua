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
        [' '] = vim.lsp.diagnostic.get_count(0, [[Error]]),
        [' '] = vim.lsp.diagnostic.get_count(0, [[Warning]]),
        [' '] = vim.lsp.diagnostic.get_count(0, [[Information]]),
        [' '] = vim.lsp.diagnostic.get_count(0, [[Hint]])
    }
    for k, lvl in pairs(diags) do
        if lvl > 0 then
            table.insert(output, k .. ':' .. tostring(lvl) .. ' ')
        end
    end
    return table.concat(output)
end

function status_line()
    return table.concat {
        "▊",
        " ",
        "%f", -- Filename and path
        "%m ", -- Modified flag
        "%y ", -- Filetype
        -- " ",
        -- "%l/%L:%c ", -- Line number and column
        "%p%% ", -- Percentage through file
        require'scripts.lightbulb'.get_text(),
        "%=",
        "%=",
        git_status_component(),
        lsp_diagnostic_component(),
        "▊"
    }
end
vim.o.statusline = "%!luaeval('status_line()')"
