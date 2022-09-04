local M = {
  packer = {
    everforest = {
      'sainnhe/everforest',
      config = function ()
        vim.o.background = 'dark'
        vim.o.termguicolors = 1
        vim.g.everforest_background = 'soft'
        vim.g.everforest_enable_italic = 1
        vim.g.everforest_diagnostic_text_highlight = 1
        vim.g.everforest_diagnostic_line_highlight = 1
        vim.g.everforest_diagnostic_virtual_text = 'colored'
      end
    },
  }
}

return M
