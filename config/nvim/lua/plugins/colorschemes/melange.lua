local M = {
  packer = {
    "savq/melange",
    config = function ()
      vim.cmd("colorscheme melange")
    end
  }
}

return M
