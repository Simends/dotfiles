
" Load Plugins

" Vimplug
call plug#begin('~/.local/share/vim-plug')

" Colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'tssm/fairyfloss.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

" Emacs-style undotree
Plug 'mbbill/undotree'

" Telescope fuzzy-finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Easily comment lines
Plug 'preservim/nerdcommenter'

" Format on the fly
Plug 'tommcdo/vim-lion'

" Change sorrounding characters
Plug 'tpope/vim-surround'

" Icons
Plug 'ryanoasis/vim-devicons'

" Quick overview of project
Plug 'preservim/nerdtree'|
            \ Plug 'Xuyuanp/nerdtree-git-plugin'|
            \ Plug 'PhilRunninger/nerdtree-visual-selection'|
            \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Git in vim
Plug 'tpope/vim-fugitive'

" Minimap
Plug 'wfxr/minimap.vim', { 'on': ['Minimap', 'MinimapToggle'] }

" TODO Debug in vim
Plug 'puremourning/vimspector', { 'on': ['<Plug>vimspector#Launch()', 'VimspectorInstall', 'VimspectorUpdate'] }

" Completion and more
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets in vim
Plug 'SirVer/ultisnips'

" Snippetengine for vim
Plug 'honza/vim-snippets'

" Tag list
Plug 'majutsushi/tagbar', { 'on': ['TagbarOpen', 'TagbarToggle'] }

" Better statusline
Plug 'hoob3rt/lualine.nvim'

" Maximize window
Plug 'szw/vim-maximizer'

" Search with two characters
Plug 'justinmk/vim-sneak'

" Better notetaking
Plug 'vimwiki/vimwiki'

call plug#end()

" Coc plugins
let g:coc_global_extensions = [ 'coc-json', 'coc-python', 'coc-tsserver', 'coc-snippets', 'coc-clangd', 'coc-sh', 'coc-diagnostic']
