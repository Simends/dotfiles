

" Settings

filetype plugin indent on

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

"set colorcolumn=80
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
set modeline
set shortmess+=c


" Commands

com! -nargs=+ Grep vimgrep <args> **/*
com! -nargs=+ Ctags !ctags -R --language-force=<args>
com! Trailtrim %s/\s\+$//e

au Filetype markdown set wrap
au Filetype markdown set colorcolumn=0

au FileType sh set makeprg=shellcheck\ -f\ gcc\ %

au Filetype qf nnoremap <silent><cr> :.cc<cr>
au Filetype qf nnoremap <c-i> <c-w>k
au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete


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
nnoremap <c-m> :mode<cr>
nnoremap <c-l> :nohl<cr><c-l>
nnoremap <F7> :make<cr>

nnoremap å :redo<cr>

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
  au FileType netrw nnoremap <buffer> n h
  au FileType netrw nnoremap <buffer> e j
  au FileType netrw nnoremap <buffer> i k
  au FileType netrw nnoremap <buffer> o l
  au FileType netrw nnoremap <buffer> h i
  au FileType netrw nnoremap <buffer> j e
  au FileType netrw nnoremap <buffer> k n
  au FileType netrw nnoremap <buffer> l o

" nvim
if has('nvim')
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set laststatus=3
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=40}
  nnoremap æ :Telescope find_files<cr>
  nnoremap ø :Telescope live_grep<cr>
else
  set foldmethod=indent
  set laststatus=2
  syntax on
end
