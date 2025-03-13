return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
	config = function()
		require("neo-tree").setup({
			filtered_items = {
				hide_dotfiles = false,
			},
			follow_current_file = {
				enabled = true,
			},
			filesystem = {
				window = {
					mappings = {
						['<Leader>e'] = 'close_window',
						['<space>'] = 'noop',
					},
				},
			},
		})
		vim.keymap.set("n", "<Leader>e", ":Neotree reveal<CR>", {
			noremap = true,
			silent = true,
			desc = "focus on neo-tree",
		})
	end
}

