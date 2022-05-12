local M = {
  packer = {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function ()
      -- Set variant
      -- Defaults to 'dawn' if vim background is light
      -- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
      vim.g.rose_pine_variant = 'moon'
      vim.cmd('colorscheme rose-pine')
      -- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
      -- vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE")
      -- vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
      -- vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
    end
  }
}

return M
