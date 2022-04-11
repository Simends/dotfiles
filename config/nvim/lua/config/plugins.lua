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
    local servers = {
      'jedi_language_server',
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
      local opt = {noremap = true, silent = true}
      vim.cmd [[ command! LspFormat execute 'lua vim.lsp.buf.formatting()' ]]
      vim.cmd [[ command! LspCodelensRun execute 'lua vim.lsp.codelens.run()' ]]
      vim.cmd [[ command! LspCodelensRefresh execute 'lua vim.lsp.codelens.refresh()' ]]
      vim.cmd [[ command! LspCodelensDisplay execute 'lua vim.lsp.codelens.display()' ]]
      vim.cmd [[ command! LspCodeAction execute 'lua vim.lsp.buf.code_action()' ]]
      vim.cmd [[ command! LspWorkspaceList execute 'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))' ]]
      vim.cmd [[ command! -nargs=+ LspWorkspaceAdd execute 'lua vim.lsp.buf.add_workspace_folder(<args>)' ]]
      vim.cmd [[ command! LspWorkspaceRemove execute 'lua vim.lsp.buf.remove_workspace_folder()' ]]
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', [[<cmd>lua vim.lsp.buf.definition()<cr>]], opt)					-- Go to defenetion
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', [[<cmd>lua vim.lsp.buf.declaration()<cr>]], opt)					-- Go to decleration
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', [[<cmd>lua vim.lsp.buf.implementation()<cr>]], opt)					-- Go to references
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[<cmd>lua vim.lsp.buf.references()<cr>]], opt)					-- Go to references
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g[', [[<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>]], opt)				-- Go to previous diagnostic
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g]', [[<cmd>lua vim.lsp.diagnostic.goto_next()<cr>]], opt)				-- Go to next diagnostic
      vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-j>', [[<cmd>lua vim.lsp.buf.signature_help()<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', [[<cmd>SymbolsOutline<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>eo', [[<cmd>SymbolsOutline<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ek', [[<cmd>lua vim.lsp.buf.hover()<cr>]], opt)					-- Hover
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ee', [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>]], opt)	-- Show diagnostic
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ed', [[<cmd>lua vim.lsp.diagnostic.set_qflist()<cr>]], opt)			-- Show diagnostic
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>en', [[<cmd>lua vim.lsp.buf.rename()<cr>]], opt)				-- Rename
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>es', [[<cmd>lua vim.lsp.buf.signature_help()<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>el', [[<cmd>lua vim.lsp.codelens.display()<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>eL', [[<cmd>lua vim.lsp.codelens.run()<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>eS', [[<cmd>lua vim.lsp.buf.document_symbol()<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>er', [[<cmd>lua vim.lsp.codelens.run()<cr>]], opt)			-- Show buffer symbols
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ef', [[<cmd>lua vim.lsp.buf.formatting()<cr>]], opt)				-- Format buffer
      vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ef', [[<cmd>lua vim.lsp.buf.range_formatting()<cr>]], opt)				-- Format buffer
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ea', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], opt)				-- Show code actions
    end
    if not configs.rust_hdl then
      configs.rust_hdl = {
        default_config = {
          cmd = {"/usr/lib/rustlib/x86_64-unknown-linux-gnu/bin/vhdl_ls"};
          filetypes = { "vhdl" };
          root_dir = function(fname)
            return util.root_pattern('vhdl_ls.toml')(fname)
          end;
          settings = {};
        };
        on_attach = on_attach,
      }
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
    lsp.rust_hdl.setup {}
        -- lsp.zeta_note.setup{
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     cmd = {'/home/simen/.local/bin/zeta-note-linux'}
        -- }
        -- Pyright LSP
        -- lsp.pyright.setup {
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     cmd = { "pyright", "--stdio" }
        -- }
        -- if not lsp.rust_hdl then
        -- if not lsp.rust_hdl then
        --     lsp.rust_hdl = {
        --         default_config = {
        --             cmd = {"vhdl_ls"};
        --             filetypes = {'vhdl'};
        --             root_dir = function(fname)
        --                 return util.root_pattern('vhdl_ls.toml')(fname)
        --             end;
        --             -- root_dir = util.root_pattern('vhdl_ls.toml');
        --             settings = {};
        --         };
        --     }
        -- end
        -- lsp.rust_hdl.setup {};
        -- if not lsp.rust_hdl then configs['rust_hdl'] = {default_config = {}} end
        -- end
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = false,
      underline = true,
      update_in_insert = false,
    })
    vim.fn.sign_define('LspDiagnosticsSignError', {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = ""
    })
    vim.fn.sign_define('LspDiagnosticsSignWarning', {
      text = "",
      texthl = "LspDiagnosticsSignWarning",
      linehl = "",
      numhl = ""
    })
    vim.fn.sign_define('LspDiagnosticsSignInformation', {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "",
      numhl = ""
    })
    vim.fn.sign_define('LspDiagnosticsSignHint', {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = ""
    })
  end}
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
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-emoji"
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
                    { name = 'emoji' }
                },
            }
        end
    }
}

M.luasnip = {
    'L3MON4D3/LuaSnip',
    as = 'luasnip',
    config = {function()
        require("config.snippets")
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

M.telescope = {
    'nvim-telescope/telescope.nvim',
    as = 'telescope',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
        require("telescope").setup {
            defaults = {
                color_devicons = false,
                -- prompt_prefix = "   ",
                -- selection_caret = "   ",
                -- entry_prefix = "    ",
                scroll_strategy = "cycle",
                -- layout_strategy = "flex",
                -- winblend = 25,
                layout_config = {
                    height = 60,
                    preview_width = 90,
                    scroll_speed = 25
                    -- height_padding = 3,
                    -- width_padding = 10
                },
                mappings = {i = {["<C-n>"] = false, ["<C-p>"] = false}}
            },
            pickers = {
                buffers = {
                    sort_lastused = true,
                    -- previewer = true,
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
    config =
        function()
            require('telescope').load_extension('fzy_native')
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

M.undotree = {
    'mbbill/undotree',
    opt = true,
    cmd = {'UndotreeToggle'},
    config = function()
        vim.g.undotree_WindowLayout = 3
    end
}

M.gitsigns = {
    'lewis6991/gitsigns.nvim',
    as = 'gitsigns',
    requires = {'nvim-lua/plenary.nvim'}
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
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE")
        vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
        vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
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
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
    end
}

return M
