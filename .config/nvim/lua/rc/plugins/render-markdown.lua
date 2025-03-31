return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "quarto" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	opts = {
		render_modes = true,
		completions = { lsp = { enabled = true } },
		sign = { enabled = false },
	}
}
