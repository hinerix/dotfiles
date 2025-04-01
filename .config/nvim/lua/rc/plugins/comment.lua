return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local comment = require("Comment")
		local ts_comment = require("ts_context_commentstring")
		local ts_comment_integrations = require("ts_context_commentstring.integrations.comment_nvim")

		ts_comment.setup {
			enable_autocmd = false,
		}

		comment.setup {
			pre_hook = ts_comment_integrations.create_pre_hook(),
		}

	end
}
