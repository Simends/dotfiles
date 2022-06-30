local M = {
  packer = {
    autopairs = {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt" , "vim" },
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
          lua = {'string'},-- it will not add a pair on that treesitter node
          javascript = {'template_string'},
          java = false,-- don't check treesitter on java
        }
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
      -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
      -- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
    end
  },
  commentary = {
    'tpope/vim-commentary',
    requires = 'tpope/vim-repeat'
  },
  easyalign = {
    'junegunn/vim-easy-align',
    requires = 'tpope/vim-repeat',
    config = function ()
      vim.cmd[[nmap gl <plug>(EasyAlign)]]
      vim.cmd[[xmap gl <plug>(EasyAlign)]]
    end
  },
  radical = {
    'glts/vim-radical',
    requires = {'glts/vim-magnum', 'tpope/vim-repeat'}
  },
  speeddating = {
    'tpope/vim-speeddating',
    requires = 'tpope/vim-repeat'
  },
  sorround = {
    'tpope/vim-surround',
    requires = 'tpope/vim-repeat'
  },
  unimpaired = {
    'tpope/vim-unimpaired',
    requires = 'tpope/vim-repeat'
  },
  sneak = {
    'justinmk/vim-sneak',
    requires = 'tpope/vim-repeat',
    config = function ()
      vim.cmd('map , <plug>Sneak_;')
      vim.cmd('map ; <plug>Sneak_,')
    end
  },
  vmath = {
    'nixon/vim-vmath',
    config = function ()
      vim.cmd('vmap <expr>  ++  VMATH_YankAndAnalyse()')
      vim.cmd('nmap         ++  vip++)')
    end
  },
  apathy = {'tpope/apathy'},
  capslock = {'tpope/vim-capslock'},
  characterize = {'tpope/vim-characterize'},
  editorconfig = {'editorconfig/editorconfig-vim'},
  sleuth = {'tpope/vim-sleuth'},
  eunuch = {'tpope/vim-eunuch'},
  vinegar = {'tpope/vim-vinegar'},
  }
}

return M
