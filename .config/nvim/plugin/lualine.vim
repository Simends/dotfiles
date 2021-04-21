
" LUALINE CONFIG

let g:lualine = {
    \'options' : {
    \  'theme' : 'palenight',
    \  'section_separators' : [' ', ' '],
    \  'component_separators' : ['|', '|'],
    \  'icons_enabled' : v:true,
    \},
    \'sections' : {
    \  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
    \  'lualine_b' : [ 'filetype' ],
    \  'lualine_c' : [ ['filename', {'file_status': v:true,},], ],
    \  'lualine_x' : [ 'encoding', 'fileformat' ],
    \  'lualine_y' : [ ['branch', {'icon': '',}, ], ],
    \  'lualine_z' : [ 'progress' ],
    \},
    \'inactive_sections' : {
    \  'lualine_a' : [  ],
    \  'lualine_b' : [  ],
    \  'lualine_c' : [ 'filename' ],
    \  'lualine_x' : [ 'location' ],
    \  'lualine_y' : [  ],
    \  'lualine_z' : [  ],
    \},
    \'extensions' : [ 'fzf' ],
    \}
lua require("lualine").setup()
