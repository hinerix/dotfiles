-- 参考: https://zenn.dev/vim_jp/articles/c96e9b1bdb9241
vim.env.XDG_STATE_HOME = "/tmp"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Nerd Font有効化
vim.g.have_nerd_font = true

-- マウスでカーソル位置操作
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true

-- lualineでステータスを表示してるので非表示に設定
vim.opt.showmode = false

-- True Colorの有効化
vim.opt.termguicolors = true
vim.opt.winblend = 20
vim.opt.pumblend = 20

-- TabとIndent
vim.opt.breakindent = true -- 折り返しにインデントを反映
local tabwith = 2
vim.opt.tabstop = tabwith -- タブ文字の幅
vim.opt.shiftwidth = tabwith -- 自動インデント時のインデント幅
vim.opt.softtabstop = tabwith -- タブ押下時に挿入されるスペース
vim.opt.list = true -- 不可視文字の可視化（タブや改行など）
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- 不可視文字に文字を割り当て（trail=行末スペース, nbsp=改行不可のスペース）

-- Search
vim.opt.wrapscan = true -- 最後の検索候補の次の検索で最初に戻る
vim.opt.ignorecase = true -- 検索時に大文字小文字を無視する
vim.opt.smartcase = true -- 検索に大文字を入力した場合は大文字を考慮する

-- clipboard(起動時間短縮のため、少し遅らせて実行)
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- cursor lineをハイライト
vim.opt.cursorline = true

-- split windows
vim.opt.splitright = true -- 垂直分割時、右に分割する
vim.opt.splitbelow = true -- 水平分割時、下に分割する

-- turn off swapfile
vim.opt.swapfile = false

-- Undoの履歴をファイルに保存
vim.opt.undofile = true
vim.opt.undodir = vim.env.XDG_STATE_HOME .. "/nvim/undo"

-- 行番号左側の記号を表示する
vim.opt.signcolumn = "yes"

-- コマンドの結果をプレビューできる
vim.opt.inccommand = "split"

-- カーソルのスクロール開始行数
vim.opt.scrolloff = 10
