local M = {
  packer = {
    mkdn = {
    'jakewvincent/mkdnflow.nvim',
    config = function()
      require('mkdnflow').setup({
        filetypes = {md = true, rmd = true, markdown = true},
        create_dirs = true,
        perspective = {
          priority = 'first',
          fallback = 'current',
          root_tell = false,
          nvim_wd_heel = true
        },
        wrap = false,
        bib = {
          default_path = nil,
          find_in_root = true
        },
        silent = false,
        use_mappings_table = true,
        links = {
          style = 'markdown',
          implicit_extension = nil,
          transform_implicit = false,
          transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            return(text)
          end
        },
        to_do = {
          symbols = {' ', '-', 'X'},
          update_parents = true,
          not_started = ' ',
          in_progress = '-',
          complete = 'X'
        },
        mappings = {
          MkdnNextLink = {'n', '<Tab>'},
          MkdnPrevLink = {'n', '<S-Tab>'},
          MkdnNextHeading = {'n', '<leader>]'},
          MkdnPrevHeading = {'n', '<leader>['},
          MkdnGoBack = {'n', '<BS>'},
          MkdnGoForward = {'n', '<Del>'},
          MkdnFollowLink = {{'n', 'v'}, '<CR>'},
          MkdnDestroyLink = {'n', '<M-CR>'},
          MkdnMoveSource = {'n', '<F2>'},
          MkdnYankAnchorLink = {'n', 'ya'},
          MkdnYankFileAnchorLink = {'n', 'yfa'},
          MkdnIncreaseHeading = {'n', '+'},
          MkdnDecreaseHeading = {'n', '-'},
          MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
          MkdnNewListItem = false,
          MkdnExtendList = false,
          MkdnUpdateNumbering = {'n', '<leader>nn'}
        }
      })
    end
  },
  }
}

return M
