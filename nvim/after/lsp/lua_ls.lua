-- based on: https://zenn.dev/uga_rosa/articles/afe384341fc2e1

---@param names string[]
---@return Iterator<string>
local function get_plugin_paths(names)
	local plugins = require("lazy.core.config").plugins
	local paths = {}
	for _, name in ipairs(names) do
		if plugins[name] then
			table.insert(paths, plugins[name].dir .. "/lua")
		else
			vim.notify("Invalid plugin name: " .. name)
		end
	end
	return paths
end

---@param plugins string[]
---@return string[]
local function library(plugins)
	local paths = get_plugin_paths(plugins)
	table.insert(paths, vim.fn.stdpath("config") .. "/lua")
	table.insert(paths, vim.env.VIMRUNTIME .. "/lua")
	table.insert(paths, "${3rd}/luv/library")
	table.insert(paths, "${3rd}/busted/library")
	table.insert(paths, "${3rd}/luassert/library")
	return paths
end

---@type vim.lsp.Config
return {
	settings = {
		Lua = {
      runtime = {
        version = 'LuaJIT',
				pathStrict = true,
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = library({
					"lazy.nvim",
					"plenary.nvim",
					"oil.nvim",
					"nvim-lspconfig",
				})
			},
			diagnostics = {
				unusedLocalExclude = { "_*" },
			},
			format = {
				enable = false,
			},
		},
	},
}
