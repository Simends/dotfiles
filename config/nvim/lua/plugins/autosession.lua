local M = {
  packer = {
    autosession = {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'telescope.nvim'},
    config = function()
      vim.o.sessionoptions="blank,curdir,folds,help,tabpages,winsize,winpos,terminal"
      require('auto-session').setup {
        log_level = 'info',
        auto_session_suppress_dirs = {'~/'}
      }
      require('session-lens').setup {
        path_display={'shorten'},
      }
      require("telescope").load_extension("session-lens")
      local maps = {
        ['<leader>'] = {s = {
          name = 'Sessions',
          s = {"<cmd>SaveSession<cr>", "Save"},
          r = {"<cmd>Telescope session-lens search_session<cr>", "Restore"}
        }}
      }
      require('which-key').register(maps, {noremap = true, silent = true})
    end
  }
  }
}

return M
