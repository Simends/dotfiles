vim.cmd([[

" Commands
com! -nargs=+ Grep vimgrep <args> **/*
com! SessionSave lua require'scripts.session'.savesession()
com! SessionRestore lua require'scripts.session'.restoresession()

" AUTOCOMMANDS
au FileType markdown set wrap
au FileType markdown set colorcolumn=0
au FileType qf nnoremap <silent><cr> :.cc<cr>zA
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=40}
au FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
" au CursorHold,CursorHoldI * lua require'scripts.lightbulb'.update()
" au VimLeavePre * lua require'scripts.session'.savesession()
" au VimEnter * lua require'scripts.session'.restoresession()
]])
