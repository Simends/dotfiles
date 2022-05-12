---@diagnostic disable: missing-parameter
local M = {
  packer = {
    "goolord/alpha-nvim",
    config = function ()
      local alpha = require'alpha'
      local db = require'alpha.themes.dashboard'
      db.section.header.val = {
        [[                                                 ]],
        [[                                                 ]],
        [[                                                 ]],
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        [[                                                 ]],
        [[                                                 ]],
        [[                                                 ]],
        [[                                                 ]],
      }
      db.section.buttons.val = {
        db.button( "n", "  New file" , ":ene <BAR> startinsert <CR>"),
        db.button( "f", "  Find file" , ":Telescope find_files<cr>"),
        db.button( "s", "  Restore session" , ":Telescope session-lens search_session<cr>"),
        db.button( "q", "  Quit NVIM" , ":qa<CR>"),
      }
      local handle = io.popen('fortune')
      if handle then
        local fortune = handle:read("*a")
        handle:close()
        db.section.footer.val = fortune
      end
      db.config.opts.noautocmd = true
      vim.cmd[[autocmd User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3]]
      alpha.setup(db.config)
    end
  }
}

return M
