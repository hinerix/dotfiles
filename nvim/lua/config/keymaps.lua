local keymapOpts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

vim.keymap.set({ 'n', 'x' }, 'x', '"_d', keymapOpts('delete without yank'))
vim.keymap.set('n', 'X', '"_D', keymapOpts('delete to end of line without yank'))
vim.keymap.set('o', 'x', 'd', keymapOpts('delete using x'))

vim.keymap.set('x', 'p', 'P', keymapOpts('paste without change register'))
vim.keymap.set('x', 'P', 'p', keymapOpts('paste with change register'))

vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', keymapOpts('Switch to normal mode while in terminal mode'))

vim.keymap.set('c', '<c-b>', '<left>', { desc = 'Emacs like left' })
vim.keymap.set('c', '<c-f>', '<right>', { desc = 'Emacs like right' })
vim.keymap.set('c', '<c-a>', '<home>', { desc = 'Emacs like home' })
vim.keymap.set('c', '<c-e>', '<end>', { desc = 'Emacs like end' })
vim.keymap.set('c', '<c-h>', '<bs>', { desc = 'Emacs like bs' })
vim.keymap.set('c', '<c-d>', '<del>', { desc = 'Emacs like del' })
