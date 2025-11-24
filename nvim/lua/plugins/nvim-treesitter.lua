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
				require("nvim-treesitter")
				local ok = pcall(vim.treesitter.start, c.buf)
				if ok then
					return
				end
				-- on fail, retry after installing the parser
				local lang = vim.treesitter.language.get_lang(filetype)
				require("nvim-treesitter").install({ lang }):await(function(err)
					if err then
						vim.notify(err, vim.log.levels.ERROR, { title = "nvim-treesitter" })
					end
					pcall(vim.treesitter.start, c.buf)
				end)
			end,
		})
	end,
}
