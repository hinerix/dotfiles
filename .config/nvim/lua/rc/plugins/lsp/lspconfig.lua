return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local ddc_source_lsp = require("ddc_source_lsp")
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = ddc_source_lsp.make_client_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							comletion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end
}

