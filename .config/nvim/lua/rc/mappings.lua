local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Escでハイライトを消す
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts("Clean highlight"))

-- xキーで削除したときに yank register に保存しないようにする
vim.keymap.set({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })

-----------------------------
-- Window
----------------------------
vim.keymap.set("n", "<Leader>w-", ":split<CR>", opts("Split window horizontally"))
vim.keymap.set("n", "<Leader>w<BAR>", ":vsplit<CR>", opts("Split window vertically"))
vim.keymap.set("n", "<Leader>wo", ":only<CR>", opts("Close all other windows"))
vim.keymap.set("n", "<Leader>wq", ":close<CR>", opts("Close current window"))

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
-- Quickfix List
----------------------------
vim.keymap.set("n", "[q", ":cprevious<CR>", opts("Go to previous quickfix"))
vim.keymap.set("n", "]q", ":cnext<CR>", opts("Go to next quickfix"))
vim.keymap.set("n", "[Q", ":cfirst<CR>", opts("Go to first quickfix"))
vim.keymap.set("n", "]Q", ":clast<CR>", opts("Go to last quickfix"))

----------------------------
-- Location List
----------------------------
vim.keymap.set("n", "[l", ":lprevious<CR>", opts("Go to previous location list"))
vim.keymap.set("n", "]l", ":lnext<CR>", opts("Go to next location list"))
vim.keymap.set("n", "[L", ":lfirst<CR>", opts("Go to first location list"))
vim.keymap.set("n", "]L", ":llast<CR>", opts("Go to last location list"))

----------------------------
-- Buffers
----------------------------
vim.keymap.set("n", "[b", ":bprevious<CR>", opts("Go to previous buffer"))
vim.keymap.set("n", "]b", ":bnext<CR>", opts("Go to next buffer"))
vim.keymap.set("n", "[B", ":bfirst<CR>", opts("Go to first buffer"))
vim.keymap.set("n", "]B", ":blast<CR>", opts("Go to last buffer"))
vim.keymap.set("n", "<Leader>bd", "<Cmd>bdelete<CR>", opts("Delete current buffer"))

----------------------------
-- jump
----------------------------
vim.keymap.set("n", "<Leader>j;", "g;zz", opts("Go to previous jump"))
vim.keymap.set("n", "<Leader>j,", "g,zz", opts("Go to next jump"))

