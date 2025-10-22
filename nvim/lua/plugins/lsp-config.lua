return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.api.nvim_create_user_command("LspHealth", "checkhealth vim.lsp", { desc = "LSP health check" })

		vim.diagnostic.config({
			-- https://zenn.dev/vim_jp/articles/c62b397647e3c9
			severity_sort = true,
			virtual_text = true,
			float = {
				source = true,
			},
		})

		vim.lsp.config("*", {
			capabilities = require("ddc_source_lsp").make_client_capabilities(),
		})
	end,
}
