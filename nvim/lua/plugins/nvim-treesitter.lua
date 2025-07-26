return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"markdown",
			"typescript",
			"tsx",
			"javascript",
			"html",
			"css",
			"json",
			"dockerfile",
			"yaml",
		})
	end
}
