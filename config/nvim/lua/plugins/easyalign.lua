local M = {
  packer = {
    'junegunn/vim-easy-align',
    requires = 'tpope/vim-repeat',
    config = function ()
      vim.cmd[[nmap gl <plug>(EasyAlign)]]
      vim.cmd[[xmap gl <plug>(EasyAlign)]]
    end
  }
}

return M
