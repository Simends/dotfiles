local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').asm_lsp.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  formatter = function()
    lsputil.null.format('asmfmt')
  end
}

return M
