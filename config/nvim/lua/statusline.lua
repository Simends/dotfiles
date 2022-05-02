local function git_status_component()
  local branch = vim.b.gitsigns_head
  if branch == nil then
    return ''
  else
    local gitsigns = vim.b.gitsigns_status_dict
    return '%#CursorColumn#  ' .. branch .. ' +' .. tostring(gitsigns.added) .. ' ~' .. tostring(gitsigns.changed) .. ' -' .. tostring(gitsigns.removed) .. ' '
  end
end

local function lsp_diagnostic_component()
  local output = {}
  local diags = {
    ['%#DiagnosticSignError#  '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })),
    ['%#DiagnosticSignWarn#  '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })),
    ['%#DiagnosticSignInfo#  '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })),
    ['%#DiagnosticSignHint# '] = vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }))
  }
  for k, lvl in pairs(diags) do
    if lvl > 0 then
      table.insert(output, k .. ':' .. tostring(lvl))
    end
  end
  return table.concat(output) .. ' '
end

local function gps_status_component()
  local gps = require("nvim-gps")
  if gps.is_available() and gps.get_location() ~= '' then
    return ' > ' .. gps.get_location()
  else
    return ''
  end
end

local function devicon_component()
  local devicons = require("nvim-web-devicons")
  local current_ft = vim.bo.filetype
  local icon, colorgroup = devicons.get_icon_by_filetype(current_ft, {default = true})
  if icon then
    local colorfg = vim.api.nvim_get_hl_by_name(colorgroup, true).foreground
    local colorbg = vim.api.nvim_get_hl_by_name("StatusLine", true).background
    local color = "FtIconStatusLine"
    vim.api.nvim_set_hl(0, color, { fg = colorfg, bg = colorbg })
    return '%#' .. color .. '#' .. icon .. '%#StatusLine# '
  else
    return ''
  end
end

function status_line()
  return table.concat {
    "▊",
    " ",
    devicon_component(),
    "%f", -- Filename and path
    "%m", -- Modified flag
    --" %y", -- Filetype
    gps_status_component(),
    " %p%%", -- Percentage through file
    -- " ",
    "%=",
    "%=",
    -- "%l/%L:%c ", -- Line number and column
    lsp_diagnostic_component(),
    git_status_component(),
    -- "%#CursorColumn# %l/%L:%c %p%% ",
    "%#StatusLine#▊"
  }
end
vim.o.statusline = "%!luaeval('status_line()')"
