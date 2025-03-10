return {
	"vim-skk/skkeleton",
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/ddc.vim",
	},
	config = function()
		-- skkeletonの設定
		vim.fn["skkeleton#config"]({
			globalDictionaries = { "~/.skk/SKK-JISYO.L" },
			registerConvertResult = true,
		})

		vim.fn["skkeleton#config"]({
			completionRankFile = "~/.skkeleton/rank.json"
		})

		-- キーマップ
		vim.keymap.set({ "i", "c", "t" }, "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = false })
	end
}

