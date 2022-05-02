

--   _   _                 _
--  | \ | | ___  _____   _(_)_ __ ___
--  |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
--  | |\  |  __/ (_) \ V /| | | | | | |
--  |_| \_|\___|\___/ \_/ |_|_| |_| |_|


require('statusline')
vim.cmd("source $XDG_CONFIG_HOME/nvim/settings.vim")
local plug = require('plugins')
local use = require('packer').use
require('packer').startup({
  function()


    -----------------------------------------
    ---------------- PLUGINS ----------------
    -----------------------------------------

    -- The plugin manager
    use(plug.packer)

    -- Lsp
    use(plug.lspconfig)                 -- Turn neovim into an IDE TODO: Fix depreceated function
    use(plug.null_ls)                   -- Attach linters and formatters to lsp
    use(plug.symbols_outline)           -- Show an outline of the code with the help from lsp
    use(plug.nvim_cmp)                  -- Autocompletions
    use(plug.luasnip)                   -- Snippets
    use(plug.fidget)                    -- Show Lsp Status
    use(plug.lightbulb)                 -- Show Code Action Status

    -- Treesitter
    use(plug.treesitter)                -- Complex syntax parser and highlighter
    use(plug.treesitter_textobjects)    -- Textobjects based on treesitter
    use(plug.treesitter_refactor)       -- Refactor code with treesitter
    use(plug.playground)                -- Show the AST of the current document
    use(plug.nvim_ts_rainbow)           -- Colored parantheses and brackets with treesitter
    use(plug.nvim_gps)                  -- Simple statusline component that shows what scope you are working inside

    -- Telescope
    use(plug.telescope)                 -- Better fuzzy finding
    use(plug.telescope_fzf_native)      -- Native FZF sorter
    -- use(plug.telescope_fzy_native)      -- Native FZY sorter
    use(plug.dressing)                  -- Telescope more places and better ui

    -- Debugger
    use(plug.dap)
    use(plug.dap_virtual_text)
    use(plug.telescope_dap)

    -- Git integration
    use(plug.gitsigns)                  -- Great git integration
    use(plug.fugitive)
    use(plug.telescope_repo)            -- Jump into the repositories of your filesystem

    -- Motions
    use(plug.surround)                  -- Change brackets and brackets with a motion
    use(plug.commentary_vim)            -- Comment with a motion
    use(plug.sneak)

    -- UI
    use(plug.which_key)                 -- Remember all the keybindings
    use(plug.hlslens)
    use(plug.scrollbar)
    use(plug.colorizer)
    use(plug.indentguides)
    use(plug.qf_helper)                 -- Better quickfix and loclist
    use(plug.devicons)                  -- Pretty filetype icons
    use(plug.zen_mode)                  -- Distraction free writing
    use(plug.undotree)                  -- Visualize vims powerful revision history
    use(plug.dirbuf)
    use(plug.autopairs)

    -- Notation
    use(plug.mkdnflow)                  -- Better notetaking TODO: Something wrong
    use(plug.vimtex)
    -- use(plug.nvim_tree)                 -- A typical file tree

    -- Colorschemes
    -- use(plug.tokyonight)
    -- use(plug.edge)
    -- use(plug.rose_pine)
    -- use(plug.gruvbox_material)
    use(plug.kanagawa)
  end,
  config = plug.packer_config
})

local opt = {noremap = true, silent = true}


------------------------------------------
---------------- MAPPINGS ----------------
------------------------------------------

local map = {
  g = {
    d = {[[<cmd>lua vim.lsp.buf.definition()<cr>]], "Goto definition"},
    D = {[[<cmd>lua vim.lsp.buf.declaration()<cr>]], "Goto declaration"},
    i = {[[<cmd>lua vim.lsp.buf.implementation()<cr>]], "Goto implementation"},
    r = {[[<cmd>lua vim.lsp.buf.references()<cr>]], "Goto references"},
    ['['] = {[[<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>]], "Goto previous diagnostic"},
    [']'] = {[[<cmd>lua vim.lsp.diagnostic.goto_next()<cr>]], "Goto next diagnostic"},
    ['{'] = {"<cmd>Gitsigns prev_hunk<cr>", "Next git hunk"},
    ['}'] = {"<cmd>Gitsigns next_hunk<cr>", "Previous git hunk"}
  },

  ['<leader>'] = {
    l = {"o<esc>k0", "New line below"},
    L = {"O<esc>j0", "New line above"},
    r = {":e<cr>", "Reload buffer"},

    D = {
      name = "Directory",
      D = {"<cmd>Dirbuf<cr>", "Open directory"},
      s = {"<cmd>DirbufSync -confirm<cr>", "Sync directory"},
      p = {"<cmd>Dirbuf %<cr>", "Open parent directory"},
      q = {"<cmd>DirbufQuit<cr>", "Close directory"},
    },

    m = {
      name = "Make",
      m = {"<cmd>make<cr>", "Make project"},
    },

    t = {
      name = "Toggle",
      a = {"<cmd>TSPlaygroundToggle<cr>", "Abstract syntax tree browser"},
      c = {"<cmd>ColorizerToggle<cr>", "Colorizer"},
      h = {"<cmd>HlSearchLensToggle<cr>", "Hlsearch Lens"},
      t = {[[<cmd>vimgrep /\C[TODO\|NOTE\|HACK\|FIXME\|BUG\|FIX\|ISSUE\|WARN\|PERF]: /jg **/*<cr>]], "Show comments"},
      n = {":set nu!<cr>:set rnu!<cr>", "Linenumbers"},
      o = {":set cc=80<cr>", "Show colorcolumn"},
      O = {":set cc=0<cr>", "Hide colorcolumn"},
      u = {"<cmd>UndotreeToggle<cr>", "Undotree"},
      z = {"<cmd>ZenMode<cr>", "Zenmode"},
      i = {"<cmd>IndentBlanklineToggle<cr>", "Indent guides"},
      I = {"<cmd>IndentBlanklineToggle!<cr>", "Indent guides globally"},
      s = {"<cmd>ScrollbarToggle<cr>", "Scrollbar"},
    },

    e = {
      name = "LSP",
      o = {[[<cmd>SymbolsOutline<cr>]], "Show symbols"},
      O = {[[<cmd>Telescope lsp_workspace_symbols<cr>]], "Find symbols"},
      e = {[[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>]], "Show diagnostic"},
      d = {[[<cmd>lua vim.lsp.diagnostic.set_qflist()<cr>]], "Show all diagnostics"},
      n = {[[<cmd>lua vim.lsp.buf.rename()<cr>]], "Rename"},
      s = {[[<cmd>lua vim.lsp.buf.signature_help()<cr>]], "Show signature"},
      l = {[[<cmd>lua vim.lsp.codelens.display()<cr>]], "Show codelens"},
      L = {[[<cmd>lua vim.lsp.codelens.run()<cr>]], "Run codelens"},
      f = {[[<cmd>lua vim.lsp.buf.formatting()<cr>]], "Format buffer"},
      a = {[[<cmd>lua vim.lsp.buf.code_action()<cr>]], "Code actions"}
    },

    f = {
      name = "Find",
      b = {"<cmd>Telescope buffers<cr>", "Buffers"},
      c = {"<cmd>Telescope command_history<cr>", "Commands"},
      f = {"<cmd>Telescope find_files<cr>", "Files"},
      g = {"<cmd>Telescope live_grep<cr>", "Grep"},
      j = {"<cmd>Telescope jumplist<cr>", "Jumplist"},
      p = {"<cmd>Telescope repo list<cr>", "Git repos"},
      l = {"<cmd>Telescope loclist<cr>", "Loclist"},
      m = {"<cmd>Telescope marks<cr>", "Marks"},
      q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
      s = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Symbols"}
    },

    g = {
      name = "Git",
      b = {"<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle line blame"},
      g = {"<cmd>Git<cr>", "Fugitive"},
      c = {"<cmd>Git commit<cr>", "Commit"},
      s = {
        name = "Show",
        l = {"<cmd>Gitsigns setqflist<cr>", "Show all hunks"},
        c = {"<cmd>Telescope git_commits<cr>", "Show all commits"},
        C = {"<cmd>Telescope git_bcommits<cr>", "Show all buffer commits"},
        b = {"<cmd>Telescope git_branches<cr>", "Show branches"},
        s = {"<cmd>Telescope git_status<cr>", "Show status"},
        S = {"<cms>Telescope git_stash<cr>", "Show stash"},
      },
      h = {
        name = "Hunk",
        s = {"<cmd>Gitsigns stage_hunk<cr>", "Stage"},
        u = {"<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage"},
        r = {"<cmd>Gitsigns reset_hunk<cr>", "Reset"},
        R = {"<cmd>Gitsigns reset_buffer<cr>", "Reset buffer"},
        p = {"<cmd>Gitsigns preview_hunk<cr>", "Preview"}
      }
    },

    w = {
      name = "Window",
      n = {"<C-w>h", "Left"},
      e = {"<C-w>j", "Down"},
      i = {"<C-w>k", "Up"},
      o = {"<C-w>l", "Right"},
      h = {"<C-w>s", "Horizontal Split"},
      v = {"<C-w>v", "Vertical Split"}
    },
    -- i = {
    -- name = "Insert",
    -- TODO: Template
    -- },
    --
    h = {
      name = "Support",
      c = {"<cmd>checkhealth<cr>", "Check health"},
      t = {"<cmd>TSModuleInfo<cr>", "Treesitter"},
      h = {"<cmd>Telescope help_tags<cr>", "Documentation"},
      m = {"<cmd>Telescope man_pages<cr>", "Manuals"},
      s = {"<cmd>Telescope vim_options<cr>", "Settings"},
      p = {
        name = "Packages",
        u = {"<cmd>PackerSync<cr>", "Update"},
        s = {"<cmd>PackerStatus<cr>", "Status"},
        p = {"<cmd>PackerProfile<cr>", "Profile"},
      }
    }
  },

  I = {'<cmd>lua vim.lsp.buf.hover()<CR>', "Hover"}
}

require('which-key').register(map, opt)
