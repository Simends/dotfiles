-- Plugins configuration
local M = {}

M.packer = {
  'wbthomason/packer.nvim',
  config = function ()
    vim.api.nvim_set_keymap('n', '<leader>hpu', '<cmd>PackerSync<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>hps', '<cmd>PackerStatus<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>hpp', '<cmd>PackerProfile<cr>', {noremap = true, silent = true})
  end
}

M.packer_config = {
  ensure_dependencies = true, -- Should packer install plugin dependencies?
  max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
  auto_clean = true, -- During sync(), remove unused plugins
  compile_on_sync = true, -- During sync(), run packer.compile()
  disable_commands = false, -- Disable creating commands
  opt_default = false, -- Default to using opt (as opposed to start) plugins
  transitive_opt = true, -- Make dependencies of opt plugins also opt by default
  transitive_disable = true, -- Automatically disable dependencies of disabled plugins
  display = {open_fn = require('packer.util').float},
  profile = {
    enable = true,
    threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  }
}

M.lspconfig = {
  'neovim/nvim-lspconfig',
  as = 'lspconfig',
  config = {function()
    -- Servers
    -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    local servers = {
      'pylsp',
      'tsserver',
      'clangd',
      'bashls',
      'yamlls',
      'jsonls',
      'dockerls',
      'rnix',
    }
    -- LSP Setup
    local lsp = require('lspconfig')
    local configs = require('lspconfig.configs')
    local util = require('lspconfig.util')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    vim.api.nvim_set_keymap('n', '<leader>ei', [[<cmd>LspInfo<cr>]], {noremap = true, silent = true})						-- Show server status
    local on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      -- local opt = {noremap = true, silent = true}
      vim.cmd [[ command! LspFormat execute 'lua vim.lsp.buf.formatting()' ]]
      vim.cmd [[ command! LspCodelensRun execute 'lua vim.lsp.codelens.run()' ]]
      vim.cmd [[ command! LspCodelensRefresh execute 'lua vim.lsp.codelens.refresh()' ]]
      vim.cmd [[ command! LspCodelensDisplay execute 'lua vim.lsp.codelens.display()' ]]
      vim.cmd [[ command! LspCodeAction execute 'lua vim.lsp.buf.code_action()' ]]
      vim.cmd [[ command! LspWorkspaceList execute 'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))' ]]
      vim.cmd [[ command! -nargs=+ LspWorkspaceAdd execute 'lua vim.lsp.buf.add_workspace_folder(<args>)' ]]
      vim.cmd [[ command! LspWorkspaceRemove execute 'lua vim.lsp.buf.remove_workspace_folder()' ]]
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'I', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
      -- local maps = {
      --   g = {
      --     d = {[[<cmd>lua vim.lsp.buf.definition()<cr>]], "Goto definition"},
      --     D = {[[<cmd>lua vim.lsp.buf.declaration()<cr>]], "Goto declaration"},
      --     i = {[[<cmd>lua vim.lsp.buf.implementation()<cr>]], "Goto implementation"},
      --     r = {[[<cmd>lua vim.lsp.buf.references()<cr>]], "Goto references"},
      --     ['['] = {[[<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>]], "Goto previous diagnostic"},
      --     [']'] = {[[<cmd>lua vim.lsp.diagnostic.goto_next()<cr>]], "Goto next diagnostic"}
      --   },
      --   ['<leader>'] = {
      --     e = {
      --       name = "LSP",
      --       o = {[[<cmd>SymbolsOutline<cr>]], "Show symbols"},
      --       O = {[[<cmd>Telescope lsp_workspace_symbols<cr>]], "Find symbols"},
      --       e = {[[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>]], "Show diagnostic"},
      --       d = {[[<cmd>lua vim.lsp.diagnostic.set_qflist()<cr>]], "Show all diagnostics"},
      --       n = {[[<cmd>lua vim.lsp.buf.rename()<cr>]], "Rename"},
      --       s = {[[<cmd>lua vim.lsp.buf.signature_help()<cr>]], "Show signature"},
      --       l = {[[<cmd>lua vim.lsp.codelens.display()<cr>]], "Show codelens"},
      --       L = {[[<cmd>lua vim.lsp.codelens.run()<cr>]], "Run codelens"},
      --       f = {[[<cmd>lua vim.lsp.buf.formatting()<cr>]], "Format buffer"},
      --       a = {"<cmd>Telescope lsp_code_actions<cr>", "Code actions"}
      --     }
      --   }
      -- }
      -- require('which-key').register(maps, opt)
    end
    for _, server in ipairs(servers) do
      lsp[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
    -- Lua LSP
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    lsp.sumneko_lua.setup {
      on_attach = on_attach,
      capabilities = capabilities,
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
    -- HTML LSP
    lsp.html.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {"html"},
      init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {css = true, javascript = true}
      }
    }
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
    })
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end}
}

M.null_ls = {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>eI', [[<cmd>NullLsInfo<cr>]], {noremap = true, silent = true})						-- Show server status
    local nls = require("null-ls")
    local code_actions = nls.builtins.code_actions
    --local format = nls.builtins.formatting
    local diag = nls.builtins.diagnostics
    local comp = nls.builtins.completion
    local hover = nls.builtins.hover
    require("null-ls").setup({
      sources = {
        -- See: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        --format.stylua,
        comp.spell,
        diag.checkmake,
        diag.shellcheck,
        code_actions.shellcheck,
        hover.dictionary
      },
    })
  end
}

M.nvim_ts_rainbow = {
  'p00f/nvim-ts-rainbow',
  config = function()
    require('nvim-treesitter.configs').setup {
      rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
      },
    }
  end
}

M.nvim_cmp = {
  "hrsh7th/nvim-cmp",
  requires = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    {"saadparwaiz1/cmp_luasnip", after = 'luasnip'},
    "hrsh7th/cmp-path"
  },
  config = {
    function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      cmp.setup {
        completion = {
          completeopt = 'menu,menuone,noselect'
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<CR>'] = cmp.mapping.confirm({ select = false })
        },
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'buffer' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end
  }
}

M.luasnip = {
  'L3MON4D3/LuaSnip',
  as = 'luasnip',
  config = {function()
    require("snippets")
  end}
}

M.symbols_outline = {
  'simrat39/symbols-outline.nvim',
  opt = true,
  cmd = {'SymbolsOutline'},
  after = 'lspconfig',
  config = {
    function()
      vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = true,
        position = 'right',
        keymaps = {
          close = "<Esc>",
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          rename_symbol = "r",
          code_actions = "a"
        },
        lsp_blacklist = {}
      }
    end
  }
}

M.fidget = {
  'j-hui/fidget.nvim',
  config = function()
    require"fidget".setup{}
  end
}

M.lightbulb = {
  'kosayoda/nvim-lightbulb',
  config = function()
    require'nvim-lightbulb'.setup {
      -- LSP client names to ignore
      -- Example: {"sumneko_lua", "null-ls"}
      -- ignore = {},
      sign = {
        enabled = true,
        priority = 10,
      },
      float = {
        enabled = false,
      },
      virtual_text = {
        enabled = false,
      },
      status_text = {
        enabled = false,
      }
    }
    vim.fn.sign_define('LightBulbSign', { text = "", texthl = "DiagnosticWarn", linehl="", numhl="" })
    --vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  end
}

M.code_action_menu = {
  'weilbith/nvim-code-action-menu',
  opt = true,
  cmd = 'CodeActionMenu',
}

M.treesitter = {
  'nvim-treesitter/nvim-treesitter',
  as = 'treesitter',
  run = ':TSUpdate',
  config = {function()
    require'nvim-treesitter.configs'.setup {
      -- ensure_installed = "maintained",
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "fennel",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "latex",
        "lua",
        "markdown",
        "nix",
        "python",
        "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = {
        enable = true,
      },
    }
  end}
}

M.treesitter_textobjects = {
  'nvim-treesitter/nvim-treesitter-textobjects',
  config = function()
    require'nvim-treesitter.configs'.setup {
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["aC"] = "@comment.outer",
            -- Or you can define your own textobjects like this
            -- ["iF"] = {
            --     python = "(function_definition) @function",
            --     cpp = "(function_definition) @function",
            --     c = "(function_definition) @function",
            --     java = "(method_declaration) @function",
            -- },
          },
        },
      },
    }
  end
}

M.treesitter_refactor = {
  'nvim-treesitter/nvim-treesitter-refactor',
  config = function()
    require'nvim-treesitter.configs'.setup {
      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
        },
        navigation = {
          enable = true,
          keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            list_definitions_toc = "gO",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>",
          },
        },
      },
    }
  end
}

M.playground = {
  'nvim-treesitter/playground',
  opt = true,
  cmd = {"TSPlaygroundToggle"},
  config = function()
    require "nvim-treesitter.configs".setup {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      }
    }
  end
}

M.nvim_gps = {
  "SmiteshP/nvim-gps",
  config = function()
    require("nvim-gps").setup({
      icons = {
        ["class-name"] = ' ',      -- Classes and class-like objects
        ["function-name"] = ' ',   -- Functions
        ["method-name"] = ' ',     -- Methods (functions inside class-like objects)
        ["container-name"] = ' ',  -- Containers (example: lua tables)
        ["tag-name"] = '炙'         -- Tags (example: html tags)
      },

      separator = ' > ',

      -- limit for amount of context shown
      -- 0 means no limit
      depth = 6,

      -- indicator used when context hits depth limit
      depth_limit_indicator = "..."
    })
  end
}

M.telescope = {
  'nvim-telescope/telescope.nvim',
  as = 'telescope',
  requires = {'nvim-lua/plenary.nvim'},
  config = function()
    require("telescope").setup {
      defaults = {
        color_devicons = true,
        prompt_prefix = "   ",
        selection_caret = "   ",
        entry_prefix = "    ",
        scroll_strategy = "cycle",
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        -- winblend = 25, -- Transparency
        -- flip_columns = 140,
        layout_config = {
          height = 60,
          anchor = "N",
          scroll_speed = 25,
          prompt_position = "top",
          vertical = {
            mirror = true
          }
        },
      },
      pickers = {
        buffers = {
          sort_lastused = true,
          mappings = {
            i = {
              ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
            n = {["<c-d>"] = require("telescope.actions").delete_buffer}
          }
        }
      }
    }
  end
}

M.telescope_fzy_native = {
  'nvim-telescope/telescope-fzy-native.nvim',
  after = 'telescope',
  config = function()
    require('telescope').load_extension('fzy_native')
  end
}

M.telescope_fzf_native = {
  'nvim-telescope/telescope-fzf-native.nvim',
  run = 'make',
  after = 'telescope',
  config = function()
    require('telescope').load_extension('fzf')
  end
}

M.telescope_repo = {
  'cljoly/telescope-repo.nvim',
  requires = {'telescope'},
  config = function()
    require'telescope'.load_extension('repo')
  end
}

M.dap = {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require('dap')
    local api = vim.api
    -----------------------------
    -- Adapters------------------
    -----------------------------
    -- C/C++/Rust
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode',
      name = "lldb"
    }
    -----------------------------
    -- Adapter configs-----------
    -----------------------------
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
        --postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
      },
    }
    -- If you want to use this for rust and c, add something like this:
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
    -----------------------------
    -- Other Configs-------------
    -----------------------------
    local keymap_restore = {}
    dap.listeners.after['event_initialized']['me'] = function()
      for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
          if keymap.lhs == "I" then
            table.insert(keymap_restore, keymap)
            api.nvim_buf_del_keymap(buf, 'n', 'I')
          end
        end
      end
      api.nvim_set_keymap(
        'n', 'I', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
    end

    dap.listeners.after['event_terminated']['me'] = function()
      for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(
          keymap.buffer,
          keymap.mode,
          keymap.lhs,
          keymap.rhs,
          { silent = keymap.silent == 1 }
        )
      end
      keymap_restore = {}
    end
    local opt = {noremap = true, silent = true}
    local map = {
      ['<F5>'] = {[[<cmd>lua require'dap'.continue()<CR>]], "Continue"},
      ['<F10>'] = {[[<cmd>lua require'dap'.step_over()<cr>]], "Step over"},
      ['<F11>'] = {[[<cmd>lua require'dap'.step_into()<cr>]], "Step into"},
      ['<F12>'] = {[[<cmd>lua require'dap'.step_out()<CR>]], "Step out"},
      ['<F9>'] = {[[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], "Toggle breakpoint"},
      ['<leader>'] = {
        d = {
          name = "Debug",
          r = {[[<cmd>lua require'dap'.repl.toggle()<CR>]], "Toggle REPL"},
          s = {[[<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)]], "Show scopes"},
          f = {[[<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)]], "Show frames"},
          e = {[[<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').expression)]], "Show expression"},
          t = {[[<cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').threads)]], "Show threads"},
          B = {[[<cmd>lua require'dap'.clear_breakpoints()<CR>]], "Clear all breakpoints"}
        }
      }
    }
    require('which-key').register(map, opt)
  end
}

M.telescope_dap = {
  'nvim-telescope/telescope-dap.nvim',
  requires = {'telescope', 'nvim-dap'},
  config = function()
    require('telescope').load_extension('dap')
    local opt = {noremap = true, silent = true, prefix = '<leader>'}
    local map = {
      d = {
        b = {[[<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<cr>]], "List all breakpoints"}
      }
    }
    require('which-key').register(map, opt)
  end
}

M.dap_virtual_text = {
  'theHamsta/nvim-dap-virtual-text',
  requires = {'nvim-dap', 'treesitter'},
  config = function()
    require("nvim-dap-virtual-text").setup {
      enabled = true,                     -- enable this plugin (the default)
      enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true,            -- show stop reason when stopped for exceptions
      commented = false,                  -- prefix virtual text with comment string
      -- experimental features:
      virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
      all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    }
    local opt = {noremap = true, silent = true, prefix = '<leader>'}
    local map = {
      d = {
        v = {'<cmd>DapVirtualTextToggle<cr>', 'Toggle virtual text'}
      }
    }
    require('which-key').register(map, opt)
  end
}

M.dressing = {
  'stevearc/dressing.nvim',
  config = function()
    require('dressing').setup({
      input = {
        -- Set to false to disable the vim.ui.input implementation
        enabled = true,

        -- Default prompt string
        default_prompt = "Input:",

        -- Can be 'left', 'right', or 'center'
        prompt_align = "left",

        -- When true, <Esc> will close the modal
        insert_only = true,

        -- These are passed to nvim_open_win
        anchor = "SW",
        border = "rounded",
        -- 'editor' and 'win' will default to being centered
        relative = "cursor",

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        prefer_width = 40,
        width = nil,
        -- min_width and max_width can be a list of mixed types.
        -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },

        -- Window transparency (0-100)
        winblend = 10,
        -- Change default highlight groups (see :help winhl)
        winhighlight = "",

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,

        -- see :help dressing_get_config
        get_config = nil,
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "builtin" },

        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = nil,

        -- Options for fzf selector
        fzf = nil,

        -- Options for fzf_lua selector
        fzf_lua = nil,

        -- Options for nui Menu
        nui = nil,

        -- Options for built-in selector
        builtin = {
          -- These are passed to nvim_open_win
          anchor = "NW",
          border = "rounded",
          -- 'editor' and 'win' will default to being centered
          relative = "editor",

          -- Window transparency (0-100)
          winblend = 10,
          -- Change default highlight groups (see :help winhl)
          winhighlight = "",

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- the min_ and max_ options can be a list of mixed types.
          -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = nil,
      },
    })
  end
}

M.hlslens = {
  'kevinhwang91/nvim-hlslens',
  config = function()
    require('hlslens').setup({
      calm_down = false, -- When the cursor is out of the position range of the matched instance and calm_down is true, clear all lens
      nearest_only = false, -- Only add lens for the nearest matched instance and ignore others
      nearest_float_when = 'auto', -- When to open the floating window for the nearest lens. 'auto': floating window will be opened if room isn't enough for virtual text; 'always': always use floating window instead of virtual text; 'never': never use floating window for the nearest lens
      override_lens = function(render, posList, nearest, idx, relIdx)
        local sfw = vim.v.searchforward == 1
        local indicator, text, chunks
        local absRelIdx = math.abs(relIdx)
        if absRelIdx > 1 then
          indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and 'K' or 'k')
        elseif absRelIdx == 1 then
          indicator = sfw ~= (relIdx == 1) and 'K' or 'k'
        else
          indicator = ''
        end
        local lnum, col = unpack(posList[idx])
        if nearest then
          local cnt = #posList
          if indicator ~= '' then
            text = ('[%s %d/%d]'):format(indicator, idx, cnt)
          else
            text = ('[%d/%d]'):format(idx, cnt)
          end
          chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
        else
          text = ('[%s %d]'):format(indicator, idx)
          chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
        end
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
      end
    })
    local kopts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', 'k', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'K', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.cmd([[
    hi! link HlSearchNear Search 
    hi! link HlSearchLens Search 
    hi! link HlSearchLensNear Search 
    hi! link HlSearchFloat Search 
    ]])
  end
}

M.scrollbar = {
  'petertriho/nvim-scrollbar',
  opt = true,
  cmd = {"ScrollbarToggle", "ScrollbarShow"},
  config = function()
    require("scrollbar").setup({
      show = true,
      set_highlights = true,
      handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
      },
      handlers = {
        diagnostic = true,
        search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
      },
      marks = {
        Search = {
          text = { "-", "=" },
          priority = 0,
          color = nil,
          cterm = nil,
          highlight = "TSTag",
        },
        Error = {
          text = { "-", "=" },
          priority = 1,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 2,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 3,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 4,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 5,
          color = nil,
          cterm = nil,
          highlight = "Normal",
        },
      },
    })
    require("scrollbar.handlers.search").setup()
  end
}

M.colorizer = {
  'norcalli/nvim-colorizer.lua',
  opt = true,
  cmd = {"ColorizerToggle"}
}

M.which_key = {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "top", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }
  end
}

M.zen_mode = {
  'folke/zen-mode.nvim',
  opt = true,
  cmd = {'ZenMode'},
  config =
    function()
      require("zen-mode").setup {
        window = {
          backdrop = 1.0, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          width = 100, -- width of the Zen window
          height = 1, -- height of the Zen window
          options = {
            signcolumn = "no", -- disable signcolumn
            number = true, -- disable number column
            relativenumber = true, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          }
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = true -- disables the command in the last line of the screen
          },
          gitsigns = {enabled = true}, -- disables git signs
          tmux = {enabled = false}, -- disables the tmux statusline
          kitty = {
            enabled = false,
            font = "+4" -- font size increment
          }
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win)
          -- vim.cmd("IndentBlanklineDisable")
          vim.cmd("set colorcolumn=0")
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
          -- vim.cmd("IndentBlanklineEnable")
          vim.cmd("set colorcolumn=80")
        end
      }
    end
}

M.nvim_tree = {
  'kyazdani42/nvim-tree.lua',
  as = 'nvim-tree',
  opt = false,
  cmd = {'NvimTreeToggle'},
  after = 'devicons',
  config = {function()
    -- following options are the default
    -- each of these are documented in `:help nvim-tree.OPTION_NAME`
    require'nvim-tree'.setup {
      disable_netrw       = true,
      hijack_netrw        = true,
      open_on_setup       = false,
      ignore_ft_on_setup  = {},
      auto_close          = true,
      open_on_tab         = false,
      hijack_cursor       = false,
      update_cwd          = false,
      update_to_buf_dir   = {
        enable = true,
        auto_open = true,
      },
      diagnostics = {
        enable = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        }
      },
      update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
      },
      system_open = {
        cmd  = nil,
        args = {}
      },
      filters = {
        dotfiles = false,
        custom = {}
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = 'right',
        auto_resize = false,
        mappings = {
          custom_only = false,
          list = {}
        },
        number = false,
        relativenumber = false
      },
      trash = {
        cmd = "trash",
        require_confirm = true
      }
    }
    vim.api.nvim_set_keymap('n', '<leader>te', '<cmd>NvimTreeToggle<cr>', {noremap = true, silent = true})
  end}
}

M.dirbuf = {
  'elihunter173/dirbuf.nvim',
  opt = true,
  cmd = {"Dirbuf"},
  config = function()
    require("dirbuf").setup {
      hash_padding = 2,
      show_hidden = true,
      sort_order = "default",
      write_cmd = "DirbufSync",
    }
  end
}

M.undotree = {
  'mbbill/undotree',
  opt = true,
  cmd = {'UndotreeToggle'},
  config = function()
    vim.g.undotree_WindowLayout = 3
  end
}

M.qf_helper = {
  'stevearc/qf_helper.nvim',
  config = function()
    require'qf_helper'.setup({
      prefer_loclist = true,       -- Used for QNext/QPrev (see Commands below)
      sort_lsp_diagnostics = true, -- Sort LSP diagnostic results
      quickfix = {
        autoclose = true,          -- Autoclose qf if it's the only open window
        default_bindings = true,   -- Set up recommended bindings in qf window
        default_options = true,    -- Set recommended buffer and window options
        max_height = 10,           -- Max qf height when using open() or toggle()
        min_height = 5,            -- Min qf height when using open() or toggle()
        track_location = 'cursor', -- Keep qf updated with your current location
        -- Use `true` to update position as well
      },
      loclist = {                  -- The same options, but for the loclist
        autoclose = true,
        default_bindings = true,
        default_options = true,
        max_height = 10,
        min_height = 5,
        track_location = 'cursor',
      },
    })
    local opt = {noremap = true, silent = true, prefix = "Q"}
    local map = {
      Q = {"<cmd>QFToggle<cr>", "Toggle quickfix"},
      q = {"<cmd>QFToggle!<cr>", "Toggle silent quickfix"},
      L = {"<cmd>LLToggle<cr>", "Toggle loclist"},
      l = {"<cmd>LLToggle!<cr>", "Toggle silent loclist"},
      O = {"<cmd>QNext<cr>", "Next in list"},
      o = {"<cmd>QNext!<cr>", "Next silent in list"},
      N = {"<cmd>QPrev<cr>", "Prev in list"},
      n = {"<cmd>QPrev!<cr>", "Prev silent in list"}
    }
    require('which-key').register(map, opt)
  end
}

M.gitsigns = {
  'lewis6991/gitsigns.nvim',
  as = 'gitsigns',
  requires = {'nvim-lua/plenary.nvim'},
  config = function()
    require('gitsigns').setup()
  end
}

M.indentguides = {
  'lukas-reineke/indent-blankline.nvim',
  opt = true,
  cmd = {'IndentBlanklineToggle', 'IndentBlanklineToggle!'},
  config = function()
    require("indent_blankline").setup {
      space_char_blankline = " ",
      show_end_of_line = false,
      show_current_context = true,
      show_current_context_start = false,
      use_treesitter = true,
    }
    -- vim.cmd('IndentBlanklineDisable!')
  end
}

M.autopairs = {
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup({
      disable_filetype = { "TelescopePrompt" , "vim" },
      enable_check_bracket_line = false,
      check_ts = true,
      ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
      }
    })
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
    cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
  end
}

M.sneak = {
  'justinmk/vim-sneak'
}

M.surround = {
  'tpope/vim-surround',
  requires = 'tpope/vim-repeat'
}

M.commentary_vim = {
  'tpope/vim-commentary'
}

M.fugitive = {
  'tpope/vim-fugitive'
}

M.mkdnflow = {
  'jakewvincent/mkdnflow.nvim',
  config = function()
    require('mkdnflow').setup({
      -- Config goes here; leave blank for defaults
      -- Type: boolean. Use default mappings (see '❕Commands and default
--     mappings').
      -- 'false' disables mappings
      default_mappings = true,

      -- Type: boolean. Create directories (recursively) if link contains a
      --     missing directory.
-- 'false' prevents missing directories from being created
      create_dirs = true,

      -- Type: string. Navigate to links relative to the directory of the first-
      --     opened file.
      -- 'current' navigates links relative to currently open file
      links_relative_to = 'first',

      -- Type: key-value pair(s). The plugin's features are enabled only when one
      -- of these filetypes is opened; otherwise, the plugin does nothing.
      filetypes = {md = true, rmd = true, markdown = true},

      -- Type: boolean. When true, the createLinks() function tries to evaluate
      --     the string provided as the value of new_file_prefix.
      -- 'false' results in the value of new_file_prefix being used as a string,
      --     i.e. it is not evaluated, and the prefix will be invariant.
      evaluate_prefix = false,

      -- Type: string. Defines the prefix that should be used to create new links.
      --     This is evaluated at the time createLink() is run, which is to say
      --     that it's run whenever <CR> is pressed (under the default mappings).
      --     This makes for many interesting possibilities.
      new_file_prefix = '',
    })
  end
}

M.vimtex = {
  'lervag/vimtex',
  opt = true,
  ft = 'tex',
  config = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
  end
}

M.devicons = {
  'kyazdani42/nvim-web-devicons',
  as = 'devicons'
}

M.tokyonight = {
  'folke/tokyonight.nvim',
  config = function()
    -- The theme comes in three styles, storm, a darker variant night and day.
    vim.g.tokyonight_style = "storm"
    -- Configure the colors used when opening a :terminal in Neovim
    vim.g.tokyonight_terminal_colors = true
    -- Make comments italic
    vim.g.tokyonight_italic_comments = true
    -- Make keywords italic
    vim.g.tokyonight_italic_keywords = true
    -- Make functions italic
vim.g.tokyonight_italic_functions = true
    -- Make variables and identifiers italic
    vim.g.tokyonight_italic_variables = false
    -- Enable this to disable setting the background color
    vim.g.tokyonight_transparent = false
    -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard StatusLine and LuaLine.
    vim.g.tokyonight_hide_inactive_statusline = true
    -- Set a darker background on sidebar-like windows.
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
    -- Sidebar like windows like NvimTree get a darker background
    vim.g.tokyonight_dark_sidebar = true
    -- Float windows like the lsp diagnostics windows get a darker background.
    vim.g.tokyonight_dark_float = true
    -- You can override specific color groups to use other groups or a hex color
    -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
    -- Adjusts the brightness of the colors of the Day style. Number between 0 and 1, from dull to vibrant colors
    vim.g.tokyonight_day_brightness = 0.3
    -- Load the colorscheme
    vim.cmd[[colorscheme tokyonight]]
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
  end
}

M.edge = {
  'sainnhe/edge',
  config = function()
    vim.g.edge_style = 'neon'
    vim.g.edge_enable_italic = 1
    vim.cmd('colorscheme edge')
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
  end
}

M.rose_pine = {
  'rose-pine/neovim',
  as = 'rose-pine',
  config = function ()
    -- Set variant
    -- Defaults to 'dawn' if vim background is light
    -- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
    vim.g.rose_pine_variant = 'moon'
    vim.cmd('colorscheme rose-pine')
    -- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    -- vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE")
    -- vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
    -- vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
  end
}

M.gruvbox_material = {
  'sainnhe/gruvbox-material',
  config = function ()
    vim.g.gruvbox_material_palette = 'mix'
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_disable_italic_comment = 0
    vim.g.gruvbox_material_enable_bold = 1
    vim.cmd('set background=dark')
    vim.cmd('colorscheme gruvbox-material')
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
  end
}

M.kanagawa = {
  "rebelot/kanagawa.nvim",
  config = function ()
    vim.cmd('set background=dark')
    vim.cmd('colorscheme kanagawa')
    -- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    -- vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
  end
}

return M
