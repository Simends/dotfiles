local M = {
  preconf = function ()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local maps = {['<leader>'] = {t = {
        u = {"<cmd>UndotreeToggle<cr>", "Undotree"},
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    'mbbill/undotree',
    opt = true,
    cmd = {'UndotreeToggle'},
    config = function()
      vim.g.undotree_WindowLayout = 3
    end
  }
}

return M
