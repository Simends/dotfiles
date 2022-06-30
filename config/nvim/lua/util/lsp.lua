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

  lsp_hydra = Hydra({ -- Git Hydra
    hint = [[

  _H_: Prev diagnostic    _J_: Signature        _c_: Show diagnostic
  _L_: Next diagnostic    _K_: Hover            _C_: Show all diagnostics
  _d_: Definition         _D_: Decleration      _r_: References
  _m_: Implementation     _s_: Show codelenses  _S_: Run Codelens
  _n_: Rename             _f_: Format           _a_: Code actions
      _i_: Lsp Status                 ^^_I_: NullLS Status

                            _<Esc>_: Exit

]],
    name = 'Code',
    config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
        position = 'top-right',
        border = 'rounded'
      },
    },
    mode = 'n',
    body = '<leader>c',
    heads = {
      { 'H', lsp.diagnostic.goto_prev },
      { 'L', lsp.diagnostic.goto_next },
      { 'J', lsp.buf.signature_help },
      { 'K', lsp.buf.hover },
      { 'c', lsp.diagnostic.show_line_diagnostics },
      { 'C', lsp.diagnostic.set_qflist },
      { 'd', lsp.buf.definition },
      { 'D', lsp.buf.declaration },
      { 'm', lsp.buf.implementation },
      { 'r', lsp.buf.references },
      { 'n', lsp.buf.rename },
      { 'f', lsp.buf.formatting },
      { 'a', lsp.buf.code_action },
      { 's', lsp.codelens.display },
      { 'S', lsp.codelens.run },
      { 'i', ':LspInfo<cr>' },
      { 'I', ':NullLSInfo<cr>' },
      { '<Esc>', nil, { exit = true, nowait = true } },
    }
  })
  local maps = {['<leader>'] = {
    c = {":lua lsp_hydra:activate()<cr>", "Code"},
  }}
    require('which-key').register(maps, opt)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
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
