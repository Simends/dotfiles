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
      vim.keymap.set('n', 'gI', vim.lsp.buf.hover, opt)
      local maps = {
        g = {
          d = {vim.lsp.buf.definition, "Goto definition"},
          D = {vim.lsp.buf.declaration, "Goto declaration"},
          h = {vim.lsp.buf.implementation, "Goto implementation"},
          r = {vim.lsp.buf.references, "Goto references"},
          ['['] = {vim.lsp.diagnostic.goto_prev, "Goto previous diagnostic"},
          [']'] = {vim.lsp.diagnostic.goto_next, "Goto next diagnostic"}
        },
        ['<leader>'] = {
          e = {
            name = "LSP",
            o = {[[<cmd>SymbolsOutline<cr>]], "Show symbols"},
            O = {require('telescope.builtin').lsp_workspace_symbols, "Find symbols"},
            r = {require('telescope.builtin').lsp_references, "Find symbols"},
            e = {vim.lsp.diagnostic.show_line_diagnostics, "Show diagnostic"},
            d = {vim.lsp.diagnostic.set_qflist, "Show all diagnostics"},
            n = {vim.lsp.buf.rename, "Rename"},
            s = {vim.lsp.buf.signature_help, "Show signature"},
            l = {vim.lsp.codelens.display, "Show codelens"},
            L = {vim.lsp.codelens.run, "Run codelens"},
            f = {vim.lsp.buf.formatting, "Format buffer"},
            a = {vim.lsp.buf.code_action, "Code actions"}
          }
        }
      }
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
