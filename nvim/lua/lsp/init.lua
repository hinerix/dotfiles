vim.api.nvim_create_user_command("LspHealth", "checkhealth vim.lsp", { desc = "LSP health check" })

vim.diagnostic.config({
	virtual_text = true,
	float = {
		source = true,
	},
})

vim.lsp.config("*", {
	capabilities = require("ddc_source_lsp").make_client_capabilities(),
})

vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"denols",
	"html",
})
