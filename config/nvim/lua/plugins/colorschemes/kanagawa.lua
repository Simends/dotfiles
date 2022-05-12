local M = {
  packer = {
  'rebelot/kanagawa.nvim',
  config = function ()
    vim.cmd('set background=dark')
    vim.cmd('colorscheme kanagawa')
    -- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    -- vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE")
    -- vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
    -- vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
  end
}
}

return M
