local M = {}

M.packer = {
  packer = {
  'wbthomason/packer.nvim',
  config = function ()
    vim.api.nvim_set_keymap('n', '<leader>hpu', '<cmd>PackerSync<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>hps', '<cmd>PackerStatus<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>hpp', '<cmd>PackerProfile<cr>', {noremap = true, silent = true})
  end
}
}

M.config = {
  ensure_dependencies = true, -- Should packer install plugin dependencies?
  max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
  auto_clean = true, -- During sync(), remove unused plugins
  compile_on_sync = true, -- During sync(), run packer.compile()
  disable_commands = false, -- Disable creating commands
  opt_default = false, -- Default to using opt (as opposed to start) plugins
  transitive_opt = true, -- Make dependencies of opt plugins also opt by default
  transitive_disable = true, -- Automatically disable dependencies of disabled plugins
  display = {
    open_fn = function ()
      return require('packer.util').float({ border = 'single' })
    end,
    prompt_border = 'single', -- Border style of prompt popups.
    keybindings = { -- Keybindings for the display window
      quit = 'ZQ',
      toggle_info = '<CR>',
      diff = 'd',
      prompt_revert = 'r',
    }
  },
  profile = {
    enable = true,
    threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  }
}

return M
