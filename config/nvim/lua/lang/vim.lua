local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').vimls.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'vim'},
  linter = function()
    lsputil.null.diag('vint')
  end,
}

return M
