local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').bashls.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'bash'},
  linter = function()
    lsputil.null.diag('shellcheck')
    lsputil.null.code_actions('shellcheck')
  end,
  formatter = function()
    lsputil.null.format('shfmt')
  end
}

return M
