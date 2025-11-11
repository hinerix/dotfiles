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
		"Shougo/pum.vim",
		"Shougo/ddc-ui-pum",
		"vim-skk/skkeleton",
	},
	config = function()
		vim.fn["ddc#custom#load_config"](vim.fn.expand("~/.config/nvim/lua/plugins/ddc/init.ts"))
		vim.fn["ddc#enable"]()
		vim.fn["pum#set_option"]({
			preview = true,
			preview_border = "single",
			preview_width = 60,
			preview_height = 20,
		})

		vim.keymap.set({ "i", "c" }, "<c-n>", function()
			if vim.fn["pum#visible"]() == true then
				return "<Cmd>call pum#map#insert_relative(+1)<CR>"
			end
			if vim.api.nvim_get_mode().mode == "c" then
				return "<Cmd>call ddc#map#manual_complete()<CR>"
			end
			local col = vim.fn.col(".")
			local line = vim.fn.getline(".")
			if col > 1 and type(line) == "string" and string.match(vim.fn.strpart(line, col - 2), "%s") == nil then
				return "<Cmd>call ddc#map#manual_complete()<CR>"
			end
			return "<c-n>"
		end, { expr = true })
		vim.keymap.set({ "i", "c" }, "<c-p>", function()
			if vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#insert_relative(-1)<CR>"
			end
			return "<c-p>"
		end, { expr = true })
		vim.keymap.set({ "i", "c" }, "<c-y>", function()
			if vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#confirm()<CR>"
			end
			return "<c-y>"
		end, { expr = true })
		vim.keymap.set({ "i", "c" }, "<c-c>", function()
			if vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#cancel()<CR>"
			end
			if vim.api.nvim_get_mode().mode == "c" then
				return "<c-u><c-c>"
			end
			return "<c-c>"
		end, { expr = true })

		-- on insert
		vim.keymap.set("i", "<c-x><c-f>", function()
			vim.fn["ddc#map#manual_complete"]({ sources = { "file" } })
		end)
	end,
}
