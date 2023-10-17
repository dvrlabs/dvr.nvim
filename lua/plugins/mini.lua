local header_txt = [[
________      _______
|  __ \ \    / /  __ \
| |  | \ \  / /| |__) |
| |  | |\ \/ / |  _  /
| |__| | \  /  | | \ \
|_____/   \/   |_|  \_\
]]

local footer_txt = [[
Github:
https://github.com/dvrlabs/dvr.nvim

Contact: 
dvrlabs.tv@gmail.com
]]


return {
    {
        'echasnovski/mini.nvim',
        version = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('mini.animate').setup()
            -- require('mini.sessions').setup({
            --   file = '.session.vim',
            --  })
            -- Switching to barbar.
            --require('mini.tabline').setup()
            require('mini.comment').setup()
            require('mini.starter').setup({
                header = header_txt,
                footer = footer_txt,
            })
        end,
    },
}


