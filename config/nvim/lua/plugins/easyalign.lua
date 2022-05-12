local M = {
  packer = {
    'junegunn/vim-easy-align',
    requires = 'tpope/vim-repeat',
    config = function ()
      local maps = {
        g = {
          a = {[[<plug>(EasyAlign)]], "Easy align"},
        }}
      require('which-key').register(maps, {noremap = true, silent = true})
    end
  }
}

return M
