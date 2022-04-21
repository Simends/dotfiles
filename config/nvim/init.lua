
--   _   _                 _
--  | \ | | ___  _____   _(_)_ __ ___
--  |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
--  | |\  |  __/ (_) \ V /| | | | | | |
--  |_| \_|\___|\___/ \_/ |_|_| |_| |_|

require('config/statusline')
vim.cmd("source $XDG_CONFIG_HOME/nvim/settings.vim")

local plug = require('config.plugins')
local use = require('packer').use
require('packer').startup({
  function()

    ---- PLUGINS ----

    -- The plugin manager
    use(plug.packer)

    -- Lsp
    use(plug.lspconfig)                 -- Turn neovim into an IDE
    use(plug.symbols_outline)           -- Show an outline of the code with the help from lsp
    use(plug.nvim_cmp)                  -- Autocompletions
    use(plug.luasnip)                   -- Snippets
    use(plug.fidget)                    -- Show Lsp Status
    use(plug.lightbulb)                 -- Show Code Action Status

    -- Treesitter
    use(plug.treesitter)                -- Complex syntax parser and highlighter
    use(plug.treesitter_textobjects)    -- Textobjects based on treesitter
    use(plug.treesitter_refactor)       -- Refactor code with treesitter
    -- use(plug.playground)                -- Show the AST of the current document
    use(plug.nvim_ts_rainbow)           -- Colored parantheses and brackets with treesitter
    use(plug.nvim_gps)                  -- Simple statusline component that shows what scope you are working inside

    -- Telescope
    use(plug.telescope)                 -- Better fuzzy finding
    use(plug.telescope_fzy_native)      -- Even faster telescope

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
    use(plug.dressing)                  -- Telescope more places
    use(plug.indentguides)
    use(plug.qf_helper)                 -- Better quickfix and loclist
    use(plug.devicons)                  -- Pretty filetype icons
    use(plug.zen_mode)                  -- Distraction free writing
    use(plug.undotree)                  -- Visualize vims powerful revision history

    -- Notation
    use(plug.mkdnflow)                  -- Better notetaking
    use(plug.vimtex)
    -- use(plug.nvim_tree)                 -- A typical file tree

    -- Colorschemes
    -- use(plug.tokyonight)
    -- use(plug.edge)
    use(plug.rose_pine)
    -- use(plug.gruvbox_material)
    -- use(plug.kanagawa)
  end,
  config = plug.packer_config
})

local opt = {noremap = true, silent = true, prefix = "<leader>"}

---- MAPPINGS ----

local map = {
  t = {
    name = "Toggle",
    t = {[[<cmd>vimgrep /\C[TODO\|NOTE\|HACK\|FIXME\|BUG\|FIX\|ISSUE\|WARN\|PERF]: /jg **/*<cr>]], "Show comments"},
    u = {"<cmd>UndotreeToggle<cr>", "Undotree"},
    z = {"<cmd>ZenMode<cr>", "Zenmode"},
    i = {"<cmd>IndentBlanklineToggle<cr>", "Indent guides"},
    I = {"<cmd>IndentBlanklineToggle!<cr>", "Indent guides globally"}
  },
  f = {
    name = "Find",
    f = {"<cmd>Telescope find_files<cr>", "Files"},
    g = {"<cmd>Telescope live_grep<cr>", "Grep"},
    p = {"<cmd>Telescope repo list<cr>", "Git repos"},
    b = {"<cmd>Telescope buffers<cr>", "Buffers"},
    j = {"<cmd>Telescope jumplist<cr>", "Jumplist"},
    q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
    l = {"<cmd>Telescope loclist<cr>", "Loclist"},
    c = {"<cmd>Telescope command_history<cr>", "Commands"}
  },
  h = {
    name = "Support",
    c = {"<cmd>checkhealth<cr>", "Check health"},
    h = {"<cmd>Telescope help_tags<cr>", "Documentation"},
    m = {"<cmd>Telescope man_pages<cr>", "Manuals"},
    p = {
      name = "Packages",
      u = {"<cmd>PackerSync<cr>", "Update"},
      s = {"<cmd>PackerStatus<cr>", "Status"},
      p = {"<cmd>PackerProfile<cr>", "Profile"},
    }
  }
}

require('which-key').register(map, opt)
