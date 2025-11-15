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
		"matsui54/ddc-source-buffer",
		"LumaKernel/ddc-source-file",
		"Shougo/ddc-filter-sorter_rank",
		"tani/ddc-fuzzy",
		-- "Shougo/pum.vim",
		{ dir = "~/dev/pum.vim", dev = true },
		"Shougo/ddc-ui-pum",
		"Shougo/ddc-ui-native",
		"vim-skk/skkeleton",
	},
	config = function()
		vim.fn["ddc#custom#load_config"](vim.fn.expand("~/.config/nvim/lua/plugins/ddc/init.ts"))
		vim.fn["ddc#enable"]()

		-- on insert
		vim.keymap.set("i", "<c-x><c-f>", function()
			vim.fn["ddc#map#manual_complete"]({ sources = { "file" } })
		end)
	end,
}
