local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Escでハイライトを消す
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', opts("Clean highlight"))

-- 削除したときに yank register に保存しないようにする
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
-- keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })

-----------------------------
-- Window
----------------------------
vim.keymap.set("n", "<Leader>w-", ":split<CR>", opts("Split window horizontally"))
vim.keymap.set("n", "<Leader>w\\", ":vsplit<CR>", opts("Split window vertically"))
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', opts('Move focus to the left window'))
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', opts('Move focus to the right window'))
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', opts('Move focus to the lower window'))
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', opts('Move focus to the upper window'))
vim.keymap.set("n", "<Leader>wo", ":only<CR>", opts("Close all other windows"))
vim.keymap.set("n", "<Leader>wq", ":close<CR>", opts("Close current window"))

----------------------------
-- Tab
----------------------------
vim.keymap.set("n", "<Leader>tc", "<Cmd>tabnew<CR>", opts("Open new tab"))
vim.keymap.set("n", "<Leader>tq", "<Cmd>tabclose<CR>", opts("Close current tab"))

vim.keymap.set("n", "<Leader>tn", "<Cmd>tabnext<CR>", opts("Go to next tab"))
vim.keymap.set("n", "<Leader>tp", "<Cmd>tabprevious<CR>", opts("Go to previous tab"))
vim.keymap.set("n", "<Leader>tF", "<Cmd>tabfirst<CR>", opts("Go to first tab"))
vim.keymap.set("n", "<Leader>tL", "<Cmd>tablast<CR>", opts("Go to last tab"))

vim.keymap.set("n", "<Leader>to", "<Cmd>tabonly<CR>", opts("Close all tabs except current"))
vim.keymap.set("n", "<Leader>tf", "<Cmd>tabnew %<CR>", opts("Open current buffer in new tab"))
