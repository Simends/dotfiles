local M = {
  preconf = function()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      which_key.register({t = {c = {'<cmd>ColorizerToggle<cr>', 'Colorizer'}}})
    end
  end,
  packer = {
    'norcalli/nvim-colorizer.lua',
    opt = true,
    cmd = {"ColorizerToggle"}
  }
}

return M
