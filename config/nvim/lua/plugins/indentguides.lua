local M = {
  packer = {
    'lukas-reineke/indent-blankline.nvim',
    opt = true,
    cmd = {'IndentBlanklineToggle', 'IndentBlanklineToggle!'},
    config = function()
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_end_of_line = false,
        show_current_context = true,
        show_current_context_start = false,
        use_treesitter = true,
      }
      -- vim.cmd('IndentBlanklineDisable!')
    end
  }
}

return M
