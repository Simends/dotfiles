

" Settings

filetype plugin indent on
" syntax on

set number
set relativenumber

set ignorecase
set smartcase
set hlsearch
set incsearch

set confirm
set novisualbell
set noerrorbells

set history=1000
set undofile
set hidden
set nobackup
set nowritebackup
set noswapfile

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

set wildmenu
set wildmode=full

set colorcolumn=80
set showtabline=1
set linebreak
set nowrap
set noruler
set scrolloff=10
set updatetime=50
set fileencoding=UTF-8
set showmode
set termguicolors
set signcolumn=yes
set cursorline
set mouse=a
set background=dark
set path=**
set conceallevel=2
set shell=/bin/sh
set lazyredraw
set laststatus=2
set modeline
set shortmess+=cI


" Commands

com! -nargs=+ Grep vimgrep <args> **/*

au Filetype markdown set wrap
au Filetype markdown set colorcolumn=0

au FileType sh set makeprg=shellcheck\ -f\ gcc\ %

au Filetype qf nnoremap <silent><cr> :.cc<cr>zA
au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" nvim
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=40}


" Mappings

let mapleader = " "
let maplocalleader = ","

nmap Y y$
nmap { {zt
nmap } }zt
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
nmap ZA :wqa<cr>
nmap ZW :w<cr>
nmap gb :e #<cr>
nnoremap J mzJ`z:delmarks z<cr>
vnoremap I :m '>+1<cr>gv=gv
vnoremap E :m '<-2<cr>gv=gv
nmap Q !!sh<cr>
nnoremap <c-m> :mode<cr>
nnoremap <c-l> :nohl<cr><c-l>

nnoremap <F1> :cp<cr>
nnoremap <F2> :copen<cr>
nnoremap <F3> :cn<cr>
nnoremap <F5> :make<cr>

nnoremap å :redo<cr>
nnoremap æ :Telescope find_files<cr>
nnoremap ø :Telescope live_grep<cr>

nmap <leader>tt :vimgrep /\C[TODO\|NOTE\|HACK\|FIXME\|BUG\|FIX\|ISSUE\|WARN\|PERF]: /jg **/*<cr>
nmap <leader>tu :UndotreeToggle<cr>
nmap <leader>tz :ZenMode<cr>

nmap <leader>hpu :PackerSync<cr>
nmap <leader>hps :PackerStatus<cr>
nmap <leader>hpp :PackerProfile<cr>
nmap <leader>hc :checkhealth<cr>
nmap <leader>hh :Telescope help_tags<cr>

nmap g{ :Gitsigns prev_hunk<cr>
nmap g} :Gitsigns next_hunk<cr>
nmap <leader>gB :Gitsigns toggle_current_line_blame<cr>
nmap <leader>ghs :Gitsigns stage_hunk<cr>
nmap <leader>ghu :Gitsigns undo_stage_hunk<cr>
nmap <leader>ghr :Gitsigns reset_hunk<cr>
nmap <leader>ghR :Gitsigns reset_buffer<cr>
nmap <leader>ghp :Gitsigns preview_hunk<cr>
nmap <leader>gl :Gitsigns setqflist<cr>
nmap <leader>gg :Git<cr>

" Qwerty
" nnoremap n nztzv
" nnoremap N Nztzv

" Colemak-dh
nnoremap n h
nnoremap e j
nnoremap i k
nnoremap o l
nnoremap k nztzv
nnoremap j e
nnoremap h i
nnoremap l o

nnoremap E J
nnoremap I K
nnoremap O L
nnoremap K Nztzv
nnoremap J E
nnoremap H I
nnoremap L O

vnoremap n h
vnoremap e j
vnoremap i k
vnoremap o l
vnoremap k nztzv
vnoremap j e
vnoremap h i
vnoremap l o

vnoremap E J
vnoremap I K
vnoremap O L
vnoremap K Nztzv
vnoremap J E
vnoremap H I
vnoremap L O

onoremap n h
onoremap e j
onoremap i k
onoremap o l
onoremap k n
onoremap j e
onoremap h i
onoremap l o

onoremap E J
onoremap I K
onoremap O L
onoremap K N
onoremap J E
onoremap H I
onoremap L O

nnoremap <C-n> <C-w>h
nnoremap <C-e> <C-w>j
nnoremap <C-i> <C-w>k
nnoremap <C-o> <C-w>l

nnoremap <leader>l o<esc>k0
nnoremap <leader>L O<esc>j0
