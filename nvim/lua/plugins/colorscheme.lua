return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")
		catppuccin.setup({
			integrations = {
				which_key = true,
			},
		})
		vim.cmd([[colorscheme catppuccin-mocha]])
	end,
}
