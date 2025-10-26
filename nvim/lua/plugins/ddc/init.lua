return {
	"Shougo/ddc.vim",
	event = "InsertEnter",
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/ddc-source-lsp",
		"Shougo/ddc-source-around",
		"Shougo/ddc-source-input",
		"Shougo/ddc-source-cmdline",
		"Shougo/ddc-source-cmdline_history",
		"Shougo/ddc-source-shell_native",
		"Shougo/ddc-source-shell_history",
		"matsui54/ddc-source-buffer",
		"LumaKernel/ddc-source-file",
		"Shougo/ddc-filter-sorter_rank",
		"tani/ddc-fuzzy",
		"Shougo/pum.vim",
		"Shougo/ddc-ui-pum",
		"vim-skk/skkeleton",
	},
	config = function()
		vim.fn["ddc#custom#load_config"](vim.fn.expand("~/.config/nvim/lua/plugins/ddc/init.ts"))
		vim.fn["ddc#enable"]()

		vim.keymap.set("i", "<C-n>", function()
			if vim.fn["pum#visible"]() == true then
				vim.fn["pum#map#select_relative"](1)
			else
				vim.fn["ddc#map#manual_complete"]()
			end
		end)
		vim.keymap.set("i", "<C-p>", "<Cmd>call pum#map#select_relative(-1)<CR>")
		vim.keymap.set("i", "<C-y>", "<Cmd>call pum#map#confirm()<CR>")
		vim.keymap.set("i", "<C-e>", "<Cmd>call pum#map#cancel()<CR>")
		vim.keymap.set("i", "<C-f>", "<Cmd>call pum#map#select_relative_page(1)<CR>")
		vim.keymap.set("i", "<C-b>", "<Cmd>call pum#map#select_relative_page(-1)<CR>")
	end,
}
