local M = {
  packer = {
    'folke/tokyonight.nvim',
    config = function()
      -- The theme comes in three styles, storm, a darker variant night and day.
      vim.g.tokyonight_style = "storm"
      -- Configure the colors used when opening a :terminal in Neovim
      vim.g.tokyonight_terminal_colors = true
      -- Make comments italic
      vim.g.tokyonight_italic_comments = true
      -- Make keywords italic
      vim.g.tokyonight_italic_keywords = true
      -- Make functions italic
      vim.g.tokyonight_italic_functions = true
      -- Make variables and identifiers italic
      vim.g.tokyonight_italic_variables = false
      -- Enable this to disable setting the background color
      vim.g.tokyonight_transparent = false
      -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard StatusLine and LuaLine.
      vim.g.tokyonight_hide_inactive_statusline = true
      -- Set a darker background on sidebar-like windows.
      vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
      -- Sidebar like windows like NvimTree get a darker background
      vim.g.tokyonight_dark_sidebar = true
      -- Float windows like the lsp diagnostics windows get a darker background.
      vim.g.tokyonight_dark_float = true
      -- You can override specific color groups to use other groups or a hex color
      -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
      -- Adjusts the brightness of the colors of the Day style. Number between 0 and 1, from dull to vibrant colors
      vim.g.tokyonight_day_brightness = 0.3
    end
  }
}

return M
