---@type vim.lsp.Config
return {
	cmd = { 'vtsls', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
	root_markers = {
		"package.json",
	},
	workspace_required = true,
	setting = {
		typescript = {
			format = {
				enable = false,
			},
			suggest = {
				completionFunctonCalls = true,
			},
		},
		javascript = {
			format = {
				enable = false,
			},
		},
	},
}
