local M = {
  packer = {
    'kosayoda/nvim-lightbulb',
    config = function()
      require'nvim-lightbulb'.setup {
        -- LSP client names to ignore
        -- Example: {"sumneko_lua", "null-ls"}
        -- ignore = {},
        sign = {
          enabled = true,
          priority = 10,
        },
        float = {
          enabled = false,
        },
        virtual_text = {
          enabled = false,
        },
        status_text = {
          enabled = false,
        }
      }
      vim.fn.sign_define('LightBulbSign', { text = "", texthl = "DiagnosticWarn", linehl="", numhl="" })
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    end
  }
}

return M
