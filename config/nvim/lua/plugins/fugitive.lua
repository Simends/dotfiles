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
      vim.g.fugitive_defer_to_existing_maps = 1
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> h <plug>fugitive:i]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> k <plug>fugitive:n]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> o <plug>fugitive:l]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> s <plug>fugitive:s]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> u <plug>fugitive:u]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> - <plug>fugitive:-]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> U <plug>fugitive:U]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> X <plug>fugitive:X]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> = <plug>fugitive:=]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> < <plug>fugitive:<]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> > <plug>fugitive:>]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> H <plug>fugitive:I]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> p <plug>fugitive:p]]
      vim.cmd[[au User FugitiveIndex nnoremap <buffer> P <plug>fugitive:P]]
    end
  }
}

return M
