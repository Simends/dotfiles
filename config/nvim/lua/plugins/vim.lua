local M = {}

M.undotree = {
  packer = {
    'mbbill/undotree',
    opt = true,
    cmd = {'UndotreeToggle'},
    config = function()
      vim.g.undotree_WindowLayout = 3
    end
  }
}

M.sneak = {
  packer = {
    'justinmk/vim-sneak'
  }
}

M.easyalign = {
  packer = {
    'junegunn/vim-easy-align'
  }
}

M.surround = {
  packer = {
    'tpope/vim-surround',
    requires = 'tpope/vim-repeat'
  }
}

M.commentary_vim = {
  packer = {
    'tpope/vim-commentary'
  }
}

M.capslock = {
  packer = {
    'tpope/vim-capslock'
  }
}

M.speeddating = {
  packer = {
    'tpope/vim-speeddating',
    requires = 'tpope/vim-repeat'
  }
}

M.vinegar = {
  packer = {
    'tpope/vim-vinegar'
  }
}

M.unimpaired = {
  packer = {
    'tpope/vim-unimpaired'
  }
}

M.fugitive = {
  packer = {
    'tpope/vim-fugitive'
  }
}

M.vimtex = {
  packer = {
    'lervag/vimtex',
    opt = true,
    ft = 'tex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'
    end
  }
}

return M
