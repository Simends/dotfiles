local M = {
  packer = {
    zen = {
    'folke/zen-mode.nvim',
    opt = true,
    cmd = {'ZenMode'},
    config =
      function()
        require("zen-mode").setup {
          window = {
            backdrop = 1.0, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            width = 80, -- width of the Zen window
            height = 0.8, -- height of the Zen window
            options = {
              signcolumn = "no", -- disable signcolumn
              number = false, -- disable number column
              relativenumber = false, -- disable relative numbers
              -- cursorline = false, -- disable cursorline
              -- cursorcolumn = false, -- disable cursor column
              -- foldcolumn = "0", -- disable fold column
              -- list = false, -- disable whitespace characters
            }
          },
          plugins = {
            options = {
              enabled = true,
              ruler = false, -- disables the ruler text in the cmd line area
              showcmd = true -- disables the command in the last line of the screen
            },
            gitsigns = {enabled = true}, -- disables git signs
            tmux = {enabled = false}, -- disables the tmux statusline
            kitty = {
              enabled = false,
              font = "+4" -- font size increment
            }
          },
          -- callback where you can add custom code when the Zen window opens
          on_open = function(win)
            -- vim.cmd("IndentBlanklineDisable")
            -- vim.cmd("set colorcolumn=0")
          end,
          -- callback where you can add custom code when the Zen window closes
          on_close = function()
            -- vim.cmd("IndentBlanklineEnable")
            -- vim.cmd("set colorcolumn=80")
          end
        }
      end
    },
    smartsplits = {
      'mrjones2014/smart-splits.nvim',
      config = function()
        require('smart-splits').setup({
          -- Ignored filetypes (only while resizing)
          ignored_filetypes = {
            'nofile',
            'quickfix',
            'prompt',
          },
          -- Ignored buffer types (only while resizing)
          ignored_buftypes = { 'NvimTree' },
          -- when moving cursor between splits left or right,
          -- place the cursor on the same row of the *screen*
          -- regardless of line numbers. False by default.
          -- Can be overridden via function parameter, see Usage.
          move_cursor_same_row = false,
          -- resize mode options
          resize_mode = {
            -- key to exit persistent resize mode
            quit_key = '<ESC>',
            -- set to true to silence the notifications
            -- when entering/exiting persistent resize mode
            silent = false,
            -- must be functions, they will be executed when
            -- entering or exiting the resize mode
            hooks = {
              on_enter = nil,
              on_leave = nil
            }
          }
        })
      end
    },
    winshift = {
      'sindrets/winshift.nvim',
      config = function()
        require("winshift").setup({
          highlight_moving_win = true,  -- Highlight the window being moved
          focused_hl_group = "Visual",  -- The highlight group used for the moving window
          moving_win_options = {
            -- These are local options applied to the moving window while it's
            -- being moved. They are unset when you leave Win-Move mode.
            wrap = false,
            cursorline = false,
            cursorcolumn = false,
            colorcolumn = "",
          },
          keymaps = {
            disable_defaults = false, -- Disable the default keymaps
            win_move_mode = {
              ["h"] = "left",
              ["j"] = "down",
              ["k"] = "up",
              ["l"] = "right",
              ["H"] = "far_left",
              ["J"] = "far_down",
              ["K"] = "far_up",
              ["L"] = "far_right",
              ["<left>"] = "left",
              ["<down>"] = "down",
              ["<up>"] = "up",
              ["<right>"] = "right",
              ["<S-left>"] = "far_left",
              ["<S-down>"] = "far_down",
              ["<S-up>"] = "far_up",
              ["<S-right>"] = "far_right",
            },
          },
          ---A function that should prompt the user to select a window.
          ---
          ---The window picker is used to select a window while swapping windows with
          ---`:WinShift swap`.
          ---@return integer? winid # Either the selected window ID, or `nil` to
          ---   indicate that the user cancelled / gave an invalid selection.
          window_picker = function()
            return require("winshift.lib").pick_window({
              -- A string of chars used as identifiers by the window picker.
              picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              filter_rules = {
                -- This table allows you to indicate to the window picker that a window
                -- should be ignored if its buffer matches any of the following criteria.
                cur_win = true, -- Filter out the current window
                floats = true,  -- Filter out floating windows
                filetype = {},  -- List of ignored file types
                buftype = {},   -- List of ignored buftypes
                bufname = {},   -- List of vim regex patterns matching ignored buffer names
              },
              ---A function used to filter the list of selectable windows.
              ---@param winids integer[] # The list of selectable window IDs.
              ---@return integer[] filtered # The filtered list of window IDs.
              filter_func = nil,
            })
          end,
        })
      end
    },
  BufExplorer = {
      'jlanzarotta/bufexplorer',
      config = function()
        vim.g.bufExplorerDisableDefaultKeyMapping = 1
      end
    },
  }
}

return M
