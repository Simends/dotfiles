local M = {
  packer = {
    'nvim-treesitter/nvim-treesitter',
    as = 'treesitter',
    run = ':TSUpdate',
    config = {function()
      require'nvim-treesitter.configs'.setup {
        -- ensure_installed = "maintained",
        ensure_installed = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
        },
      }
      local maps = {['<leader>'] = {h = {
        t = {"<cmd>TSModuleInfo<cr>", "Treesitter"},
      }}
      }
      require('which-key').register(maps, {noremap = true, silent = true})
    end}
  }
}

return M
