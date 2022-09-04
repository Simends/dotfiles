
    -- ⠄⠄⣴⣶⣤⡤⠦⣤⣀⣤⠆⠄⠄⠄⠄⠄⣈⣭⣭⣿⣶⣿⣦⣼⣆⠄⠄⠄⠄⠄⠄⠄⠄ --
    -- ⠄⠄⠄⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦⠄⠄⠄⠄⠄⠄ --
    -- ⠄⠄⠄⠄⠄⠈⠄⠄⠄⠈⢿⣿⣟⠦⠄⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄⠄⠄⠄⠄ --
    -- ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⢧⠄⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄⠄⠄⠄ --
    -- ⠄⠄⢀⠄⠄⠄⠄⠄⠄⢠⣿⣿⣿⠈⠄⠄⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀⠄⠄ --
    -- ⠄⠄⢠⣧⣶⣥⡤⢄⠄⣸⣿⣿⠘⠄⠄⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄⠄ --
    -- ⠄⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷⠄⠄⠄⢊⣿⣿⡏⠄⠄⢸⣿⣿⡇⠄⢀⣠⣄⣾⠄⠄⠄ --
    -- ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀⠄⢸⢿⣿⣿⣄⠄⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄⠄ --
    -- ⠙⠃⠄⠄⠄⣼⣿⡟⠌⠄⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⠐⣿⣿⡇⠄⠛⠻⢷⣄ --
    -- ⠄⠄⠄⠄⠄⢻⣿⣿⣄⠄⠄⠄⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟⠄⠫⢿⣿⡆⠄⠄⠄⠁ --
    -- ⠄⠄⠄⠄⠄⠄⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃⠄⠄⠄⠄ --
    -- ⠄⠄⠄⠄⢰⣶⠄⠄⣶⠄⢶⣆⢀⣶⠂⣶⡶⠶⣦⡄⢰⣶⠶⢶⣦⠄⠄⣴⣶⠄⠄⠄⠄ --
    -- ⠄⠄⠄⠄⢸⣿⠶⠶⣿⠄⠈⢻⣿⠁⠄⣿⡇⠄⢸⣿⢸⣿⢶⣾⠏⠄⣸⣟⣹⣧⠄⠄⠄ --
    -- ⠄⠄⠄⠄⠸⠿⠄⠄⠿⠄⠄⠸⠿⠄⠄⠿⠷⠶⠿⠃⠸⠿⠄⠙⠷⠤⠿⠉⠉⠿⠆⠄⠄ --


local M = {
  packer = {
    hydra = {
      'anuvyklack/hydra.nvim', 
      as = 'hydra',
      requires = 'anuvyklack/keymap-layer.nvim', -- needed only for pink hydras
      config = function()
        local Hydra = require('hydra')
        local gitsigns = require('gitsigns')
        local dap = require('dap')
        local telescope = require('telescope')

        Hydra({
          name = 'Side scroll',
          mode = 'n',
          body = 'z',
          heads = {
            { 'h', '5zh' },
            { 'l', '5zl', { desc = '←/→' } },
            { 'H', 'zH' },
            { 'L', 'zL', { desc = 'half screen ←/→' } },
          }
        })

        git_hydra = Hydra({ -- Git Hydra
          hint = [[

  _J_: Next hunk   _s_: Stage hunk        _d_: Show deleted   _b_: Blame line  
  _K_: Prev hunk   _u_: Undo stage hunk   _p_: Preview hunk   _B_: BLame show full  
  _r_: Branches    _S_: Stage buffer      ^ ^                 _/_: Show base file  
  _c_: Commit      _C_: Show commits      _t_: Status         _T_: Stash  
 ^
 ^ ^              _<Enter>_: Fugitive              _<Esc>_: Exit  

]],
          name = 'Git',
          config = {
            color = 'pink',
            invoke_on_body = true,
            hint = {
              position = 'top-right',
              border = 'rounded'
            },
            on_enter = function()
              vim.bo.modifiable = false
              gitsigns.toggle_signs(true)
              gitsigns.toggle_linehl(true)
            end,
            on_exit = function()
              gitsigns.toggle_signs(true)
              gitsigns.toggle_linehl(false)
              gitsigns.toggle_deleted(false)
              vim.cmd 'echo' -- clear the echo area
            end
          },
          mode = {'n','x'},
          body = '<leader>g',
          heads = {
            { 'J', function()
              if vim.wo.diff then return ']c' end
              vim.schedule(function() gitsigns.next_hunk() end)
              return '<Ignore>'
            end, { expr = true } },
            { 'K', function()
              if vim.wo.diff then return '[c' end
              vim.schedule(function() gitsigns.prev_hunk() end)
              return '<Ignore>'
            end, { expr = true } },
            { 'r', ':Telescope git_branches<cr>'},
            { 'C', ':Telescope git_commits<cr>'},
            { 't', ':Telescope git_status<cr>'},
            { 'T', ':Telescope git_stash<cr>'},
            { 'c', ':Git commit<cr>'},
            { 's', ':Gitsigns stage_hunk<CR>', { silent = true } },
            { 'u', gitsigns.undo_stage_hunk },
            { 'S', gitsigns.stage_buffer },
            { 'p', gitsigns.preview_hunk },
            { 'd', gitsigns.toggle_deleted, { nowait = true } },
            { 'b', gitsigns.blame_line },
            { 'B', function() gitsigns.blame_line{ full = true } end },
            { '/', gitsigns.show, { exit = true } }, -- show the base of the file
            { '<Enter>', '<cmd>Git<CR>', { exit = true } },
            { '<Esc>', nil, { exit = true, nowait = true } },
          }
        })

        dap_hydra = Hydra({ -- DAP Hydra
          hint = [[

  ^^Run             ^^Breakpoints     ^^Show
  ^^------------    ^^------------    ^^---------
  _H_: Step Out     _b_: Toggle       _v_ariables  
  _J_: Step into    _B_: List         _f_rames  
  _K_: Step Over    _c_: Clear all    _C_ommands
  _L_: Continue  
 ^
 ^ ^_<Enter>_: Repl       _<Esc>_: exit  

]],
          name = 'Debugger',
          config = {
            color = 'pink',
            invoke_on_body = false,
            hint = {
              position = 'top-right',
              border = 'single'
            },
            on_enter = function()
              vim.bo.modifiable = false
            end
          },
          mode = {'n','x'},
          body = '<leader>d',
          heads = {
            { 'H', dap.step_out },
            { 'J', dap.step_into },
            { 'K', dap.step_over },
            { 'L', dap.continue },
            { 'b', dap.toggle_breakpoint },
            { 'B', ':Telescope dap list_breakpoints<cr>' },
            { 'c', dap.clear_breakpoints },
            { 'v', ':Telescope dap variables<cr>' },
            { 'f', ':Telescope dap frames<cr>' },
            { 'C', ':Telescope dap commands<cr>' },
            { '<Enter>', dap.repl.toggle, { exit = true } },
            { '<Esc>', dap.terminate, { exit = true, nowait = true } },
          }
        })

        local ok, which_key = pcall(require, 'which-key')
        if ok then
          local maps = {['<leader>'] = {
            g = {":lua git_hydra:activate()<cr>", "Git"},
            d = {":lua dap_hydra:activate()<cr>", "Debug"},
          }}
          which_key.register(maps, {noremap = true, silent = true})
        end
      end
    }
  }
}

return M
