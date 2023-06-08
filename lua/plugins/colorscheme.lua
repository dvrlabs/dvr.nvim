return {
   -- {
   -- 'loctvl842/monokai-pro.nvim',
   --  priority = 1000,
   --  config = function()
   --    vim.cmd.colorscheme 'monokai-pro'
   --  end,
   -- },
  { -- The forest
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'everforest'
      vim.g.everforest_background = 'hard'
    end,
  },
}

