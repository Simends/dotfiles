local M = {
  packer = {
    'sainnhe/gruvbox-material',
    config = function ()
      vim.g.gruvbox_material_palette = 'mix'
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_enable_bold = 1
    end
  }
}

return M
