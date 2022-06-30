local M = {
  packer = {
    treesitter = {
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
    end}
  },
  refactor = {
    'nvim-treesitter/nvim-treesitter-refactor',
    config = function()
      require'nvim-treesitter.configs'.setup {
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = false },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "grr",
            },
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "<a-*>",
              goto_previous_usage = "<a-#>",
            },
          },
        },
      }
    end
  },
  textobjects = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["aC"] = "@comment.outer",
              -- Or you can define your own textobjects like this
              -- ["iF"] = {
              --     python = "(function_definition) @function",
              --     cpp = "(function_definition) @function",
              --     c = "(function_definition) @function",
              --     java = "(method_declaration) @function",
              -- },
            },
          },
        },
      }
    end
  },
  playground = {
    'nvim-treesitter/playground',
    opt = true,
    cmd = {"TSPlaygroundToggle"},
    after = 'treesitter',
    config = function()
      require "nvim-treesitter.configs".setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  },
  rainbow = {
    'p00f/nvim-ts-rainbow',
    after = 'treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        rainbow = {
          enable = true,
          extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
          max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
        },
      }
    end
  },
  spellsitter = {
    'lewis6991/spellsitter.nvim',
    as = 'spellsitter',
    config = function()
      require('spellsitter').setup()
    end
  },
}
}

return M
