-- for VIME
local function setup_im_mapping()
	-- Enterキーで呼ばれる関数
	local function yank_and_close()
		-- カレントバッファ(0)のすべての行を取得
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

		-- 取得した行を改行で連結し、クリップボードレジスタ(+)に設定
		vim.fn.setreg("+", table.concat(lines, "\n"))

		-- バッファを強制的に閉じる
		vim.cmd("bdelete!")
		vim.cmd("IM")
		vim.cmd("silent !hyprctl dispatch togglespecialworkspace VIME")
	end

	-- マッピングから呼び出せるように、上記関数をグローバルに登録
	_G.__scratchpad_ime_yank_and_close = yank_and_close

	-- skkeletonの初期化とキーマッピングの設定
	vim.fn["skkeleton#initialize"]()

	-- このバッファ限定のキーマッピングを設定
	local bufnr = 0 -- 0はカレントバッファを意味する
	local opts = { buffer = bufnr, noremap = true, silent = true }
	local cmd_str = "<Cmd>lua _G.__scratchpad_ime_yank_and_close()<CR>"

	vim.keymap.set({ "n", "x" }, "<CR>", cmd_str, opts)
end

vim.api.nvim_create_user_command("IM", setup_im_mapping, { force = true })

-- File Path
-- https://github.com/kawarimidoll/dotfiles/blob/3046503f26fb837e36a16db36e705a7a6f37ef69/.config/nvim/lua/mi/commands.lua#L140C1-L154C89
local function get_range_str(opts)
	if opts.range ~= 2 then
		return ""
	end
	if opts.line1 == opts.line2 then
		return "#L" .. opts.line1
	end
	return "#L" .. opts.line1 .. "-L" .. opts.line2
end

local function copy_path(opts, target)
	local expr = "%"
	if target == "full path" then
		expr = "%:p"
	elseif target == "dir name" then
		expr = "%:p:h"
	elseif target == "file name" then
		expr = "%:t"
	end

	local path = target == "relative path" and vim.fs.relpath(vim.fn.getcwd(), vim.fn.expand("%:p"))
		or vim.fn.expand(expr)
	path = path .. get_range_str(opts)

	vim.fn.setreg("+", path)
	vim.notify("Copied " .. target .. ": " .. path)
end

vim.api.nvim_create_user_command("CopyFullPath", function(opts)
	copy_path(opts, "full path")
end, { range = true, desc = "Copy the full path of the current file to the clipboard" })

vim.api.nvim_create_user_command("CopyRelativePath", function(opts)
	copy_path(opts, "relative path")
end, { range = true, desc = "Copy the relative path of the current file to the clipboard" })

vim.api.nvim_create_user_command("CopyDirName", function(opts)
	copy_path(opts, "dir name")
end, { range = true, desc = "Copy the directory name of the current file to the clipboard" })

vim.api.nvim_create_user_command("CopyFileName", function(opts)
	copy_path(opts, "file name")
end, { range = true, desc = "Copy the file name of the current file to the clipboard" })
