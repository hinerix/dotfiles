return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")
		toggleterm.setup({
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			direction = "float",
		})
	end,
}

