local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').yamlls.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'yaml'},
  linter = function()
    lsputil.null.diag('yamllint')
  end,
  formatter = function()
    lsputil.null.format('prettier')
  end
}

return M
