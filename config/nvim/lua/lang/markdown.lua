local lsputil = require('util.lsp')

local M = {
  treesitter = {'markdown'},
  linter = function()
    -- lsputil.null.diag('proselint')
    -- lsputil.null.diag('markdownlint')
    lsputil.null.hover('dictionary')
    -- lsputil.null.completion('spell')
    -- lsputil.null.code_actions('proselint')
  end,
  formatter = function()
    lsputil.null.format('prettier')
  end
}

return M
