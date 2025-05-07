return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			separator_style = "slant",
			indicator = {
				style = "underline",
			},
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			hover = {
				enabled = true,
				delay = 0,
				reveal = { "close" },
			},
		},
	},
}
