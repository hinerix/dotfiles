return {
	"vim-skk/skkeleton",
	dependencies = {
		"vim-denops/denops.vim",
		"Shougo/ddc.vim",
		"Shougo/ddc-ui-native",
	},
	config = function()
		-- skkeletonの設定
		local function skkeleton_init()
			vim.fn["skkeleton#config"]({
				globalDictionaries = { "~/.skk/SKK-JISYO.L" },
				completionRankFile = "~/.skk/skkeleton/rank.json",
				registerConvertResult = true,
				keepState = true,
				eggLikeNewLine = true,
			})
			vim.fn["skkeleton#register_keymap"]("henkan", "<BS>", 'henkanBackward')
			vim.fn["skkeleton#register_keymap"]("henkan", "X", '')
		end

		-- 初期化
		vim.api.nvim_create_autocmd("User", {
			pattern = "skkeleton-initialize-pre",
			callback = function()
				skkeleton_init()
			end,
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

		vim.keymap.set({ "i", "c", "t" }, "<C-j>", "<Plug>(skkeleton-enable)", { noremap = false })

	end
}

