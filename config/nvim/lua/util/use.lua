local M = {}
M.plugin = function (plugin)
  local pack = require('plugins.' .. plugin)
  if type(pack) ~= 'table' then
    return false
  end
  if pack.preconf then
    pack.preconf()
  end
  require('packer').use(pack.packer)
  return true
end

M.lang = function (lang, opt)
  local pack = require('lang.' .. lang)
  if type(pack) ~= 'table' then
    return false
  end
  if (opt.lsp and pack.lsp) then
    vim.cmd [[packadd lspconfig]]
    pack.lsp()
  end
  if (opt.treesitter and pack.treesitter) then
    vim.cmd [[packadd treesitter]]
    for _, parser in ipairs(pack.treesitter) do
      if not vim.treesitter.language.require_language(parser, nil, true) then
        vim.cmd('TSInstall ' .. parser)
      end
    end
  end
  if (opt.dap and pack.dap) then
    vim.cmd [[packadd dap]]
    pack.dap()
  end
  if (opt.linter and pack.linter) then
    vim.cmd [[packadd null-ls.nvim]]
    pack.linter()
  end
  if (opt.formatter and pack.formatter) then
    vim.cmd [[packadd null-ls.nvim]]
    pack.formatter()
  end
end

return M
