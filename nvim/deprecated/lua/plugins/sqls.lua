return {
	"nanotee/sqls.nvim",
	config = function()
		local keymapOpts = require("utils").keymapOpts
		vim.keymap.set({ "n", "x" }, "<Leader>sr", "<Cmd>SqlsExecuteQuery<CR>", keymapOpts("Run SQL on the buffer(or selected)"))
		vim.keymap.set("n", "<Leader>sc", "<Cmd>SqlsSwitchConnection<CR>", keymapOpts("Choice a connection"))
		vim.keymap.set("n", "<Leader>sd", "<Cmd>SqlsSwitchDatabase<CR>", keymapOpts("Choice a database"))
		vim.keymap.set("n", "<Leader>st", "<Cmd>SqlsShowTables<CR>", keymapOpts("Show connectioins on current connection"))
	end,
}
