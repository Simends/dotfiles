local M = {
  packer = {
    'justinmk/vim-sneak',
    requires = 'tpope/vim-repeat',
    config = function ()
      vim.cmd('map , <plug>Sneak_;')
      vim.cmd('map ; <plug>Sneak_,')
    end
  }
}

return M
