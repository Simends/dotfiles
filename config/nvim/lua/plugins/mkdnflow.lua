local M = {
  packer = {
    'jakewvincent/mkdnflow.nvim',
    config = function()
      require('mkdnflow').setup({
        -- Config goes here; leave blank for defaults
        -- Type: boolean. Use default mappings (see '❕Commands and default
        --     mappings').
        -- 'false' disables mappings
        default_mappings = true,

        -- Type: boolean. Create directories (recursively) if link contains a
        --     missing directory.
        -- 'false' prevents missing directories from being created
        create_dirs = true,

        -- Type: string. Navigate to links relative to the directory of the first-
        --     opened file.
        -- 'current' navigates links relative to currently open file
        links_relative_to = 'first',

        -- Type: key-value pair(s). The plugin's features are enabled only when one
        -- of these filetypes is opened; otherwise, the plugin does nothing.
        filetypes = {md = true, rmd = true, markdown = true},

        -- Type: boolean. When true, the createLinks() function tries to evaluate
        --     the string provided as the value of new_file_prefix.
        -- 'false' results in the value of new_file_prefix being used as a string,
        --     i.e. it is not evaluated, and the prefix will be invariant.
        evaluate_prefix = false,

        -- Type: string. Defines the prefix that should be used to create new links.
        --     This is evaluated at the time createLink() is run, which is to say
        --     that it's run whenever <CR> is pressed (under the default mappings).
        --     This makes for many interesting possibilities.
        new_file_prefix = '',
      })
    end
  }
}

return M
