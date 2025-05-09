vim.diagnostic.config({
  virtual_text = true,
	float = {
		source = true,
	},
})

vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"denols",
	"html",
})

