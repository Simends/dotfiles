local M = {
  packer = {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function ()
      -- Set variant
      -- Defaults to 'dawn' if vim background is light
      -- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
      vim.g.rose_pine_variant = 'moon'
    end
  }
}

return M
