local M = {}

---@param names string[]
---@return string[]
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
  return paths
end

M.settings = {
	Lua = {
		runtime = {
			version = "LuaJIT",
			pathStrict = true,
			path = { "?.lua", "?/init.lua" },
		},
		diagnostics = {
			unusedLocalExclude = { "_*" },
		},
		workspace = {
			library = library({
				"lazy.nvim",
			}),
			checkThirdParty = false,
		},
	},
}

return M
