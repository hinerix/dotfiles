return {
	"vim-skk/skkeleton",
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/ddc.vim",
		"Shougo/ddc-ui-native",
	},
	config = function()
		-- skkeletonの設定
		vim.fn["skkeleton#config"]({
			globalDictionaries = { "~/.skk/SKK-JISYO.L" },
			completionRankFile = "~/.skkeleton/rank.json",
			registerConvertResult = true,
			keepState = true,
		})
		-- ddcの設定
		vim.fn["ddc#custom#patch_global"]('ui', 'native')
		vim.fn["ddc#custom#patch_global"]("sources", { "skkeleton" })
		vim.fn["ddc#custom#patch_global"]({
			sourceOptions = {
				["skkeleton"] = {
					mark = "skkeleton",
					matchers = {},
					sorters = {},
					converters = {},
					isVolatile = true,
					minAutoCompleteLength = 1,
				},
			},
		})
		vim.fn["ddc#enable"]()

		-- キーマップ
		vim.keymap.set({ "i", "c", "t" }, "<C-j>", "<Plug>(skkeleton-enable)", { noremap = false })
	end
}

