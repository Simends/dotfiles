local M = {
  packer = {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      {"saadparwaiz1/cmp_luasnip", after = 'luasnip'},
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help"
    },
    config = {
      function()
        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        local kind_icons = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = ""
        }

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
          formatting = {
            format = function(entry, vim_item)
              -- Kind icons
              vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
              -- Source
              vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                path = "[Path]",
                luasnip = "[LuaSnip]",
              })[entry.source.name]
              return vim_item
            end
          },
          sources = {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'buffer' },
          },
        }
      end
    }
  }
}

return M
