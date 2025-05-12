return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		local utils = require("utils")
		local keymapOpts = utils.keymapOpts
		vim.keymap.set("n", "<Leader>hs", gitsigns.stage_hunk, keymapOpts("Stage/unstage hunks"))
	end
}
