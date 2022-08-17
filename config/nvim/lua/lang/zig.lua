local lsputil = require('util.lsp')

local M = {
  lsp = function ()
      require('lspconfig').zls.setup {
        on_attach = lsputil.attach,
        capabilities = lsputil.capabilities,
        flags = {
          debounce_text_changes = lsputil.debounce,
        },
      }
    end,
  treesitter = {'zig'},
  formatter = function()
    lsputil.null.format('zigfmt')
  end
}

return M
