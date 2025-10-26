return {
		"ray-x/lsp_signature.nvim",
		lazy = true,
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_signature", {}),
				callback = function(ctx)
					local bufnr = ctx.buf
					local client = vim.lsp.get_client_by_id(ctx.data.client_id)
					if not client then
						return
					end
					-- if client.name == "copilot" or client.name == "ts_ls" then
					-- 	return
					-- end
					require("lsp_signature").on_attach({
						hint_enable = false,
						handler_opts = { border = "single" }},
						bufnr
					)
					vim.keymap.set("i", "<C-G><C-H>", require("lsp_signature").toggle_float_win, { buffer = bufnr })
				end,
			})
		end,
	}
