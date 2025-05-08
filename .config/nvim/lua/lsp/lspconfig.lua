return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"vtsls",
			},
		})
	end,
}
