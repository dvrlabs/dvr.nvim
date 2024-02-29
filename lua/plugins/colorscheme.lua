return {
  { -- The forest
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'everforest'
      vim.g.everforest_background = 'hard'
    end,
  },
}




