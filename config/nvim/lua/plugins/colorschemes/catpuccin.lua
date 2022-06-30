local M = {
  packer = {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function ()
      require("catppuccin").setup({
        transparent_background = false,
        term_colors = false,
        styles = {
          comments = "italic",
          functions = "italic",
          keywords = "NONE",
          strings = "NONE",
          variables = "NONE",
        },
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = "NONE",
              hints = "NONE",
              warnings = "NONE",
              information = "NONE",
            },
            underlines = {
              errors = "underline",
              hints = "underline",
              warnings = "underline",
              information = "underline",
            },
          },
          lsp_trouble = false,
          cmp = true,
          lsp_saga = false,
          gitgutter = false,
          gitsigns = true,
          telescope = true,
          nvimtree = {
            enabled = false,
            show_root = false,
            transparent_panel = false,
          },
          neotree = {
            enabled = false,
            show_root = false,
            transparent_panel = false,
          },
          which_key = false,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          dashboard = false,
          neogit = false,
          vim_sneak = true,
          fern = false,
          barbar = false,
          bufferline = true,
          markdown = true,
          lightspeed = false,
          ts_rainbow = true,
          hop = false,
          notify = true,
          telekasten = false,
          symbols_outline = true,
        }
      })
    end
  }
}

return M
