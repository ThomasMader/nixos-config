return {
  { 
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 
    "ellisonleao/gruvbox.nvim", 
	lazy = false, 
	priority = 1000, 
	config = function()
	  local gruvbox = require('gruvbox')
	  gruvbox.load()
	end,
  },
}