return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.api.nvim_create_user_command("LspHealth", "checkhealth vim.lsp", { desc = "LSP health check" })

		local augroup = vim.api.nvim_create_augroup('lsp-config.lua', {})
		vim.api.nvim_create_autocmd({ 'LspAttach' }, {
			group = augroup,
			callback = function(args)
				-- https://github.com/kawarimidoll/dotfiles/blob/13a3cfc20fd0bcd748a2d49f3e47ad4d5eba8b5e/.config/nvim/deprecated/minideps.lua#L148C1-L154C10
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client:supports_method('text/Document/inlayHint', bufnr) then
					vim.lsp.inlay_hint.enable(true, { bufnr })
					vim.keymap.set('n', 'grh', function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
					end, {desc = "Toggle inlayHints" })
				end

				vim.keymap.set('n', 'K', function ()
					vim.lsp.buf.hover({ border = 'single' })
				end, { buffer = bufnr })

			end
		})

		vim.diagnostic.config({
			-- https://zenn.dev/vim_jp/articles/c62b397647e3c9
			severity_sort = true,
			underline = false,
			virtual_text = true,
			float = {
				source = true,
				border = "single",
			},
		})

		vim.lsp.config("*", {
			capabilities = require("ddc_source_lsp").make_client_capabilities(),
		})
	end,
}
