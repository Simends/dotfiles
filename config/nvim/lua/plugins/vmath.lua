local M = {
  packer = {
    'nixon/vim-vmath',
    config = function ()
      vim.cmd('vmap <expr>  ++  VMATH_YankAndAnalyse()')
      vim.cmd('nmap         ++  vip++)')
    end
  }
}

return M
