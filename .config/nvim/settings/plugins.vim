
" Load Plugins

" Vimplug
call plug#begin('~/.local/share/vim-plug')

" Colorschemes
" Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'tssm/fairyfloss.vim'
" Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

" Emacs-style undotree
Plug 'mbbill/undotree'

" Plug 'skanehira/docker.vim'

" Telescope fuzzy-finder
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" Easily comment lines
Plug 'preservim/nerdcommenter'

" Format on the fly
" Plug 'tommcdo/vim-lion'

" Change sorrounding characters
" Plug 'tpope/vim-surround'

" Easy search
" Plug 'justinmk/vim-sneak'

" Icons
Plug 'ryanoasis/vim-devicons'

" Quick overview of project
Plug 'preservim/nerdtree'|
            \ Plug 'Xuyuanp/nerdtree-git-plugin'|
            \ Plug 'PhilRunninger/nerdtree-visual-selection'|
            \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Git in vim
" Plug 'tpope/vim-fugitive'

" Minimap
Plug 'wfxr/minimap.vim', { 'on': ['Minimap', 'MinimapToggle'] }

" TODO Debug in vim
" Plug 'puremourning/vimspector', { 'on': ['<Plug>vimspector#Launch()', 'VimspectorInstall', 'VimspectorUpdate'] }

" Snippets in vim
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" Tag list
" Plug 'majutsushi/tagbar', { 'on': ['TagbarOpen', 'TagbarToggle'] }

" Better statusline
Plug 'hoob3rt/lualine.nvim'

" Maximize window
" Plug 'szw/vim-maximizer'

" Better notetaking
Plug 'vimwiki/vimwiki'
Plug 'tools-life/taskwiki'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'godlygeek/tabular'|
            \ Plug 'plasticboy/vim-markdown'

" Zen-mode in vim
Plug 'junegunn/goyo.vim'

" TODO Show list of available keybindings
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Coc
" Extensions written in TS need to be installed with yarn

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}      " Adding snippets for vim
" Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}      " Autoformating
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}      " Server for JS and TS
" Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}          " Server for JSON
" Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}          " Server for C, C++, C#
" Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}    " Server for python3
" Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}              " Server for bash, zsh, posix sh, etc.
" Plug 'iamcco/coc-diagnostic', {'do': 'yarn install --frozen-lockfile'}      " Server for diagnostic

call plug#end()
