return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	config = function()
		local render_markdown = require("render-markdown")

		render_markdown.setup({
			completions = { blink = { enabled = true } },
			sign = { enabled = false },
			latex = { enabled = false },
			heading = {
				render_modes = true,
				icons = { "󰬺  ", "󰬻  ", "󰬼  ", "󰬽  ", "󰬾  ", "󰬿  " },
				position = "inline",
				backgrounds = {},
			},
			checkbox = {
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰄵 " },
				custom = { todo = { rendered = " " } },
			},
			pipe_table = { preset = "round" },
			link = {
				custom = {
					python = { pattern = "%.py$", icon = "󰌠 " },
					markdown = { pattern = "%.md$", icon = "󰍔 " },
				},
			},
		})

		vim.keymap.set("n", "<leader>mr", function()
			render_markdown.toggle()
		end, { desc = "[M]arkdown [R]ender toggle" })
		local C = require("catppuccin.palettes").get_palette()
		vim.api.nvim_set_hl(0, "@markup.quote", { fg = C.text, bold = false })
		vim.api.nvim_set_hl(0, "@markup.link.label", { fg = C.lavender, bold = false })
		vim.api.nvim_set_hl(0, "@markup.link.url", { fg = C.lavender, bold = false })
		vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = C.lavender, bold = false })
		vim.api.nvim_set_hl(0, "RenderMarkdownWikiLink", { fg = C.lavender, bold = false })
	end,
}
