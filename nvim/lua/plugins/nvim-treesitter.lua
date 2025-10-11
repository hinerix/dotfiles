return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local nvim_treesitter = require("nvim-treesitter")
		local languages = {
			"lua",
			"markdown",
			"typescript",
			"tsx",
			"javascript",
			"html",
			"css",
			"json",
			"dockerfile",
			"yaml",
		}

		local function list_to_set(list)
			local set = {}
			for _, item in ipairs(list) do
				set[item] = true
			end
			return set
		end

		local installed_parsers = list_to_set(nvim_treesitter.get_installed("parsers"))
		local parsers_to_install = {}
		for _, lang in ipairs(languages) do
			if not installed_parsers[lang] then
				table.insert(parsers_to_install, lang)
			end
		end

		if #parsers_to_install > 0 then
			nvim_treesitter.install(parsers_to_install)
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
