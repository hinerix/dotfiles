-- 頻出の設定のユーティリティ関数
local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- xキーで削除したときに yank register に保存しないようにする
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })

-- ターミナルモードでノーマルモードにする
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Emacs keybinds
vim.keymap.set("c", "<c-b>", "<left>", { desc = "Emacs like left" })
vim.keymap.set("c", "<c-f>", "<right>", { desc = "Emacs like right" })
vim.keymap.set("c", "<c-a>", "<home>", { desc = "Emacs like home" })
vim.keymap.set("c", "<c-e>", "<end>", { desc = "Emacs like end" })
vim.keymap.set("c", "<c-h>", "<bs>", { desc = "Emacs like bs" })
vim.keymap.set("c", "<c-d>", "<del>", { desc = "Emacs like del" })

----------------------------
-- Buffers
----------------------------
vim.keymap.set("n", "<Leader>bd", "<Cmd>bdelete<CR>", opts("Delete current buffer"))
vim.keymap.set("n", "<Leader>bD", "<Cmd>bdelete!<CR>", opts("Force delete current buffer"))
vim.keymap.set("n", "<Leader>bo", "<Cmd>%bdelete|e#|bdelete#<CR>", opts("Delete all buffers except current"))

----------------------------
-- jump
----------------------------
vim.keymap.set("n", "<Leader>j;", "g;zz", opts("Go to previous jump"))
vim.keymap.set("n", "<Leader>j,", "g,zz", opts("Go to next jump"))

-- wslでgxコマンドでURLを開くための設定とキーマップ
if vim.fn.has('wsl') == 1 then
  local function open_with_wslview_detached(target)
    if not target or target == "" then
      vim.notify("gx: 対象が見つかりません。", vim.log.levels.WARN)
      return
    end

   local cleaned_target = string.gsub(target, "^file://", "") -- 例: file:///mnt/c/foo -> /mnt/c/foo

    vim.fn.jobstart({'wslview', cleaned_target}, {detach = true})
  end

  vim.keymap.set('n', 'gx', function()
    -- <cfile> はカーソル下のファイル名やURLを取得
    local target_under_cursor = vim.fn.expand("<cfile>")
    open_with_wslview_detached(target_under_cursor)
  end, opts("WSL: カーソル下のパス/URLをwslviewで開く"))
end
