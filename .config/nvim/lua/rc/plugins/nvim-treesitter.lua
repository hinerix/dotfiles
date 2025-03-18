return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- optsで使用するモジュールを定義
	opts = {
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		ensure_installed = {
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
		},
	},
}
