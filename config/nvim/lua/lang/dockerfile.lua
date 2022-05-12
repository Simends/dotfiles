local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').dockerls.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'dockerfile'},
  linter = function()
    lsputil.null.diag('hadolint')
  end,
}

return M
