local lsputil = require('util.lsp')

local M = {
  treesitter = {'css'},
  linter = function()
    lsputil.null.diag('stylelint')
  end,
  formatter = function()
    lsputil.null.format('prettier')
  end
}

return M
