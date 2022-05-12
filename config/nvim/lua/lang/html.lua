local lsputil = require('util.lsp')

local M = {
  lsp = function ()
    require('lspconfig').html.setup {
      on_attach = lsputil.attach,
      capabilities = lsputil.capabilities,
      filetypes = {"html"},
      init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {css = true, javascript = true}
      },
      flags = {
          debounce_text_changes = lsputil.debounce,
      }
    }
  end,
  treesitter = {'html'},
  linter = function()
    lsputil.null.diag('tidy')
  end,
  formatter = function()
    lsputil.null.format('prettier')
  end
}

return M
