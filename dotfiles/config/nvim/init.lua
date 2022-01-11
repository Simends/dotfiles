
--   _   _                 _
--  | \ | | ___  _____   _(_)_ __ ___
--  |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
--  | |\  |  __/ (_) \ V /| | | | | | |
--  |_| \_|\___|\___/ \_/ |_|_| |_| |_|

require('config/settings')
require('config/commands')
require('config/keymaps')
require('config/statusline')

local plug = require('config.plugins')
local use = require('packer').use
require('packer').startup({
    function()
        -- The plugin manager
        use(plug.packer)

        -- Lsp
        use(plug.lspconfig)                 -- Turn neovim into an IDE
        use(plug.symbols_outline)           -- Show an outline of the code with the help from lsp
        use(plug.nvim_cmp)                  -- Autocompletions
        use(plug.luasnip)                   -- Snippets

        -- Treesitter
        use(plug.treesitter)                -- Complex syntax parser and highlighter
        use(plug.treesitter_textobjects)    -- Textobjects based on treesitter
        use(plug.treesitter_refactor)       -- Refactor code with treesitter
        -- use(plug.playground)                -- Show the AST of the current document
        use(plug.nvim_ts_rainbow)           -- Colored parantheses and brackets with treesitter

        -- Telescope
        use(plug.telescope)                 -- Better fuzzy finding
        use(plug.telescope_fzy_native)      -- Even faster telescope

        -- Git integration
        use(plug.gitsigns)                  -- Great git integration
        use(plug.fugitive)

        -- Motions
        use(plug.surround)                  -- Change brackets and brackets with a motion
        use(plug.commentary_vim)            -- Comment with a motion
        -- use(plug.surround_nvim)             -- Change parantheses and brackets with a motion
        -- use(plug.lightspeed)                -- Fast finding
        -- use(plug.navigator)

        -- use(plug.markdown_previw)           -- Powerful note previewing
        use(plug.mkdnflow)                  -- Better notetaking
        use(plug.devicons)                  -- Pretty filetype icons
        -- use(plug.lualine)                   -- A better statusline?
        use(plug.zen_mode)                  -- Distraction free writing
        -- use(plug.autosession)               -- Make vim remember
        -- use(plug.sniprun)                   -- Run a snippet
        use(plug.undotree)                  -- Visualize vims powerful revision history
        use(plug.nvim_tree)                 -- A typical file tree
        -- use(plug.neuron_nvim)
        use(plug.nnn)

        -- Colorschemes
        -- use(plug.tokyonight)
        -- use(plug.edge)
        use(plug.rose_pine)
        -- use(plug.gruvbox_material)
        -- use(plug.kanagawa)
    end,
    config = plug.packer_config
})
