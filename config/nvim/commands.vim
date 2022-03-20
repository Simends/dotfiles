com! -nargs=+ Grep vimgrep <args> **/*

au Filetype markdown set wrap
au Filetype markdown set colorcolumn=0

au FileType sh set makeprg=shellcheck\ -f\ gcc\ %

au Filetype qf nnoremap <silent><cr> :.cc<cr>zA
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=40}
au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
