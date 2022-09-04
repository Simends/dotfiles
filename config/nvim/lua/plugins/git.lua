local M = {
  packer = {
    signs = {
    'lewis6991/gitsigns.nvim',
    as = 'gitsigns',
    requires = {'nvim-lua/plenary.nvim'},
      config = function()
        require('gitsigns').setup()
      end
  },
  fugitive = {'tpope/vim-fugitive'},
}
}

return M
