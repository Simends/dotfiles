local M = {
  packer = {
    qf = {
    'stevearc/qf_helper.nvim',
    config = function()
      require'qf_helper'.setup({
        prefer_loclist = true,       -- Used for QNext/QPrev (see Commands below)
        sort_lsp_diagnostics = true, -- Sort LSP diagnostic results
        quickfix = {
          autoclose = true,          -- Autoclose qf if it's the only open window
          default_bindings = true,   -- Set up recommended bindings in qf window
          default_options = true,    -- Set recommended buffer and window options
          max_height = 10,           -- Max qf height when using open() or toggle()
          min_height = 5,            -- Min qf height when using open() or toggle()
          track_location = 'cursor', -- Keep qf updated with your current location
          -- Use `true` to update position as well
        },
        loclist = {                  -- The same options, but for the loclist
          autoclose = true,
          default_bindings = true,
          default_options = true,
          max_height = 10,
          min_height = 5,
          track_location = 'cursor',
        },
      })
      local opt = {noremap = true, silent = true, prefix = "Q"}
      local map = {
        Q = {"<cmd>QFToggle<cr>", "Toggle quickfix"},
        q = {"<cmd>QFToggle!<cr>", "Toggle silent quickfix"},
        C = {"<cmd>LLToggle<cr>", "Toggle loclist"},
        c = {"<cmd>LLToggle!<cr>", "Toggle silent loclist"},
        L = {"<cmd>QNext<cr>", "Next in list"},
        l = {"<cmd>QNext!<cr>", "Next silent in list"},
        H = {"<cmd>QPrev<cr>", "Prev in list"},
        h = {"<cmd>QPrev!<cr>", "Prev silent in list"}
      }
      require('which-key').register(map, opt)
    end
  },
  }
}

return M
