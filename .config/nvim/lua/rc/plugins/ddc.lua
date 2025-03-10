return {
	"Shougo/ddc.vim",
	dependencies = {
		"vim-denops/denops.vim",
		"vim-skk/skkeleton",
	},
	config = function()
		vim.fn["ddc#custom#patch_global"]("sources", { "skkeleton" })
		vim.fn["ddc#custom#patch_global"]({
			sourceOptions = {
				_ = {
					matchers = { "matcher_head" },
					sorters = {"sorter_rank" },
				},
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
	end
}

