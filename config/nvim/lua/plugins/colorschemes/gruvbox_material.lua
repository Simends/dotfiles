local M = {
  packer = {
    'sainnhe/gruvbox-material',
    config = function ()
      vim.g.gruvbox_material_palette = 'mix'
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_enable_bold = 1
      vim.cmd('set background=dark')
      vim.cmd('colorscheme gruvbox-material')
      -- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
      -- vim.cmd("hi NormalFloat guibg=NONE ctermbg=NONE")
      -- vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
      -- vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
    end
  }
}

return M
