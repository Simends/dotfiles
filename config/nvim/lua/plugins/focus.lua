local M = {
  packer = {
    'beauwilliams/focus.nvim',
    config = function()
      require("focus").setup({
        number = false,
        relativenumber = false,
        hybridnumber = false,
        signcolumn = false,
        cursorline = true,
        cursorcolumn = false,
        compatible_filetrees = {'undotree', 'outline'},
        excluded_filetypes = {'qf'},
        excluded_buftypes = {'nofile', 'prompt', 'popup', 'help'},
        winhighlight = false
      })
      vim.api.nvim_set_keymap('n', '<M-h>', ':FocusSplitNicely<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-k>', ':FocusSplitNicely cmd term<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-e>', ':FocusSplitCycle<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-i>', ':FocusSplitCycle reverse<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-m>', ':FocusMaxOrEqual<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-n>', ':vertical 1res -10<cr>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-o>', ':vertical 1res +10<cr>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-Cr>', [[<C-w>t]], { silent = true })
      vim.api.nvim_set_keymap('n', '<M-1>', ':1tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-2>', ':2tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-3>', ':3tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-4>', ':4tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-5>', ':5tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-6>', ':6tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-7>', ':7tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-8>', ':8tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-9>', ':9tabnext<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-Tab>', ':tabnext #<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<M-t>', ':tabnew<CR>', { silent = true })
      vim.api.nvim_set_keymap('t', '<M-e>', [[<C-\><C-n>:FocusSplitCycle<CR>]], { silent = true })
      vim.api.nvim_set_keymap('t', '<M-i>', [[<C-\><C-n>:FocusSplitCycle reverse<CR>]], { silent = true })
      vim.api.nvim_set_keymap('t', '<M-h>', [[<C-\><C-n>:FocusSplitNicely<CR>]], { silent = true })
      vim.api.nvim_set_keymap('t', '<M-k>', [[<C-\><C-n>:FocusSplitNicely cmd term<CR>]], { silent = true })
    end
  }
}

return M
