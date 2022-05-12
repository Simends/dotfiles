local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').tsserver.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'javascript'},
  linter = function()
    lsputil.null.diag('eslint')
  end,
  formatter = function()
    lsputil.null.format('prettier')
  end
}

return M
