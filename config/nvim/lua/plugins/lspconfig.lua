local M = {
  packer = {
    'neovim/nvim-lspconfig',
    as = 'lspconfig',
    after = 'which-key',
    config = {function()
      -- LSP Setup
      require('which-key').register({['<leader>'] = {e = {
        name = "LSP",
        i = {'<cmd>LspInfo<cr>', 'Show server status'}
      }}}, {noremap = true, silent = true})
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●', -- Could be '●', '▎', 'x', '■'
        }
      })
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end}
  }
}

return M
