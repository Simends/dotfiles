local g = vim.g -- G-values
local set = vim.opt -- Vim options

-- Line number
set.relativenumber = true
set.number = true

-- Search
set.ignorecase = true
set.smartcase = true
set.hlsearch = true

-- Prompts
set.confirm = true
set.visualbell = false
set.errorbells = false

-- History
set.history = 1000
set.undofile = true
set.hidden = true
set.backup = false
set.writebackup = false
set.swapfile = false

-- Tabs
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true

-- Wildmenu
set.wildmenu = true
set.wildmode = 'full'

-- Better splits
set.splitbelow = true
set.splitright = true

set.colorcolumn = '80'
set.showtabline = 1
set.linebreak = true
set.wrap = false
set.ruler = false
set.scrolloff = 10
set.updatetime = 50
set.fileencoding = 'UTF-8'
set.showmode = true
set.termguicolors = true
-- set.signcolumn = 'yes'
set.cursorline = true
-- set.cmdheight = 1
set.mouse = 'a'
set.background = 'dark'
set.path = '**'
set.conceallevel = 2
set.foldmethod = 'expr'
set.foldexpr = 'nvim_treesitter#foldexpr()'
set.shell = "/bin/sh"
vim.cmd([[filetype plugin indent on]])
set.lazyredraw = true
set.laststatus = 2
set.modeline = true
-- vim.env.EDITOR = 'nvr -l'
-- vim.env.VISUAL = 'nvr -l'
-- vim.env.GIT_EDITOR = 'nvr --remote-wait'
set.shortmess:append('cI')
-- go.completeopt = "menuone,noselect,noinsert,preview"
set.sessionoptions="blank,curdir,help,tabpages,options,folds,winsize,resize,winpos,terminal"

-- Netrw settings
-- g.netrw_banner = 0        -- disable annoying banner
-- g.netrw_browse_split = 4  -- open in prior window
-- g.netrw_altv = 1          -- open splits to the right
-- vim.g.netrw_liststyle = 3     -- tree view
-- g.netrw_list_hide = 'netrw_gitignore#Hide()'
-- vim.g.netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

-- Markdown settings
g.markdown_fenced_languages = {'c', 'python', 'lua', 'cpp', 'bash', 'vhdl', 'javascript', 'html', 'css'}

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}
for _, plugin in pairs(disabled_built_ins) do vim.g["loaded_" .. plugin] = 1 end

