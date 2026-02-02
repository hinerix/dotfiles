return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	keys = {
		{
			"<Leader>?",
			function()
				local wk = require("which-key")
				wk.show({ global = true })
			end,
			desc = "Global Keymaps (which-key)",
		},
		{
			"<Leader>?l",
			function()
				local wk = require("which-key")
				wk.show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<Leader>t", group = "Tab" },
			{ "<Leader>b", group = "Buffer" },
			{ "<Leader>e", group = "File Manager" },
			{ "<Leader>j", group = "Jump" },
			{ "<Leader>f", group = "Telescope" },
			{ "<Leader>h", group = "Hunk" },
			{ "<Leader>s", group = "Sqls" },
		})
	end,
}
