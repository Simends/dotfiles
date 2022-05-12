

--   _   _                 _
--  | \ | | ___  _____   _(_)_ __ ___
--  |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
--  | |\  |  __/ (_) \ V /| | | | | | |
--  |_| \_|\___|\___/ \_/ |_|_| |_| |_|


vim.cmd("source $XDG_CONFIG_HOME/nvim/settings.vim")
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
    use.plugin('eunuch')
    use.plugin('vmath')
    use.plugin('indentguides')
    use.plugin('surround')                  -- Change brackets and brackets with a motion
    use.plugin('commentary')            -- Comment with a motion
    use.plugin('sneak')
    use.plugin('easyalign')
    use.plugin('speeddating')
    use.plugin('capslock')
    use.plugin('unimpaired')
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
    -- use.plugin('colorschemes.melange')
    -- use.plugin('colorschemes.rose_pine')
    -- use.plugin('colorschemes.gruvbox_material')
    -- use.plugin('colorschemes.tokyonight')

  end,
  config = require('plugins.packer').config
})
require('statusline')


-----------------------------------------
----------------- LANGS -----------------
-----------------------------------------

local nolint = {lsp = true, treesitter = true, dap = true, linter = false, formatter = true}
local lint = {lsp = true, treesitter = true, dap = true, linter = true, formatter = true}


use.lang('asm',        nolint)
use.lang('c',          nolint)
use.lang('python',     nolint)
-- use.lang('haskell',    nolint)
use.lang('lua',        nolint)
use.lang('fennel',     nolint)
-- use.lang('hdl',        nolint)
use.lang('makefile',   lint)
use.lang('dockerfile', nolint)
use.lang('sh',         lint)
use.lang('html',       nolint)
use.lang('javascript', nolint)
use.lang('css',        lint)
use.lang('json',       nolint)
use.lang('yaml',       nolint)
use.lang('latex',      nolint)
use.lang('markdown',   lint)


------------------------------------------
---------------- MAPPINGS ----------------
------------------------------------------

local opt = {noremap = true, silent = true}

local map = {
  ['<leader>'] = {
    r = {":e<cr>", "Reload buffer"},
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
      p = {
        name = "Packages",
        u = {require('packer').sync, "Update"},
        s = {require('packer').status, "Status"},
        p = {require('packer').profile, "Profile"},
      }
    }
  }
}

require('which-key').register(map, opt)
