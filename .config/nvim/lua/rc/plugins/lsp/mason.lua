return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	opts = {},
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		mason_lspconfig.setup({
			ensure_installed = {
				-- lua
				"lua_ls",
				-- docker
				"dockerls",
				"docker_compose_language_service",
				-- css
				"cssls",
				"cssmodules_ls",
				"tailwindcss",
				-- html
				"html",
				-- typescript
				"ts_ls",
				-- json
				"jsonls",
				-- yaml
				"yamlls",
				-- linter, formatter
				"biome",
			},
		})
	end,
}
