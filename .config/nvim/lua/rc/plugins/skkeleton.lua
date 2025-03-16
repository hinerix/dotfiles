return {
	"vim-skk/skkeleton",
	dependencies = {
		"vim-denops/denops.vim",
	},
	config = function()
		local function skkeleton_init()
			vim.fn["skkeleton#config"]({
				globalDictionaries = { "~/.skk/SKK-JISYO.L" },
				completionRankFile = "~/.skk/skkeleton/rank.json",
				registerConvertResult = true,
				keepState = true,
				eggLikeNewline = true,
			})
			vim.fn["skkeleton#register_keymap"]("henkan", "<BS>", "henkanBackward")
			vim.fn["skkeleton#register_keymap"]("henkan", "X", "")
		end
		-- 初期化
		vim.api.nvim_create_autocmd("User", {
			pattern = "skkeleton-initialize-pre",
			callback = function()
				skkeleton_init()
			end,
		})
		vim.keymap.set({ "i", "c", "t" }, "<C-j>", "<Plug>(skkeleton-enable)", { noremap = false })
	end
}

