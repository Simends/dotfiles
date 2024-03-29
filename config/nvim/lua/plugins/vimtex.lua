local M = {
  packer = {
    vimtex = {
    'lervag/vimtex',
    opt = true,
    ft = 'tex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'
    end
  },
  }
}

return M
