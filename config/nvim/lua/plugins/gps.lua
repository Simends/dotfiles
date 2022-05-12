local M = {
  packer = {
    "SmiteshP/nvim-gps",
    after = 'treesitter',
    config = function()
      local util = require('util.misc')
      local class_color = util.create_statusline_hl('GpsClassStatusLine', 'CmpItemKindClass')
      local funct_color = util.create_statusline_hl('GpsFunctionStatusLine', 'CmpItemKindFunction')
      local method_color = util.create_statusline_hl('GpsMethodStatusLine', 'CmpItemKindMethod')
      local container_color = util.create_statusline_hl('GpsContainerStatusLine', 'CmpItemKindModule')
      local tag_color = util.create_statusline_hl('GpsTagStatusLine', 'CmpItemKindValue')
      require("nvim-gps").setup({
        icons = {
          ["class-name"] = '%#' .. class_color .. '# ',      -- Classes and class-like objects
          ["function-name"] = '%#' .. funct_color .. '# ',   -- Functions
          ["method-name"] = '%#' .. method_color .. '# ',     -- Methods (functions inside class-like objects)
          ["container-name"] = '%#' .. container_color .. '# ',  -- Containers (example: lua tables)
          ["tag-name"] = '%#' .. tag_color .. '#炙'         -- Tags (example: html tags)
        },

        separator = '%#StatusLine#  ',

        -- limit for amount of context shown
        -- 0 means no limit
        depth = 0,

        -- indicator used when context hits depth limit
        depth_limit_indicator = "..."
      })
    end
  }
}

return M
