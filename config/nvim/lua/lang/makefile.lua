local lsputil = require('util.lsp')

local M = {
  treesitter = {'make'},
  linter = function()
    lsputil.null.diag('checkmake')
  end,
}

return M
