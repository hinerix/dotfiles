--- based on: https://zenn.dev/kawarimidoll/articles/b202e546bca344

local get_node_root = require("utils").get_node_root

---@type vim.lsp.Config
return {
	---@param bufnr number
	---@param on_dir fun(root_dir?: string)
	root_dir = function(bufnr, on_dir)
		local deno_markers = { "deno.json", "deno.jsonc", "deps.ts" }
		local deno_dir = vim.fs.root(bufnr, deno_markers)
		if deno_dir then
			return on_dir(deno_dir)
		end

		local node_root = get_node_root(bufnr)
		if node_root then
			return
		end

		local cwd = vim.fs.dirname(vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr)))
		return on_dir(cwd)
	end,
}
