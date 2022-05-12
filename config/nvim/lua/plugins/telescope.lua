local M = {
  preconf = function ()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local tsb = require('telescope.builtin')
      local maps = {['<leader>'] = {
        f = {
          name = "Find",
          b = {tsb.buffers, "Buffers"},
          c = {tsb.command_history, "Commands"},
          f = {tsb.find_files, "Files"},
          g = {tsb.live_grep, "Grep"},
          j = {tsb.jumplist, "Jumplist"},
          l = {tsb.loclist, "Loclist"},
          m = {tsb.marks, "Marks"},
          o = {tsb.oldfiles, "Oldfiles"},
          q = {tsb.quickfix, "Quickfix"},
          s = {tsb.search_history, "Searches"}
        },
        g = {
          s = {
            c = {tsb.git_commits, "Show all commits"},
            C = {tsb.git_bcommits, "Show all buffer commits"},
            b = {tsb.git_branches, "Show branches"},
            s = {tsb.git_status, "Show status"},
            S = {tsb.git_stash, "Show stash"},
          },
        },
        h = {
          h = {tsb.help_tags, "Documentation"},
          H = {tsb.highlights, "Highlight groups"},
          C = {tsb.colorscheme, "Colorscheme"},
          m = {tsb.man_pages, "Manuals"},
          s = {tsb.vim_options, "Settings"},
        }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    requires = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'},
    config = function()
      require("telescope").setup {
        defaults = {
          color_devicons = true,
          prompt_prefix = "   ",
          selection_caret = "   ",
          entry_prefix = "    ",
          scroll_strategy = "cycle",
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          -- winblend = 25, -- Transparency
          -- flip_columns = 140,
          layout_config = {
            height = 60,
            anchor = "N",
            scroll_speed = 25,
            prompt_position = "top",
            vertical = {
              mirror = true
            }
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = require("telescope.actions").delete_buffer,
              },
              n = {["<c-d>"] = require("telescope.actions").delete_buffer}
            }
          }
        }
      }
      require('telescope').load_extension('fzf')
    end
  }
}

return M
