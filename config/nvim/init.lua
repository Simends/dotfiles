

--   _   _                 _
--  | \ | | ___  _____   _(_)_ __ ___
--  |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
--  | |\  |  __/ (_) \ V /| | | | | | |
--  |_| \_|\___|\___/ \_/ |_|_| |_| |_|


vim.cmd("source $HOME/.vimrc")
vim.cmd('colorscheme kanagawa')
local use = require('util.use')
require('util.bootstrap').packer()
require('packer').startup({
  function()


    -----------------------------------------
    ---------------- PLUGINS ----------------
    -----------------------------------------

    -- Plugin manager
    use.plugin('packer')

    -- Lsp
    use.plugin('lspconfig')                 -- Turn neovim into an IDE TODO: Fix depreceated function
    use.plugin('null_ls')                   -- Attach linters and formatters to lsp
    use.plugin('symbols_outline')           -- Show an outline of the code with the help from lsp
    use.plugin('fidget')                    -- Show Lsp Status
    use.plugin('lightbulb')                 -- Show Code Action Status

    -- Completion
    use.plugin('nvim_cmp')

    -- Snippets
    use.plugin('luasnip')

    -- Syntax
    use.plugin('treesitter')                -- Complex syntax parser and highlighter
    use.plugin('treesitter_textobjects')    -- Textobjects based on treesitter
    use.plugin('treesitter_refactor')       -- Refactor code with treesitter
    use.plugin('treesitter_playground')                -- Show the AST of the current document
    use.plugin('spellsitter')
    use.plugin('rainbow_parentheses')           -- Colored parantheses and brackets with treesitter
    use.plugin('colorizer')

    -- Fuzzy finder
    use.plugin('telescope')

    -- Debugger
    use.plugin('dap')
    use.plugin('telescope-dap')
    use.plugin('dap-virtual-text')

    -- Git integration
    use.plugin('gitsigns')
    use.plugin('fugitive')

    -- Editor
    use.plugin('autopairs')
    use.plugin('apathy')
    use.plugin('capslock')
    use.plugin('characterize')
    use.plugin('commentary')            -- Comment with a motion
    use.plugin('eunuch')
    use.plugin('speeddating')
    use.plugin('surround')                  -- Change brackets and brackets with a motion
    use.plugin('unimpaired')
    use.plugin('easyalign')
    use.plugin('sneak')
    use.plugin('vmath')
    use.plugin('radical')
    use.plugin('indentguides')
    use.plugin('undotree')                  -- Visualize vims powerful revision history

    -- Statusline
    use.plugin('gps')                  -- Simple statusline component that shows what scope you are working inside

    -- Session
    use.plugin('autosession')

    -- File manager
    use.plugin('vinegar')

    -- Windows and splits
    use.plugin('focus')
    use.plugin('zen_mode')

    -- UI Improvements
    use.plugin('dressing')                  -- Telescope more places and better ui
    use.plugin('hlslens')
    use.plugin('qf_helper')                 -- Better quickfix and loclist
    use.plugin('scrollbar')
    use.plugin('devicons')                  -- Pretty filetype icons

    -- Keybindings
    use.plugin('which_key')                 -- Remember all the keybindings

    -- Notation
    use.plugin('mkdnflow')                -- Better notetaking TODO: Something wrongmk
    use.plugin('vimtex')

    -- Colorschemes
    use.plugin('colorschemes.kanagawa')
    use.plugin('colorschemes.melange')
    use.plugin('colorschemes.catpuccin')
    use.plugin('colorschemes.rose_pine')
    use.plugin('colorschemes.gruvbox_material')
    use.plugin('colorschemes.tokyonight')

  end,
  config = require('plugins.packer').config
})
require('statusline')


-----------------------------------------
----------------- LANGS -----------------
-----------------------------------------

local nolint = {lsp = true, treesitter = true, dap = true, linter = false, formatter = true}
local lint = {lsp = true, treesitter = true, dap = true, linter = true, formatter = true}
local light = {lsp = false, treesitter = true, dap = false, linter = false, formatter = true}


use.lang('asm',           {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('c',             {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
use.lang('python',        {lsp = true,  treesitter = true,  dap = true,   linter = false,   formatter = true})
-- use.lang('haskell',    nolint)
use.lang('lua',           {lsp = false, treesitter = true,  dap = false,  linter = false,   formatter = true})
use.lang('fennel',        {lsp = false, treesitter = true,  dap = false,  linter = false,   formatter = true})
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
    p = {":e /tmp/scratchpad<cr>", "Open scratchpad"},
    w = {[[mz:%s/\s\+$//e<cr>`z:delmarks z<cr>]], "Trim trialing whitespace"},

    m = {
      name = "Make",
      m = {"<cmd>make<cr>", "Make project"},
    },

    t = {
      name = "Toggle",
      t = {[[<cmd>vimgrep /\C[TODO\|NOTE\|HACK\|FIXME\|BUG\|FIX\|ISSUE\|WARN\|PERF]: /jg **/*<cr>]], "Show comments"},
      n = {":set nu!<cr>:set rnu!<cr>", "Linenumbers"},
      o = {":set cc=80<cr>", "Show colorcolumn"},
      O = {":set cc=0<cr>", "Hide colorcolumn"},
    },

    h = {
      name = "Support",
      c = {"<cmd>checkhealth<cr>", "Check health"},
      v = {":e ~/.vimrc<cr>", "Edit vimrc"},
      p = {
        name = "Packages",
        u = {require('packer').sync, "Update"},
        s = {require('packer').status, "Status"},
        p = {require('packer').profile, "Profile"},
      }
    }
  },
  ['æ'] = {require('telescope.builtin').find_files, "files"},
  ['ø'] = {require('telescope.builtin').live_grep, "grep"}
}

require('which-key').register(map, opt)
