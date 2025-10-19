return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = {
		"refractalize/oil-git-status.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	cmd = { "Oil" },
	keys = {
		{
			"<leader>e",
			function()
				vim.cmd.Oil()
			end,
		},
	},
	opts = function()
		local custom_actions = require("plugins.oil.actions")
		---@type oil.setupOpts
		return {
			keymaps = {
				["?"] = "actions.show_help",
				["gx"] = "actions.open_external",
				["<CR>"] = "actions.select",
				["-"] = "actions.parent",
				["<C-p>"] = "actions.preview",
				["gp"] = custom_actions.weztermPreview,
				["<esc>"] = "actions.close",
				["q"] = nil,
				["<C-l>"] = "actions.refresh",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					local ignore_list = { ".DS_Store" }
					return vim.tbl_contains(ignore_list, name)
				end,
			},
			skip_confirm_for_simple_edits = true,
			use_default_keymaps = false,
			delete_to_trash = true,
			watch_for_changes = true,
			win_options = {
				signcolumn = "yes:2",
			},
		}
	end,
	config = function(_, opts)
		require("oil").setup(opts)
		require("oil-git-status").setup(_)
	end,
}
