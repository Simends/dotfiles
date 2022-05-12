local M = {
  packer = {
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
}

return M
