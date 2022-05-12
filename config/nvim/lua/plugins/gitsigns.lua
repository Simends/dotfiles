local M = {
  packer = {
    'lewis6991/gitsigns.nvim',
    as = 'gitsigns',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
      local maps = {
        g = {
          ['{'] = {"<cmd>Gitsigns prev_hunk<cr>", "Next git hunk"},
          ['}'] = {"<cmd>Gitsigns next_hunk<cr>", "Previous git hunk"}
        },
        ['<leader>'] = {g = {
          name = "Git",
          b = {"<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle line blame"},
          s = {
            name = "Show",
            l = {"<cmd>Gitsigns setqflist<cr>", "Show all hunks"},
          },
          h = {
            name = "Hunk",
            s = {"<cmd>Gitsigns stage_hunk<cr>", "Stage"},
            u = {"<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage"},
            r = {"<cmd>Gitsigns reset_hunk<cr>", "Reset"},
            R = {"<cmd>Gitsigns reset_buffer<cr>", "Reset buffer"},
            p = {"<cmd>Gitsigns preview_hunk<cr>", "Preview"}
          }
        }}
      }
      require('which-key').register(maps, {noremap = true, silent = true})
    end
  }
}

return M
