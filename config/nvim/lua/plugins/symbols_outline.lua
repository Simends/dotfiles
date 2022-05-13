local M = {
  preconf = function()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local maps = {['<leader>'] = {e = {
        o = {[[<cmd>SymbolsOutline<cr>]], "Show symbols"},
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    'simrat39/symbols-outline.nvim',
    opt = true,
    cmd = {'SymbolsOutline'},
    after = 'lspconfig',
    config = {
      function()
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
    }
  }
}

return M