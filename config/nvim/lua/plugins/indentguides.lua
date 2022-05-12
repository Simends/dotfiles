local M = {
  preconf = function()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local maps = {['<leader>'] = {t = {
        i = {"<cmd>IndentBlanklineToggle<cr>", "Indent guides"},
        I = {"<cmd>IndentBlanklineToggle!<cr>", "Indent guides globally"},
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
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
