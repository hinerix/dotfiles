-- based on: https://github.com/atusy/dotfiles/blob/ca8458a7393366e8233a636b50bd87eb7fa375f7/dot_config/nvim/lua/plugins/nvim-treesitter.lua
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("nvim-treesitter", {}),
			callback = function(c)
				local filetype = c.match
				local ok = pcall(vim.treesitter.start, c.buf)
				if ok then
					return
				end

				-- on fail, retry after installing the parser
				local ts = require("nvim-treesitter")
				local lang = vim.treesitter.language.get_lang(filetype)
				if not lang then
					return
				end
				local available_langs = ts.get_available(2)

				if not vim.tbl_contains(available_langs, lang) then
					return
				end

				ts.install({ lang }):await(function(err)
					if err then
						vim.notify(err, vim.log.levels.ERROR, { title = "nvim-treesitter" })
					end
					pcall(vim.treesitter.start, c.buf)
				end)
			end,
		})
	end,
}
