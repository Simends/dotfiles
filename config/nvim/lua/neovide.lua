if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_length = 0.2
  vim.g.neovide_cursor_antialiasing = true

  vim.g.gui_font_default_size = 12
  vim.g.gui_font_size = vim.g.gui_font_default_size
  vim.g.gui_font_face = "BlexMono Nerd Font,Noto Color Emoji"

  RefreshGuiFont = function()
      vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
    end

    ResizeGuiFont = function(delta)
        vim.g.gui_font_size = vim.g.gui_font_size + delta
          RefreshGuiFont()
        end

        ResetGuiFont = function()
            vim.g.gui_font_size = vim.g.gui_font_default_size
              RefreshGuiFont()
            end

            -- Call function on startup to set default value
            ResetGuiFont()
            --
            -- -- Keymaps
            --
            -- local opts = { noremap = true, silent = true }
            --
            -- vim.keymap.set({'n', 'i'}, "<C-+>", function() ResizeGuiFont(1)  end, opts)
            -- vim.keymap.set({'n', 'i'}, "<C-->", function() ResizeGuiFont(-1) end, opts)

end
