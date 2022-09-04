local M = {
  preconf = function ()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local tsb = require('telescope.builtin')
      local maps = {['<leader>'] = {
        f = {
          name = "Find",
          b = {tsb.buffers, "Buffers"},
          [':'] = {tsb.command_history, "Commands"},
          f = {tsb.find_files, "Files"},
          g = {tsb.live_grep, "Grep"},
          j = {tsb.jumplist, "Jumplist"},
          l = {tsb.loclist, "Loclist"},
          m = {tsb.marks, "Marks"},
          o = {tsb.oldfiles, "Oldfiles"},
          q = {tsb.quickfix, "Quickfix"},
          ['?'] = {tsb.search_history, "Searches"},
          r = {tsb.registers, "Registers"},
          ['<cr>'] = {':Telescope<cr>', "All pickers"}
        },
        h = {
          h = {tsb.help_tags, "Documentation"},
          H = {tsb.highlights, "Highlight groups"},
          c = {tsb.colorscheme, "Colorscheme"},
          m = {tsb.man_pages, "Manuals"},
          s = {tsb.vim_options, "Settings"},
          k = {tsb.keymaps, "Keymaps"},
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    telescope = {
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
    },
    dressing = {
      'stevearc/dressing.nvim',
      config = function()
        require('dressing').setup({
          input = {
            -- Set to false to disable the vim.ui.input implementation
            enabled = true,

            -- Default prompt string
            default_prompt = "Input:",

            -- Can be 'left', 'right', or 'center'
            prompt_align = "left",

            -- When true, <Esc> will close the modal
            insert_only = true,

            -- These are passed to nvim_open_win
            anchor = "SW",
            border = "single",
            -- 'editor' and 'win' will default to being centered
            relative = "cursor",

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            prefer_width = 40,
            width = nil,
            -- min_width and max_width can be a list of mixed types.
            -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
            max_width = { 140, 0.9 },
            min_width = { 20, 0.2 },

            -- Window transparency (0-100)
            winblend = 0,
            -- Change default highlight groups (see :help winhl)
            winhighlight = "",

            override = function(conf)
              -- This is the config that will be passed to nvim_open_win.
              -- Change values here to customize the layout
              return conf
            end,

            -- see :help dressing_get_config
            get_config = nil,
          },
          select = {
            -- Set to false to disable the vim.ui.select implementation
            enabled = true,

            -- Priority list of preferred vim.select implementations
            backend = { "telescope", "builtin" },

            -- Options for built-in selector
            builtin = {
              -- These are passed to nvim_open_win
              anchor = "NW",
              border = "single",
              -- 'editor' and 'win' will default to being centered
              relative = "editor",

              -- Window transparency (0-100)
              winblend = 10,
              -- Change default highlight groups (see :help winhl)
              winhighlight = "",

              -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
              -- the min_ and max_ options can be a list of mixed types.
              -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
              width = nil,
              max_width = { 140, 0.8 },
              min_width = { 40, 0.2 },
              height = nil,
              max_height = 0.9,
              min_height = { 10, 0.2 },

              override = function(conf)
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                return conf
              end,
            },

            -- Used to override format_item. See :help dressing-format
            format_item_override = {},

            -- see :help dressing_get_config
            get_config = nil,
          },
        })
      end
    },
    icon_picker = {
      "ziontee113/icon-picker.nvim",
      config = function()
        require("icon-picker")
      end,
    }
  }
}

return M
