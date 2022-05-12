local lsputil = require('util.lsp')

local M = {
  treesitter = {'fennel'},
  formatter = function()
    lsputil.null.format('fnlfmt')
  end
}

return M
