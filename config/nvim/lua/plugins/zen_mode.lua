local M = {
  preconf = function ()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local maps = {['<leader>'] = {t = {
        z = {"<cmd>ZenMode<cr>", "Zenmode"}
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    'folke/zen-mode.nvim',
    opt = true,
    cmd = {'ZenMode'},
    config =
      function()
        require("zen-mode").setup {
          window = {
            backdrop = 1.0, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            width = 100, -- width of the Zen window
            height = 1, -- height of the Zen window
            options = {
              signcolumn = "no", -- disable signcolumn
              number = true, -- disable number column
              relativenumber = true, -- disable relative numbers
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
            vim.cmd("set colorcolumn=0")
          end,
          -- callback where you can add custom code when the Zen window closes
          on_close = function()
            -- vim.cmd("IndentBlanklineEnable")
            vim.cmd("set colorcolumn=80")
          end
        }
      end
  }
}

return M
