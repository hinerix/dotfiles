local keymapOpts = require("utils").keymapOpts

vim.keymap.set({ "n", "v" }, "x", '"_x', keymapOpts("delete without yank"))
vim.keymap.set({ "n", "v" }, "X", '"_d$', keymapOpts("delete to end of line without yank"))
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", keymapOpts("Switch to normal mode while in terminal mode"))
vim.keymap.set("c", "<c-b>", "<left>", { desc = "Emacs like left" })
vim.keymap.set("c", "<c-f>", "<right>", { desc = "Emacs like right" })
vim.keymap.set("c", "<c-a>", "<home>", { desc = "Emacs like home" })
vim.keymap.set("c", "<c-e>", "<end>", { desc = "Emacs like end" })
vim.keymap.set("c", "<c-h>", "<bs>", { desc = "Emacs like bs" })
vim.keymap.set("c", "<c-d>", "<del>", { desc = "Emacs like del" })
vim.keymap.set("n", "<Leader>bd", "<Cmd>bdelete<CR>", keymapOpts("Delete current buffer"))
vim.keymap.set("n", "<Leader>bD", "<Cmd>bdelete!<CR>", keymapOpts("Force delete current buffer"))
vim.keymap.set("n", "<Leader>bo", "<Cmd>%bdelete|e#|bdelete#<CR>", keymapOpts("Delete all buffers except current"))
vim.keymap.set("n", "<Leader>j;", "g;zz", keymapOpts("Go to previous jump"))
vim.keymap.set("n", "<Leader>j,", "g,zz", keymapOpts("Go to next jump"))
vim.keymap.set("n", "Y", "y$", keymapOpts("yank to end of line"))
vim.keymap.set("n", "<Leader>a", "ggVG", keymapOpts("Select all"))

-- wslでgxコマンドでURLを開くための設定とキーマップ
if vim.fn.has("wsl") == 1 then
	local function open_with_wslview_detached(target)
		if not target or target == "" then
			vim.notify("gx: 対象が見つかりません。", vim.log.levels.WARN)
			return
		end

		local cleaned_target = string.gsub(target, "^file://", "") -- 例: file:///mnt/c/foo -> /mnt/c/foo

		vim.fn.jobstart({ "wslview", cleaned_target }, { detach = true })
	end

	vim.keymap.set("n", "gx", function()
		-- <cfile> はカーソル下のファイル名やURLを取得
		local target_under_cursor = vim.fn.expand("<cfile>")
		open_with_wslview_detached(target_under_cursor)
	end, keymapOpts("Open URL or Path"))
end
