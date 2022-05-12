local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').hdl_checker.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'verilog'},
  formatter = function()
    lsputil.null.format('verible_verilog_format')
  end
}

return M
