
" KEYMAP

" Define leader
let mapleader = " "

" Open stuff [o]
nnoremap <leader>ou <cmd>UndotreeToggle<cr>
nnoremap <leader>op <cmd>NERDTreeToggle<cr>
nnoremap <leader>ot <cmd>vnew term://zsh<cr>
nnoremap <leader>om <cmd>MinimapToggle<cr>
nnoremap <leader>oc <cmd>TagbarToggle<cr>

" Find files [f]
nnoremap <leader><leader> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Git commands [g]
nnoremap <leader>gs <cmd>Git status<cr>
nnoremap <leader>ga <cmd>Git add .<cr>
nnoremap <leader>gc <cmd>Git commit<cr>
nnoremap <leader>gl <cmd>Git log<cr>
nnoremap <leader>gp <cmd>Git push<cr>

" Help and documentation [h]
nnoremap <leader>hpi <cmd>PlugInstall<cr>
nnoremap <leader>hpc <cmd>PlugClean<cr>
nnoremap <leader>hpu <cmd>PlugUpdate<cr>
nnoremap <leader>hd <cmd>help<cr>
vnoremap K :m '<-2<CR>gv=gv

" Toggle autocompiler [a]
nnoremap <leader>aw :!setsid autocomp web &<cr>
nnoremap <leader>am :!setsid autocomp make &<cr>

" Debugger [d]
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" Coc [e]
nnoremap <silent><nowait> <leader>ea  :<C-u>CocList diagnostics<cr>             " Show all diagnostics.
nnoremap <silent><nowait> <leader>ee  :<C-u>CocList extensions<cr>              " Manage extensions.
nnoremap <silent><nowait> <leader>ec  :<C-u>CocList commands<cr>                " Show commands.
nnoremap <silent><nowait> <leader>eo  :<C-u>CocList outline<cr>                 " Find symbol of current document.
nnoremap <silent><nowait> <leader>es  :<C-u>CocList -I symbols<cr>              " Search workspace symbols.
nnoremap <silent><nowait> <leader>ej  :<C-u>CocNext<CR>                         " Do default action for next item.
nnoremap <silent><nowait> <leader>ek  :<C-u>CocPrev<CR>                         " Do default action for previous item.
nnoremap <silent><nowait> <leader>ep  :<C-u>CocListResume<CR>                   " Resume latest coc list.
nmap <leader>ern <Plug>(coc-rename)                                             " Symbol renaming.
xmap <leader>ef  <Plug>(coc-format-selected)                                    " Formatting selected code.
nmap <leader>ef  <Plug>(coc-format-selected)
nmap <leader>eac  <Plug>(coc-codeaction)                                        " Remap keys for applying codeAction to the current buffer.
nmap <leader>eqf  <Plug>(coc-fix-current)                                       " Apply AutoFix to problem on the current line.

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Applying codeAction to the selected region.
" Example: `<leader>cap` for current paragraph
xmap <leader>c  <Plug>(coc-codeaction-selected)
nmap <leader>c  <Plug>(coc-codeaction-selected)

" Remappings
nnoremap <leader>w <C-w>
vnoremap J :m '>+1<CR>gv=gv
nnoremap <leader>m :MaximizerToggle!<CR>

imap <C-l> <Plug>(coc-snippets-expand)
