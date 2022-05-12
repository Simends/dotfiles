local M = {
  preconf = function ()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local maps = {['<leader>'] = {g = {
        g = {"<cmd>Git<cr>", "Fugitive"},
        c = {"<cmd>Git commit<cr>", "Commit"},
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    'tpope/vim-fugitive',
    config = function ()
      vim.cmd('au User FugitiveIndex nnoremap <buffer> h <plug>fugitive:ii')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> k <plug>fugitive:i')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> o <plug>fugitive:li')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> s <plug>fugitive:t')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> u <plug>fugitive:v')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> - <plug>fugitive:-')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> U <plug>fugitive:V')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> X <plug>fugitive:XI')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> = <plug>fugitive:=')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> < <plug>fugitive:<')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> > <plug>fugitive:>')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> H <plug>fugitive:II')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> p <plug>fugitive:q')
      vim.cmd('au User FugitiveIndex nnoremap <buffer> P <plug>fugitive:Q')
    end
  }
}

return M
