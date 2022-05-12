local M = {
  packer = {
    'lewis6991/spellsitter.nvim',
    as = 'spellsitter',
    config = function()
      require('spellsitter').setup()
    end
  }
}

return M
