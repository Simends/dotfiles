local M = {
  preconf = function ()
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      local maps = {['<leader>'] = {t = {
        h = {"<cmd>HlSearchLensToggle<cr>", "Hlsearch Lens"}
      }}}
      which_key.register(maps, {noremap = true, silent = true})
    end
  end,
  packer = {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup({
        calm_down = false, -- When the cursor is out of the position range of the matched instance and calm_down is true, clear all lens
        nearest_only = false, -- Only add lens for the nearest matched instance and ignore others
        nearest_float_when = 'auto', -- When to open the floating window for the nearest lens. 'auto': floating window will be opened if room isn't enough for virtual text; 'always': always use floating window instead of virtual text; 'never': never use floating window for the nearest lens
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and 'K' or 'k')
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and 'K' or 'k'
          else
            indicator = ''
          end
          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= '' then
              text = ('[%s %d/%d]'):format(indicator, idx, cnt)
            else
              text = ('[%d/%d]'):format(idx, cnt)
            end
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
          else
            text = ('[%s %d]'):format(indicator, idx)
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end
      })
      local kopts = {noremap = true, silent = true}
      vim.api.nvim_set_keymap('n', 'k', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'K', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      local maps = {g = {
        ['*'] = {[[g*<Cmd>lua require('hlslens').start()<CR>]], "Goto first search result"},
        ['#'] = {[[g#<Cmd>lua require('hlslens').start()<CR>]], "Goto last search result"}
      }}
      require('which-key').register(maps, {noremap = true, silent = true})
      vim.cmd([[
    hi! link HlSearchNear Search 
    hi! link HlSearchLens Search 
    hi! link HlSearchLensNear Search 
    hi! link HlSearchFloat Search 
    ]])
    end
  }
}

return M
