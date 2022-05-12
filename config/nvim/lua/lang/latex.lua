local lsputil = require('util.lsp')

local M = {
  treesitter = {'latex'},
  linter = function()
    lsputil.null.diag('chktex')
  end,
  formatter = function()
    lsputil.null.format('latexindent')
  end
}

return M
