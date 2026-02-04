-- VIME
local function setup_im_mapping()
    local function yank_and_close()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        vim.fn.setreg("+", table.concat(lines, "\n"))
        vim.cmd("Bufdelete!")
        vim.cmd("IM")
        vim.cmd("silent !hyprctl dispatch focuscurrentorlast")
    end
    vim.fn["skkeleton#initialize"]()
    vim.keymap.set({ "n", "x" }, "<CR>", yank_and_close, { buffer = 0, noremap = true, silent = true })
end
vim.api.nvim_create_user_command("IM", setup_im_mapping, { force = true })

-- open init.lua
vim.api.nvim_create_user_command('InitLua', function()
  vim.cmd.edit(vim.fn.stdpath('config') .. '/init.lua')
end, { desc = 'Open init.lua' })

vim.api.nvim_create_user_command('BufDiff', function(arg)
  vim.cmd.diffsplit({ mods = { vertical = true }, args = (arg.nargs == 1 and arg.args or { '#' }) })
end, { nargs = '?', complete = 'file', desc = 'Show diff with current buffer' })
vim.api.nvim_create_user_command('DiffOff', function()
  vim.cmd.diffoff()
  vim.cmd.only()
end, { desc = 'Switch off diff mode and quit other windows' })

-- https://zenn.dev/glaucus03/articles/a4649f70f2b2e8
vim.api.nvim_create_user_command('BufOnly', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local closed_count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if
      not vim.api.nvim_get_option_value('modified', { scope = 'local', buf = buf })
      and buf ~= current_buf
      and not pcall(vim.api.nvim_buf_get_var, buf, 'terminal_job_id')
    then
      if pcall(vim.api.nvim_buf_delete, buf, { force = false }) then
        closed_count = closed_count + 1
      end
    end
  end
  vim.notify(closed_count .. ' buffers closed', vim.log.levels.INFO)
end, {})

local function get_range_str(opts)
  if opts.range ~= 2 then
    return ''
  end
  if opts.line1 == opts.line2 then
    return '#L' .. opts.line1
  end
  return '#L' .. opts.line1 .. '-L' .. opts.line2
end

local function copy_path(opts, target)
  local expr = '%'
  if target == 'full path' then
    expr = '%:p'
  elseif target == 'dir name' then
    expr = '%:p:h'
  elseif target == 'file name' then
    expr = '%:t'
  end

  local path = target == 'relative path' and vim.fs.relpath(vim.fn.getcwd(), vim.fn.expand('%:p'))
    or vim.fn.expand(expr)
  path = path .. get_range_str(opts)

  vim.fn.setreg('+', path)
  vim.notify('Copied ' .. target .. ': ' .. path)
end

vim.api.nvim_create_user_command('CopyFullPath', function(opts)
  copy_path(opts, 'full path')
end, { range = true, desc = 'Copy the full path of the current file to the clipboard' })

vim.api.nvim_create_user_command('CopyRelativePath', function(opts)
  copy_path(opts, 'relative path')
end, { range = true, desc = 'Copy the relative path of the current file to the clipboard' })

vim.api.nvim_create_user_command('CopyDirName', function(opts)
  copy_path(opts, 'dir name')
end, { range = true, desc = 'Copy the directory name of the current file to the clipboard' })

vim.api.nvim_create_user_command('CopyFileName', function(opts)
  copy_path(opts, 'file name')
end, { range = true, desc = 'Copy the file name of the current file to the clipboard' })

-- https://github.com/kawarimidoll/dotfiles/blob/07d09f31b897f30565acb51946dc67a484df73cc/.config/nvim/lua/mi/commands.lua#L161C1-L207C100
local memo_path = vim.fn.expand('~/.local/share/memo.md')
local memoaugroup = vim.api.nvim_create_augroup('MemoAutosave', { clear = true })
local function memo()
  -- メモをすでに開いているか確認
  local memo_bufnr = nil
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(bufnr) == memo_path then
      memo_bufnr = bufnr
      break
    end
  end

  -- 現在のバッファがメモのバッファであれば、保存して閉じる
  local current_buf = vim.api.nvim_get_current_buf()
  if current_buf == memo_bufnr then
    vim.cmd.update({ mods = { silent = true } })
    vim.cmd.bdelete()
    return
  end

  -- メモがすでに開いているが、カーソルが別ウィンドウにある場合は、メモのウィンドウへ移動
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == memo_bufnr then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- メモはbufhiddenを'wipe'に設定しているので、隠れバッファになることはないはず
  -- したがってここまで来た場合は、メモのバッファが存在しないことになる

  -- メモのバッファを新規作成
  vim.cmd.split({ args = { vim.fn.fnameescape(memo_path) } })
  vim.api.nvim_win_set_height(0, 12)
  vim.opt_local.bufhidden = 'wipe'
  vim.opt_local.swapfile = false
  vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufLeave', 'BufWinLeave' }, {
    buffer = 0,
    callback = function()
      vim.cmd.update({ mods = { silent = true } })
    end,
    group = memoaugroup,
  })
end
vim.api.nvim_create_user_command('Memo', memo, { desc = 'Toggle memo' })
vim.keymap.set('n', 'mo', '<Cmd>Memo<CR>', { noremap = true, silent = true, desc = 'Toggle memo' })
