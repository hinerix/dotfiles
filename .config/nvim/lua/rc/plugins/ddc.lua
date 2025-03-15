return {
	"Shougo/ddc.vim",
	event = "InsertEnter",
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/ddc-source-lsp",
		"Shougo/ddc-source-around",
		"matsui54/ddc-source-buffer",
		"LumaKernel/ddc-source-file",
		"Shougo/ddc-filter-sorter_rank",
		"tani/ddc-fuzzy",
		"Shougo/pum.vim",
		"Shougo/ddc-ui-pum",
		"vim-skk/skkeleton",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				"rafamadriz/friendly-snippets"
			},
		},
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load() -- frienly-snippetsの設定

		vim.fn["ddc#custom#patch_global"]("ui", "pum")
		vim.fn["ddc#custom#patch_global"]({
			sources = {
				"lsp",
				"file",
				"buffer",
				"around",
				"skkeleton",
			}
		})

		vim.fn["ddc#custom#patch_global"]({
			sourceOptions = {
				["_"] = {
					matchers = { "matcher_fuzzy" },
					sorters = { "sorter_fuzzy" },
					converters = { "converter_fuzzy" },
					maxItems = 15,
				},
				['around'] = { mark = "[Around]" },
				['buffer'] = { mark = "[Buffer]" },
				['file'] = {
					mark = "[F]",
					isVolatile = true,
					forceCompletionPattern = "\\S/\\S*",
				},
				["lsp"] = {
					mark = "[LSP]",
					forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
				},
				["skkeleton"] = {
					mark = "[skk]",
					matchers = {},
					sorters = { "sorter_rank" },
					isVolatile = true,
					minAutoCompleteLength = 1,
				},
			},
		})

		vim.fn["ddc#custom#patch_global"]({
			sourceParams = {
				["buffer"] = {
					fromAltBuf = true,
					bufNameStyle = "baseName",
				},
				["lsp"] = {
					enableResolveItem = true,
					enableAddtionalTextEdit = true,
					snippetEngine = vim.fn["denops#callback#register"](function(body)
						require("luasnip").lsp_expand(body)
					end),
				},
			},
		})

		vim.fn["ddc#enable"]()

		vim.keymap.set("i", "<C-n>",
			function ()
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
	end
}

