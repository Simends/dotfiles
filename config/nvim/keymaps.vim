let mapleader = " "

nnoremap Y y$
nnoremap \ :
nnoremap n nztzv
nnoremap N Nztzv
nnoremap { {zt
nnoremap } }zt
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
nnoremap ZA :wqa<cr>
nnoremap ZW :w<cr>
nnoremap gb :e #<cr>
nnoremap J mzJ`z:delmarks z<cr>
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
nnoremap Q !!sh<cr>
nnoremap <c-m> :mode<cr>
nnoremap <c-l> :nohl<cr><c-l>

map! <c-h> <c-w>h
map! <c-j> <c-w>j
map! <c-k> <c-w>k
map! <c-l> <c-w>l

nnoremap <F1> :cp<cr>
nnoremap <F2> :copen<cr>
nnoremap <F3> :cn<cr>
nnoremap <F5> :make<cr>

nnoremap å :redo<cr>
nnoremap ø :Telescope find_files<cr>
nnoremap æ :Telescope live_grep<cr>
nnoremap <leader>tt :vimgrep /\C[TODO\|NOTE\|HACK\|FIXME\|BUG\|FIX\|ISSUE\|WARN\|PERF]: /jg **/*<cr>
nnoremap <leader>tu :UndotreeToggle<cr>
nnoremap <leader>tz :ZenMode<cr>

nnoremap <leader>hpu :PackerSync<cr>
nnoremap <leader>hps :PackerStatus<cr>
nnoremap <leader>hpp :PackerProfile<cr>
nnoremap <leader>hc :checkhealth<cr>
nnoremap <leader>hh :Telescope help_tags<cr>

nnoremap g{ :Gitsigns prev_hunk<cr>
nnoremap g} :Gitsigns next_hunk<cr>
nnoremap <leader>gB :Gitsigns toggle_current_line_blame<cr>
nnoremap <leader>ghs :Gitsigns stage_hunk<cr>
nnoremap <leader>ghu :Gitsigns undo_stage_hunk<cr>
nnoremap <leader>ghr :Gitsigns reset_hunk<cr>
nnoremap <leader>ghR :Gitsigns reset_buffer<cr>
nnoremap <leader>ghp :Gitsigns preview_hunk<cr>
nnoremap <leader>gl :Gitsigns setqflist<cr>
nnoremap <leader>gg :Git<cr>
