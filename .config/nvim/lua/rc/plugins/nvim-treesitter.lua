return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- optsで使用するモジュールを定義
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		autotag = {
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
