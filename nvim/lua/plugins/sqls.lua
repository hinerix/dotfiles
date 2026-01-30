return {
	"nanotee/sqls.nvim",
	config = function()
		local keymapOpts = require("utils").keymapOpts
		vim.keymap.set({ "n", "v" }, "<Leader>sr", "<Cmd>SqlsExecuteQuery<CR>", keymapOpts("Run SQL on the buffer(or selected)"))
		vim.keymap.set("n", "<Leader>sc", "<Cmd>SqlsConnectionChoice<CR>", keymapOpts("Choice a connection"))
		vim.keymap.set("n", "<Leader>sd", "<Cmd>SqlsDatabaseChoice<CR>", keymapOpts("Choice a database"))
		vim.keymap.set("n", "<Leader>st", "<Cmd>SqlsShowTables<CR>", keymapOpts("Show connectioins on current connection"))
	end,
}
