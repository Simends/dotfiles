local M = {}

M.attach = function (_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opt = {buffer = bufnr, noremap = true, silent = true}
  vim.cmd [[ command! LspFormat execute 'lua vim.lsp.buf.formatting()' ]]
  vim.cmd [[ command! LspCodelensRun execute 'lua vim.lsp.codelens.run()' ]]
  vim.cmd [[ command! LspCodelensRefresh execute 'lua vim.lsp.codelens.refresh()' ]]
  vim.cmd [[ command! LspCodelensDisplay execute 'lua vim.lsp.codelens.display()' ]]
  vim.cmd [[ command! LspCodeAction execute 'lua vim.lsp.buf.code_action()' ]]
  vim.cmd [[ command! LspWorkspaceList execute 'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))' ]]
  vim.cmd [[ command! -nargs=+ LspWorkspaceAdd execute 'lua vim.lsp.buf.add_workspace_folder(<args>)' ]]
  vim.cmd [[ command! LspWorkspaceRemove execute 'lua vim.lsp.buf.remove_workspace_folder()' ]]
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opt)
  local Hydra = require('hydra')
  local lsp = vim.lsp
  local maps = {['<leader>'] = {
    c = {
      name = "Code",
      c = {":lua vim.diagnostic.open_float()<cr>", "Show line diagnostic"},
      J = {":lua vim.lsp.buf.signature_help()<cr>", "Show signature help"},
      C = {":lua vim.diagnostic.setqflist()<cr>", "Show all diagnostics"},
      n = {":lua vim.lsp.buf.rename()<cr>", "Rename symbol"},
      f = {":lua vim.lsp.buf.formatting()<cr>", "Format buffer"},
      a = {":lua vim.lsp.code_action()<cr>", "Code action"},
      i = {":LspInfo<cr>", "LSP Info"},
      I = {":NullLsInfo<cr>", "Null LSP Info"}
    },
  },
  g = {
      d = {":lua vim.lsp.buf.definition()<cr>", "Go to definition"},
      D = {":lua vim.lsp.buf.declaration()<cr>", "Go to declaration"},
      t = {":lua vim.lsp.buf.type_definition()<cr>", "Go to type definition"},
      r = {":lua vim.lsp.buf.reference()<cr>", "Go to reference"},
      m = {":lua vim.lsp.buf.implementation()<cr>", "Go to implementation"},
      ['}'] = {":lua vim.diagnostic.goto_next()<cr>", "Next diagnostic"},
      ['{'] = {":lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic"}
    }}
    require('which-key').register(maps, opt)
end
M.capabilities = vim.lsp.protocol.make_client_capabilities() M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require('cmp_nvim_lsp').update_capabilities(M.capabilities)

M.debounce = 150

local null_ls = require('null-ls')
M.null = {}

M.null.diag = function(linter)
  null_ls.register({null_ls.builtins.diagnostics[linter]})
end

M.null.format = function(formatter)
  null_ls.register({null_ls.builtins.formatting[formatter]})
end

M.null.code_actions = function(provider)
  null_ls.register({null_ls.builtins.code_actions[provider]})
end

M.null.hover = function(provider)
  null_ls.register({null_ls.builtins.hover[provider]})
end

M.null.completion = function(provider)
  null_ls.register({null_ls.builtins.completion[provider]})
end

return M
