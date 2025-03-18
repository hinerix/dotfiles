return {
	"rmagatti/auto-session",
	opts = {
		auto_restore_enabled = false,
		auto_session_suppress_dirs = { "~/", "~/hinerix/", "~/work/", "/" },
	},
	keys = {
		{ "<Leader>sr", "<cmd>SessionRestore<CR>", desc = "Restore session" },
		{ "<Leader>ss", "<cmd>SessionSave<CR>", desc = "Saves a session for auto session root dir" },
	}
}

