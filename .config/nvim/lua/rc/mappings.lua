local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Escでハイライトを消す
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts("Clean highlight"))

-- xキーで削除したときに yank register に保存しないようにする
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })

----------------------------
-- Tab
----------------------------
vim.keymap.set("n", "<Leader>tc", "<Cmd>tabnew<CR>", opts("Open new tab"))
vim.keymap.set("n", "<Leader>tq", "<Cmd>tabclose<CR>", opts("Close current tab"))
vim.keymap.set("n", "[t", ":tabprevious<CR>",opts("Go to previous tab"))
vim.keymap.set("n", "]t", ":tabnext<CR>", opts("Go to next tab"))
vim.keymap.set("n", "[T", ":tabfirst<CR>", opts("Go to first tab"))
vim.keymap.set("n", "]T", ":tablast<CR>", opts("Go to last tab"))

----------------------------
-- Buffers
----------------------------
im.keymap.set("n", "<Leader>bd", "<Cmd>bdelete<CR>", opts("Delete current buffer"))
vim.keymap.set("n", "<Leader>bD", "<Cmd>bdelete!<CR>", opts("Force delete current buffer"))
vim.keymap.set("n", "<Leader>bo", "<Cmd>%bdelete|e#|bdelete#<CR>", opts("Delete all buffers except current"))

----------------------------
-- jump
----------------------------
vim.keymap.set("n", "<Leader>j;", "g;zz", opts("Go to previous jump"))
vim.keymap.set("n", "<Leader>j,", "g,zz", opts("Go to next jump"))

