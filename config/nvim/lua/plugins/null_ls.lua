local M = {
  packer = {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('which-key').register({['<leader>'] = {e = {I = {'<cmd>NullLsInfo<cr>', 'Show null server status'}}}}, {noremap = true, silent = true})
      require("null-ls").setup({
        default_timeout = 5000,
        diagnostics_format = "(#{s}) #{m}",
        fallback_severity = vim.diagnostic.severity.ERROR,
        on_attach = require('util.lsp').attach,
        debounce = require('util.lsp').debounce,
      })
    end
  }
}

return M
