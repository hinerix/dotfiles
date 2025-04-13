return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
			},
		})

		vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<Leader>fr", builtin.oldfiles, { desc = "Recent files" })
		vim.keymap.set("n", "<Leader>fk", builtin.keymaps, { desc = "KeyMaps" })
		vim.keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "Help tags" })
		vim.keymap.set("n", "<Leader>fc", builtin.command_history, { desc = "Command histories" })
		vim.keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<Leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
	end,
}
