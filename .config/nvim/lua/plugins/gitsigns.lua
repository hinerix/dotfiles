return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		local utils = require("utils")
		local keymapOpts = utils.keymapOpts
		vim.keymap.set("n", "<Leader>hs", gitsigns.stage_hunk, keymapOpts("Stage/unstage hunks"))
		vim.keymap.set("n", "<Leader>hr", gitsigns.reset_hunk, keymapOpts("Reset hunks"))

		vim.keymap.set("v", "<Leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, keymapOpts("Stage/unstage hunks"))

		vim.keymap.set("v", "<Leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, keymapOpts("Reset hunks"))
	end
}
