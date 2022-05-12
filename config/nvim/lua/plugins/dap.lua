local M = {
  packer = {
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
      local map = {
        ['<F5>'] = {[[<cmd>lua require'dap'.continue()<CR>]], "Continue"},
        ['<F10>'] = {[[<cmd>lua require'dap'.step_over()<cr>]], "Step over"},
        ['<F11>'] = {[[<cmd>lua require'dap'.step_into()<cr>]], "Step into"},
        ['<F12>'] = {[[<cmd>lua require'dap'.step_out()<CR>]], "Step out"},
        ['<F9>'] = {[[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], "Toggle breakpoint"},
        ['<leader>'] = {
          d = {
            name = "Debug",
            r = {[[<cmd>lua require'dap'.repl.toggle()<CR>]], "Toggle REPL"},
            b = {[[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], "Toggle breakpoint"},
            B = {[[<cmd>lua require'dap'.clear_breakpoints()<CR>]], "Clear all breakpoints"},
            s = {
              name = "Show",
              s = {[[<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)]], "Show scopes"},
              e = {[[<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').expression)]], "Show expression"},
              t = {[[<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').threads)]], "Show threads"},
            }
          }
        }
      }
      require('which-key').register(map, opt)
    end
  }
}

return M
