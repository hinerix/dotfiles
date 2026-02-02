-- https://github.com/kawarimidoll/dotfiles/blob/master/.config/nvim/after/lsp/denols.lua

local get_node_root = require("config.utils").get_node_root

---@type vim.lsp.Config
return {
	---@param bufnr number
	---@param on_dir fun(root_dir?: string)
	root_dir = function(bufnr, on_dir)
		local deno_markers = { "deno.json", "deno.jsonc", "deps.ts" }
		local deno_dir = vim.fs.root(bufnr, deno_markers)
		if deno_dir then
			return
		end

		local node_root = get_node_root(bufnr)
		if node_root then
			return on_dir(node_root)
		end
	end,
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = {
					enabled = "literals",
					suppressWhenArgumentMatchesName = true,
				},
				propertyDeclarationTypes = { enabled = true },
				enumMemberValues = { enabled = true },
				parameterTypes = { enabled = false },
				functionLikeReturnTypes = { enabled = false },
				variableTypes = { enabled = false },
			},
			preferences = { preferTypeOnlyAutoImports = true },
			preferGoToSourceDefinition = true,
		},
		javascript = {
			preferGoToSourceDefinition = true,
		},
	},
}
