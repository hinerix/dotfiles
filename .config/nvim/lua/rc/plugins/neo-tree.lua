return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
	opts = {
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
	},
}

