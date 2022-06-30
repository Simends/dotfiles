local lsputil = require('util.lsp')

local M = {
  lsp = function()
    local capabilities = lsputil.capabilities
    capabilities.offsetEncoding = { "utf-16" }
    require('lspconfig').clangd.setup {
      on_attach = lsputil.attach,
      capabilities = capabilities,
      flags = {
          debounce_text_changes = lsputil.debounce,
      },
    }
  end,

  treesitter = {'c', 'cpp'},

  template = [[]],

  dap = function ()
    local dap = require('dap')
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode', -- adjust as needed
      name = "lldb"
    }
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        runInTerminal = false,
        -- 💀
        -- If you use `runInTerminal = true` and resize the terminal window,
        -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
        -- To avoid that uncomment the following option
        -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
        postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
      },
    }
    dap.configurations.c = dap.configurations.cpp
  end,

  linter = function()
    lsputil.null.diag('cppcheck')
  end,

  formatter = function()
    lsputil.null.format('clang_format')
  end
}

return M
