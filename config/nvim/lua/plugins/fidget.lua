local M = {
  packer = {
    'j-hui/fidget.nvim',
    after = 'lspconfig',
    config = function()
      require"fidget".setup{}
    end
  }
}

return M
