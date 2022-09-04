

--   _   _                 _
--  | \ | | ___  _____   _(_)_ __ ___
--  |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
--  | |\  |  __/ (_) \ V /| | | | | | |
--  |_| \_|\___|\___/ \_/ |_|_| |_| |_|


vim.cmd("source $HOME/.vimrc")
local use = require('util.use')
require('util.bootstrap').packer()
require('packer').startup({
  function()


    -----------------------------------------
    ---------------- PLUGINS ----------------
    -----------------------------------------

    use.plugin('packer')                    -- Plugin manager
    use.plugin('editor')                    -- Editor
    use.plugin('lspconfig')                 -- Turn neovim into an IDE TODO: Fix depreceated function
    use.plugin('cmp')                       -- Completion
    use.plugin('treesitter')                -- Complex syntax parser and highlighter
    use.plugin('colorizer')
    use.plugin('telescope')                 -- Fuzzy finder
    use.plugin('dap')                       -- Debugger
    use.plugin('git')                       -- Git integration
    use.plugin('undotree')                  -- Visualize vims powerful revision history
    -- use.plugin('tmux')
    use.plugin('gps')                  -- Simple statusline component that shows what scope you are working inside
    -- use.plugin('autosession')
    use.plugin('windows')                   -- Improved window management
    -- use.plugin('hlslens')
    use.plugin('qf_helper')                 -- Better quickfix and loclist
    -- use.plugin('scrollbar')
    use.plugin('devicons')                  -- Pretty filetype icons
    use.plugin('which_key')                 -- Remember all the keybindings
    use.plugin('mkdnflow')                -- Better notetaking TODO: Something wrongmk
    use.plugin('vimtex')
    use.plugin('hydra')

    -- Colorschemes
    use.plugin('colorschemes.kanagawa')
    use.plugin('colorschemes.everforest')

  end,
  config = require('plugins.packer').config
})
require('statusline')
require('neovide')
vim.cmd('colorscheme everforest')


-----------------------------------------
----------------- LANGS -----------------
-----------------------------------------

use.lang('asm',           {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('c',             {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('python',        {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
-- use.lang('haskell',    nolint)
use.lang('lua',           {lsp = true,  treesitter = true,  dap = false,  linter = false,   formatter = true})
use.lang('fennel',        {lsp = false, treesitter = true,  dap = false,  linter = false,   formatter = true})
use.lang('vim',           {lsp = true,  treesitter = true,  dap = false,  linter = false,   formatter = false})
use.lang('zig',           {lsp = true,  treesitter = true,  dap = false,  linter = false,   formatter = false})
-- use.lang('hdl',        nolint)
use.lang('makefile',      {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('dockerfile',    {lsp = false, treesitter = true,  dap = false,  linter = false,   formatter = true})
use.lang('sh',            {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('html',          {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('javascript',    {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('css',           {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('json',          {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('yaml',          {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('latex',         {lsp = false, treesitter = true,  dap = false,  linter = false,   formatter = true})
use.lang('markdown',      {lsp = false, treesitter = true,  dap = false,  linter = false,   formatter = true})


------------------------------------------
---------------- MAPPINGS ----------------
------------------------------------------

local opt = {noremap = true, silent = true}

local map = {
  ['<leader>'] = {
    r = {":e<cr>", "Reload buffer"},
    R = {":so ~/.vimrc<cr>", "Reload vimrc"},

    n = {
      name = "Notes",
      t = {"<cmd>vimgrep /^##* / %<cr>", "Show table of contents"},
      s = {
        name = "Spell",
        n = {"<cmd>setlocal spelllang=nb<cr>", "Set language to Norwegian Bokmål"},
        N = {"<cmd>setlocal spelllang=nn<cr>", "Set language to Norwegian Nynorsk"},
        e = {"<cmd>setlocal spelllang=en<cr>", "Set language to English"},
      }
    },

    e = {
      name = 'Edit',
      w = {[[mz:%s/\s\+$//e<cr>`z:delmarks z<cr>]], "Trim trialing whitespace"},
      p = {":e /tmp/scratchpad<cr>", "Open scratchpad"},
    },

    t = {
      name = 'Toggle',
      f = {':29Lexplore<cr>', 'File explorer'},
      l = {':ToggleLightMode<cr>', 'Light mode'},
      c = {':ColorizerToggle<cr>', 'Colorizer'},
      n = {':set nu!<cr>:set rnu!<cr>', 'Line numbering'}
    },

    h = {
      name = "Support",
      c = {"<cmd>checkhealth<cr>", "Check health"},
      t = {":tabnew | :TSModuleInfo<cr>", "Treesitter info"},
      v = {":e ~/.vimrc<cr>", "Edit vimrc"},
      p = {
        name = "Packages",
        u = {require('packer').sync, "Update"},
        s = {require('packer').status, "Status"},
        p = {require('packer').profile, "Profile"},
      }
    }
  },
  ['ø'] = {require('telescope.builtin').find_files, "files"},
  ['æ'] = {require('telescope.builtin').live_grep, "grep"}
}

require('which-key').register(map, opt)
