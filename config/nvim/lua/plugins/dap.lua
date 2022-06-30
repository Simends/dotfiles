local M = {
  packer = {
    dap = {
    'mfussenegger/nvim-dap',
    as = 'dap',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      local dap = require('dap')
      local api = vim.api
      local keymap_restore = {}
      dap.listeners.after['event_initialized']['me'] = function()
        for _, buf in pairs(api.nvim_list_bufs()) do
          local keymaps = api.nvim_buf_get_keymap(buf, 'n')
          for _, keymap in pairs(keymaps) do
            if keymap.lhs == "I" then
              table.insert(keymap_restore, keymap)
              api.nvim_buf_del_keymap(buf, 'n', 'I')
            end
          end
        end
        api.nvim_set_keymap(
          'n', 'I', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
      end

      dap.listeners.after['event_terminated']['me'] = function()
        for _, keymap in pairs(keymap_restore) do
          api.nvim_buf_set_keymap(
            keymap.buffer,
            keymap.mode,
            keymap.lhs,
            keymap.rhs,
            { silent = keymap.silent == 1 }
          )
        end
        keymap_restore = {}
      end
      local opt = {noremap = true, silent = true}
      -- local Hydra = require('hydra')

        -- Hydra({
        --   hint = [[
 -- _H_: Step Out   _J_: Step into     _K_: Step Over   _L_: Continue
 -- _b_: Toggle breakpoint             _B_: Clear all breakpoints
 -- ^
 -- ^ ^              _<Enter>_: Repl              _q_: exit
-- ]],
        --   config = {
        --     color = 'pink',
        --     invoke_on_body = true,
        --     hint = {
        --       position = 'top',
        --       border = 'rounded'
        --     },
        --     on_enter = function()
        --       vim.bo.modifiable = false
        --     end,
        --     on_exit = function()
        --       vim.bo.modifiable = true
        --     end
        --   },
        --   mode = {'n','x'},
        --   body = '<leader>d',
        --   heads = {
        --     { 'H', dap.step_out() },
        --     { 'J', dap.step_into() },
        --     { 'K', dap.step_over() },
        --     { 'L', dap.continue() },
        --     { 'b', dap.toggle_breakpoint() },
        --     { 'B', dap.clear_breakpoints() },
        --     { '<Enter>', dap.repl.toggle(), { exit = true } },
        --     { 'q', dap.terminate(), { exit = true, nowait = true } },
        --   }
        -- })
      vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapLogPoint', {text='', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})
    end
  },
  virtualtext = {
    'theHamsta/nvim-dap-virtual-text',
    after = {'treesitter', 'dap'},
    config = function ()
      require("nvim-dap-virtual-text").setup()
    end
  },
  telescope = {
    'nvim-telescope/telescope-dap.nvim',
    after = {'telescope.nvim', 'dap'},
    config = function ()
      require('telescope').load_extension('dap')
    end
  },
}
}

return M
