return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	opts = {
		render_modes = true,
		completions = { lsp = { enabled = true } },
		sign = { enabled = false },
		heading = {
			position = "inline",
			backgrounds = {},
		},
		code = {
			width = "block",
			left_pad = 2,
			right_pad = 4,
		},
	},
}
