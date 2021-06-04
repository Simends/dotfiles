local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        color_devicons = true,
    }
}

local M = {}

M.search_configfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Configs >",
        cwd = "$HOME/.config/",
    })
end

M.search_projects = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Projects >",
        cwd = "$HOME/Documents/Projects/",
    })
end

return M
