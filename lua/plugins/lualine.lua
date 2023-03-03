return {
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    dependencies = { {"folke/noice.nvim"} },
    opts = {
      options = {
        icons_enabled = false,
        theme = 'everforest',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
}
