local M = {
  packer = {
    'theHamsta/nvim-dap-virtual-text',
    after = {'treesitter', 'dap'},
    config = function ()
      require("nvim-dap-virtual-text").setup()
    end
  }
}

return M
