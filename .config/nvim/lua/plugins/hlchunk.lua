return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		chunk = {
			enable = true,
			exclude_filetypes = {
				markdown = true,
			},
		},
		indent = {
			enable = true,
			exclude_filetypes = {
				markdown = true,
			},
		},
		line_num = {
			enable = true,
			use_treesitter = true,
			exclude_filetypes = {
				markdown = true,
			},
		},
		blank = {
			enable = false,
		},
	},
}
