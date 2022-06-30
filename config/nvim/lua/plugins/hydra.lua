
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
              border = 'rounded'
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

        local splits = require('smart-splits')
        window_hydra = Hydra({
          hint = [[
 ^^^^^^     Move     ^^^^^^   ^^    Size   ^^   ^^     Split
 ^^^^^^--------------^^^^^^   ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_   _H_ ^ ^ _L_    _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    ^   _<C-j>_   ^   _q_: close
 focus^^^^^^   window^^^^^^   ^_=_: equalize    ^ ^
 ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^    ^^ ^          ^   _b_: choose buffer 
]],
          name = 'Windows',
          config = {
            color = 'red',
            invoke_on_body = true,
            hint = {
              border = 'rounded',
              position = 'top-right'
            }
          },
          mode = 'n',
          body = '<c-w>',
          heads = {
            { 'h', '<C-w>h' },
            { 'j', '<C-w>j' },
            { 'k', [[<cmd>try | wincmd k | catch /^Vim\%((\a\+)\)\=:E11:/ | close | endtry<CR>]] },
            { 'l', '<C-w>l' },
            { 'H', '<Cmd>WinShift left<CR>' },
            { 'J', '<Cmd>WinShift down<CR>' },
            { 'K', '<Cmd>WinShift up<CR>' },
            { 'L', '<Cmd>WinShift right<CR>' },
            { 's', '<C-w>s' },
            { 'v', '<C-w>v' },
            { 'V', ':vsp | :term zsh<cr>i' },
            { 'S', ':sp | :term zsh<cr>i' },
            { '<C-h>', function() splits.resize_left(10)  end },
            { '<C-j>', function() splits.resize_down(10)  end },
            { '<C-k>', function() splits.resize_up(10)    end },
            { '<C-l>', function() splits.resize_right(10) end },
            { '=', '<C-w>=', { desc = 'equalize'} },
            { 'b', '<Cmd>BufExplorer<CR>', { exit = true, desc = 'choose buffer' } },
            { 'q', [[<Cmd>try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry<CR>]],
              { desc = 'close window' } },
            { '<Esc>', nil,  { exit = true, desc = false }}
          }
        })

        toggle_hydra = Hydra({
              name = 'Toggle',
              hint = [[
  _f_: File Explorer    _l_: Light mode     _t_: Todo comments    _n_: Line numbers
              ]],
              config = {
                color = 'red',
                invoke_on_body = true,
                hint = {
                  position = 'top-right',
                  border = 'rounded'
                }
              },
              mode = 'n',
              body = '<leader>t',
              heads = {
                { 'f', ':29Lexplore<cr>'},
                { 'l', 'ToggleLightMode<cr>'},
                { 't', [[<cmd>vimgrep /\C[TODO\|NOTE\|HACK\|FIXME\|BUG\|FIX\|ISSUE\|WARN\|PERF]: /jg **/*<cr>]]},
                { 'n', ':set nu!<cr>:set rnu!<cr>'},
              }
            })

        telescope_hydra = Hydra({
          name = 'Telescope',
          hint = [[

  _f_: Files      _m_: Marks              _o_: Old files   _g_: Live grep  
  _p_: Projects   _/_: Search in file     _h_: Vim help    _c_: Execute command  
  _b_: Buffers    _j_: Jumplist           _l_: Loclist     _q_: Quickfix  
  _H_: Higlights  _C_: Colorschemes       _M_: Manuals     _s_: Settings  
  _k_: Keymap     _;_: Commands history   _r_: Registers   _?_: Search history  

                _<Enter>_: Telescope           _<Esc>_: Exit 

]],
          config = {
            color = 'teal',
            invoke_on_body = true,
            hint = {
              position = 'top-right',
              border = 'rounded',
            },
          },
          mode = 'n',
          body = '<leader>f',
          heads = {
            { 'f', ':Telescope find_files<cr>' },
            { 'g', ':Telescope live_grep<cr>' },
            { 'h', ':Telescope help_tags<cr>', { desc = 'Vim help' } },
            { 'o', ':Telescope oldfiles<cr>', { desc = 'Recently opened files' } },
            { 'm', ':Telescope marks<cr>', { desc = 'Marks' } },
            { 'k', ':Telescope keymaps<cr>' },
            { 'r', ':Telescope registers<cr>' },
            { 'p', ':Telescope projects<cr>', { desc = 'Projects' } },
            { '/', ':Telescope current_buffer_fuzzy_find<cr>', { desc = 'Search in file' } },
            { '?', ':Telescope search_history<cr>',  { desc = 'Search history' } },
            { ';', ':Telescope command_history<cr>', { desc = 'Command-line history' } },
            { 'c', ':Telescope commands<cr>', { desc = 'Execute command' } },
            { 'b', ':Telescope buffers<cr>' },
            { 'j', ':Telescope jumplist<cr>' },
            { 'l', ':Telescope loclist<cr>' },
            { 'q', ':Telescope quickfix<cr>' },
            { 'H', ':Telescope highlights<cr>' },
            { 'C', ':Telescope colorscheme<cr>' },
            { 'M', ':Telescope man_pages<cr>' },
            { 's', ':Telescope vim_options<cr>' },
            { '<Enter>', ':Telescope<cr>', { exit = true, desc = 'List all pickers' } },
            { '<Esc>', nil, { exit = true, nowait = true } },
          }
        })
        local ok, which_key = pcall(require, 'which-key')
        if ok then
          local maps = {['<leader>'] = {
            w = {":lua window_hydra:activate()<cr>", "Windows"},
            d = {":lua dap_hydra:activate()<cr>", "Debug"},
            f = {":lua telescope_hydra:activate()<cr>", "Telescope"},
            t = {":lua toggle_hydra:activate()<cr>", "Toggle"},
          }}
          which_key.register(maps, {noremap = true, silent = true})
        end
      end
    }
  }
}

return M
