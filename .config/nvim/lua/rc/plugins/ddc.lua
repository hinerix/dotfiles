return {
	"Shougo/ddc.vim",
	event = "InsertEnter",
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/ddc-source-lsp",
		"Shougo/ddc-source-around",
		"matsui54/ddc-source-buffer",
		"LumaKernel/ddc-source-file",
		"Shougo/ddc-filter-matcher_head",
		"Shougo/ddc-filter-sorter_rank",
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
		local luasnip_callback_id = vim.fn["denops#callback#register"](
			function(body)
			require("luasnip").lsp_expand(body)
		end)

		require("luasnip.loaders.from_vscode").lazy_load()

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
					matchers = {"matcher_head"},
					sorters = {"sorter_rank"},
				},
				['around'] = { mark = "[A]" },
				['buffer'] = { mark = "[B]" },
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
					isVolatile = true,
					minAutoCompleteLength = 1,
				},
			},
		})

		vim.fn["ddc#custom#patch_global"]({
			sourceParams = {
				["buffer"] = {
					limitBytes = 5000000,
					fromAltBuf = true,
					bufNameStyle = "baseName",
				},
				["lsp"] = {
					snippetEngine = luasnip_callback_id,
				}
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

