local M = {
  preconf = function ()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local maps = {['<leader>'] = {g = {
        g = {"<cmd>Git<cr>", "Fugitive"},
        c = {"<cmd>Git commit<cr>", "Commit"},
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    'tpope/vim-fugitive'
  }
}

return M
