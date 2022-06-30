local M = {
  packer = {
    lspconfig = {
    'neovim/nvim-lspconfig',
    as = 'lspconfig',
    -- after = 'which-key',
    config = {function()
      -- LSP Setup
      -- require('which-key').register({['<leader>'] = {e = {
        -- name = "LSP",
        -- i = {'<cmd>LspInfo<cr>', 'Show server status'}
      -- }}}, {noremap = true, silent = true})
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
  },
  nullls = {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      -- require('which-key').register({['<leader>'] = {e = {I = {'<cmd>NullLsInfo<cr>', 'Show null server status'}}}}, {noremap = true, silent = true})
      require("null-ls").setup({
        default_timeout = 5000,
        diagnostics_format = "(#{s}) #{m}",
        fallback_severity = vim.diagnostic.severity.ERROR,
        on_attach = require('util.lsp').attach,
        debounce = require('util.lsp').debounce,
      })
    end
  },
  fidget = {
    'j-hui/fidget.nvim',
    after = 'lspconfig',
    config = function()
      require"fidget".setup{}
    end
  },
  lightbulb = {
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
        float = {enabled = false},
        virtual_text = {enabled = false},
        status_text = {enabled = false}
      }
      vim.fn.sign_define('LightBulbSign', { text = "", texthl = "DiagnosticWarn", linehl="", numhl="" })
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
    end
  },
  symbolsoutline = {
    'simrat39/symbols-outline.nvim',
    opt = true,
    cmd = {'SymbolsOutline'},
    after = 'lspconfig',
    config = function()
        vim.g.symbols_outline = {
          highlight_hovered_item = true,
          show_guides = true,
          auto_preview = true,
          position = 'right',
          keymaps = {
            close = "<Esc>",
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            rename_symbol = "r",
            code_actions = "a"
          },
          lsp_blacklist = {}
        }
      end
  },
  }
}

return M
