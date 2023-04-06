return {
  {
    'tmhedberg/SimpylFold',
    config = function()
      vim.g.SimpylFold_docstring_preview = 0  -- Preview docstring in fold text	0
      vim.g.SimpylFold_fold_docstring = 1 -- Fold docstrings 1
      vim.b.SimpylFold_fold_docstring = 1 -- Fold docstrings (buffer local 1
      vim.g.SimpylFold_fold_import = 0 	-- Fold imports 1
      vim.b.SimpylFold_fold_import = 0 	-- Fold imports (buffer local) 	1
      vim.g.SimpylFold_fold_blank = 0 	--Fold trailing blank lines 0
      vim.b.SimpylFold_fold_blank = 0 	-- Fold trailing blanks (buffer) 0
    end,
  },
}
