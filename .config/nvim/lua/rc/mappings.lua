local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Escでハイライトを消す
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts("Clean highlight"))

-- xキーで削除したときに yank register に保存しないようにする
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })

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

