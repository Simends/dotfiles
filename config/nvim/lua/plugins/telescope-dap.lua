local M = {
  packer = {
    'nvim-telescope/telescope-dap.nvim',
    after = {'telescope.nvim', 'dap'},
    config = function ()
      require('telescope').load_extension('dap')
      local map = {['<leader>'] = {
        d = {
          s = {
            c = {require'telescope'.extensions.dap.commands, "Commands"},
            C = {require'telescope'.extensions.dap.configurations, "Configurations"},
            b = {require'telescope'.extensions.dap.list_breakpoints, "Breakpoints"},
            v = {require'telescope'.extensions.dap.variables, "Variables"},
            f = {require'telescope'.extensions.dap.frames, "Frames"}
          }
        }
      }}
      require('which-key').register(map, {remap = false, silent = true})
    end
  }
}

return M
