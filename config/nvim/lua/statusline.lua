local util = require('util.misc')

local modes = setmetatable({
  ['n']  = '%#ModeNormalStatusline#%#StatusLine#';
  ['no'] = '%#ModeNormalStatusline#%#StatusLine#';
  ['v']  = '%#ModeVisualStatusline#%#StatusLine#';
  ['V']  = '%#ModeVisualStatusline#%#StatusLine#';
  [''] = '%#ModeVisualStatusline#%#StatusLine#';
  ['s']  = '%#ModeSelectStatusline#%#StatusLine#';
  ['S']  = '%#ModeSelectStatusline#%#StatusLine#';
  [''] = '%#ModeSelectStatusline#%#StatusLine#';
  ['i']  = '%#ModeInsertStatusline#%#StatusLine#';
  ['ic'] = '%#ModeInsertStatusline#%#StatusLine#';
  ['R']  = '%#ModeReplaceStatusline#%#StatusLine#';
  ['Rv'] = 'V·R';
  ['c']  = '%#ModeCommandStatusline#%#StatusLine#';
  ['cv'] = '%#ModeCommandStatusline#%#StatusLine#';
  ['ce'] = '%#ModeCommandStatusline#%#StatusLine#';
  ['r']  = 'Prompt';
  ['rm'] = 'More';
  ['r?'] = 'Confirm';
  ['!']  = 'Shell';
  ['t']  = '%#ModeTerminalStatusline#%#StatusLine#';
}, {
    __index = function()
      return '?' -- handle edge cases
    end
  })

local function mode_component()
  local current_mode = vim.api.nvim_get_mode().mode
  util.create_statusline_hl("ModeNormalStatusline", "DiagnosticSignError")
  util.create_statusline_hl("ModeInsertStatusline", "GitSignsAdd")
  util.create_statusline_hl("ModeVisualStatusline", "DiagnosticSignWarn")
  util.create_statusline_hl("ModeSelectStatusline", "Tag")
  util.create_statusline_hl("ModeReplaceStatusline", "Conditional")
  util.create_statusline_hl("ModeCommandStatusline", "Number")
  util.create_statusline_hl("ModeTerminalStatusline", "Comment")
  return string.format(' %s ', modes[current_mode]):upper()
end

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
    local output = {}
    local status = {
      ['%#' .. add_color .. "# "]    = gitsigns.added,
      ['%#' .. change_color .. "#ﰣ "] = gitsigns.changed,
      ['%#' .. remove_color .. "# "] = gitsigns.removed,
    }
    for k, lvl in pairs(status) do
      if lvl > 0 then table.insert(output, k) end
      -- if lvl > 0 then table.insert(output, k .. tostring(lvl)) end
    end
    return '%#' .. branch_color .. '# ' .. branch .. ' ' .. table.concat(output) .. '%#StatusLine#'
  end
end

local function lsp_diagnostic_component()
  local err_color  = util.create_statusline_hl('ErrorStatusline', 'DiagnosticSignError')
  local warn_color = util.create_statusline_hl('WarnStatusLine', 'DiagnosticSignWarn')
  local info_color = util.create_statusline_hl('InfoStatusLine', 'DiagnosticSignInfo')
  local hint_color = util.create_statusline_hl('HintStatusLine', 'DiagnosticSignHint')
  local output = {}
  local diags = {
    ['%#' .. err_color .. '#  ']  = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})),
    ['%#' .. warn_color .. '#  '] = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})),
    ['%#' .. info_color .. '#  '] = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.INFO})),
    ['%#' .. hint_color .. '# ']  = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.HINT}))
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
  return '%#' .. pos_color .. '#%l/%L:%c %p%%%#StatusLine#  '
end

local function debug_component()
  local dap = require('dap')
  local status = dap.status()
  local status_color = util.create_statusline_hl("DebugColorStatusLine", 'Conditional')
  if status ~= '' then
    return '%#' .. status_color .. '# ' .. status .. '%#StatusLine#'
  else
    return ''
  end
end

local function lsp_ready_component()
  local status = vim.lsp.buf.server_ready()
  if status then
    return '  '
  else
    return ''
  end
end


function status_line()
  return table.concat {
    "▊ ",
    mode_component(), " ",
    devicon_component(), "%f", -- Filename and path
    "%h%q%m%r", -- Modified flag
    "%<", gps_status_component(),
    lsp_diagnostic_component(),
    "%=",
    debug_component(),
    "%=",
    position_component(),
    lsp_ready_component(),
    git_status_component(),
    '  %{&fileencoding?&fileencoding:&encoding}',
    '[%{&fileformat}]',
    "  ▊"
  }
end

function tpipe_line()
  return table.concat {
    mode_component(), " ",
    devicon_component(), "%f", -- Filename and path
    "%h%q%m%r", -- Modified flag
    "%<", gps_status_component(),
    lsp_diagnostic_component(),
    debug_component(),
    "%=", "%=",
    " | ",
    '%{&fileencoding?&fileencoding:&encoding}',
    '[%{&fileformat}]',
  }
end

vim.o.statusline = "%!luaeval('status_line()')"
vim.g.tpipeline_statusline = "%!luaeval('tpipe_line()')"
