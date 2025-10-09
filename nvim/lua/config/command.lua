-- for VIME
local function setup_im_mapping()
  -- Enterキーで呼ばれる関数
  local function yank_and_close()
    -- カレントバッファ(0)のすべての行を取得
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    -- 取得した行を改行で連結し、クリップボードレジスタ(+)に設定
    vim.fn.setreg('+', table.concat(lines, '\n'))

    -- バッファを強制的に閉じる（ウィンドウレイアウトに影響を与えないように）
    vim.cmd('bdelete!')
		vim.cmd('IM')
		vim.cmd('silent !hyprctl dispatch togglespecialworkspace VIME')
  end

  -- マッピングから呼び出せるように、上記関数をグローバルに登録
  _G.__scratchpad_ime_yank_and_close = yank_and_close

  -- skkeletonの初期化とキーマッピングの設定
	vim.fn["skkeleton#initialize"]()

  -- このバッファ限定のキーマッピングを設定
  local bufnr = 0 -- 0はカレントバッファを意味する
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local cmd_str = '<Cmd>lua _G.__scratchpad_ime_yank_and_close()<CR>'

  -- Enterキーにマッピング
  vim.keymap.set({'n', 'x'}, '<CR>', cmd_str, opts)
end

-- :IM カスタムコマンドの作成
vim.api.nvim_create_user_command(
  'IM',
  setup_im_mapping,
  { force = true }
)
