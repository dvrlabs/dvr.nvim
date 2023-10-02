return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    version = '2.20.8',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
}
