local lsputil = require('util.lsp')

local M = {
  lsp = function ()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")
      require('lspconfig').sumneko_lua.setup {
        on_attach = lsputil.attach,
        capabilities = lsputil.capabilities,
        flags = {
          debounce_text_changes = lsputil.debounce,
        },
        cmd = {
          "/usr/bin/lua-language-server", "-E",
          "/usr/share/lua-language-server/main.lua"
        },
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = runtime_path
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'}
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true)
            }
          }
        }
      }
    end,
  treesitter = {'lua'},
  linter = function()
    lsputil.null.diag('luacheck')
  end,
  formatter = function()
    lsputil.null.format('lua_format')
  end
}

return M
