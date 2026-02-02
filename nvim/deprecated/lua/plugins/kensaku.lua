return {
	"lambdalisue/vim-kensaku-search",
	lazy = false,
	dependencies = "lambdalisue/kensaku.vim",
	config = function()
		vim.keymap.set({ "c" }, "<CR>", "<Plug>(kensaku-search-replace)<CR>", { silent = true, noremap = true })
	end,
}
