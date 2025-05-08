return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"vtsls",
				"denols",
				"html",
				"cssls",
				"jsonls",
			},
		})
	end,
}
