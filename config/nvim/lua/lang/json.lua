local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').jsonls.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'json', 'json5', 'jsonc'},
  linter = function()
    lsputil.null.diag('jsonlint')
  end,
  formatter = function()
    lsputil.null.format('jq')
  end
}

return M
