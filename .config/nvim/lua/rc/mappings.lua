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
vim.keymap.set("n", "[q", ":cprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]Q", ":clast<CR>", { noremap = true, silent = true })

----------------------------
-- Location List
----------------------------
vim.keymap.set("n", "[l", ":lprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]l", ":lnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[L", ":lfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]L", ":llast<CR>", { noremap = true, silent = true })

----------------------------
-- Buffers
----------------------------
vim.keymap.set("n", "[b", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[B", ":bfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]B", ":blast<CR>", { noremap = true, silent = true })

----------------------------
-- jump
----------------------------
vim.keymap.set("n", "[;", "g;zz", { noremap = true, silent = true })
vim.keymap.set("n", "];", "g,zz", { noremap = true, silent = true })

----------------------------
-- neo-tree
----------------------------
vim.keymap.set("n", "\\", ":Neotree reveal<CR>", opts("focus on neo-tree"))

