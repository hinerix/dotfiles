-- cache init.lua
vim.loader.enable()

-- https://zenn.dev/vim_jp/articles/c96e9b1bdb9241
vim.env.XDG_STATE_HOME = '/tmp'

-- share clipboard with OS
vim.opt.clipboard:append('unnamedplus', 'unnamed')

-- use 2-spaces indent
local tabwith = 2
vim.opt.tabstop = tabwith
vim.opt.shiftwidth = tabwith
vim.opt.softtabstop = tabwith
vim.opt.breakindent = true
vim.opt.shiftround = true
vim.opt.expandtab = true

-- invisible chars
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- wrap lines
vim.opt.wrap = true
vim.opt.showbreak = '↪'

-- disable mode display on cmdline
vim.opt.showmode = false

-- true color
vim.opt.termguicolors = true

-- search
vim.opt.wrapscan = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- highlight cursor line
vim.opt.cursorline = true

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- disable swapfile
vim.opt.swapfile = false

-- undo history
vim.opt.undofile = true
vim.opt.undodir = vim.env.XDG_STATE_HOME .. '/nvim/undo'

-- signcolumn
vim.opt.signcolumn = 'yes'

-- shows the effects of :s, :smagic etc...
vim.opt.inccommand = 'split'

-- scroll offset as 3 lines
vim.opt.scrolloff = 3


local U = require('config.utils')

-- augroup for this config file
local augroup = vim.api.nvim_create_augroup('init.lua', {})

-- wrapper function to use internal augroup
local function create_autocmd(event, opts)
  vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend('force', {
      group = augroup,
    }, opts)
  )
end

-- https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(event)
    local dir = vim.fs.dirname(event.file)
    local force = U.present(vim.v.cmdbang)
    if not vim.bool_fn.isdirectory(dir)
        and (force or vim.fn.confirm('"' .. dir .. '" does not exist. Create?', "&Yes\n&No") == 1) then
      vim.fn.mkdir(vim.fn.iconv(dir, vim.opt.encoding:get(), vim.opt.termencoding:get()), 'p')
    end
  end,
  desc = 'Auto mkdir to save file'
})

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing [`mini.nvim`](../doc/mini-nvim.qmd#mini.nvim)" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed [`mini.nvim`](../doc/mini-nvim.qmd#mini.nvim)" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add('https://github.com/catppuccin/nvim')
  local catppuccin = require("catppuccin")
  catppuccin.setup({
    transparent_background = true,
    no_italic = true,
    no_underline = true,
    custom_highlights = function(colors)
      return {
        Pmenu = { bg = colors.surface0 },
        PmenuSel = { bg = colors.green, fg = colors.base },
        PmenuExtraSel = { bg = colors.green, fg = colors.base },
        PmenuMatchSel = { fg = colors.surface2 },
      }
    end,
  })
  vim.cmd.colorscheme('catppuccin-mocha')
end)

now(function()
  require('config.commands')
end)

later(function()
  require('config.keymaps')
end)



now(function()
  require('mini.icons').setup()
end)

later(function()
  add('https://github.com/vim-jp/vimdoc-ja')
  vim.opt.helplang:prepend('ja')
end)

now(function()
  require('mini.statusline').setup()
  vim.opt.laststatus = 3
  -- hit-enter-promptが煩わしい&cmdheight=0にそこまでこだわりはないので、一旦コメントアウト
  -- 0.12以降のextuiという機能でスマートにcmdheight=0が実現できるらしいのでstableになるまで全力待機
  -- vim.opt.cmdheight = 0
  --
  -- -- ref: https://github.com/Shougo/shougo-s-github/blob/2f1c9acacd3a341a1fa40823761d9593266c65d4/vim/rc/vimrc#L47-L49
  -- create_autocmd({ 'RecordingEnter', 'CmdlineEnter' }, {
  --   pattern = '*',
  --   callback = function()
  --     vim.opt.cmdheight = 1
  --   end,
  -- })
  -- create_autocmd('RecordingLeave', {
  --   pattern = '*',
  --   callback = function()
  --     vim.opt.cmdheight = 0
  --   end,
  -- })
  -- create_autocmd('CmdlineLeave', {
  --   pattern = '*',
  --   callback = function()
  --     if vim.fn.reg_recording() == '' then
  --       vim.opt.cmdheight = 0
  --     end
  --   end,
  -- })
end)

now(function()
  require('mini.misc').setup()
  MiniMisc.setup_restore_cursor()
  vim.api.nvim_create_user_command('Zoom', function()
    MiniMisc.zoom(0, {})
  end, { desc = 'Zoom current buffer' })
  vim.keymap.set('n', 'mz', '<cmd>Zoom<cr>', { desc = 'Zoom current buffer' })
end)

now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify({
    ERROR = { duration = 10000 }
  })
  vim.api.nvim_create_user_command('NotifyHistory', function()
    MiniNotify.show_history()
  end, { desc = 'Show notify history' })
end)

later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = require('mini.extra').gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO','WIP', 'NOTE'
      fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'Hack', 'hack' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO', 'Todo', 'todo' }, 'MiniHipatternsTodo'),
      wip = hi_words({ 'WIP', 'Wip', 'wip' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE', 'Note', 'note' }, 'MiniHipatternsNote'),
      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function()
  require('mini.cursorword').setup()
end)

later(function()
  require('mini.indentscope').setup()
end)

later(function()
  require('mini.trailspace').setup()
  vim.api.nvim_create_user_command(
    'Trim',
    function()
      MiniTrailspace.trim()
      MiniTrailspace.trim_last_lines()
    end,
    { desc = 'Trim trailing space and last blank lines' }
  )
end)

now(function()
  require('mini.sessions').setup()

  local function get_sessions(lead)
    -- ref: https://qiita.com/delphinus/items/2c993527df40c9ebaea7
    return vim
        .iter(vim.fs.dir(MiniSessions.config.directory))
        :map(function(v)
          local name = vim.fs.basename(v)
          return vim.startswith(name, lead) and name or nil
        end)
        :totable()
  end
  vim.api.nvim_create_user_command('SessionWrite', function(arg)
    local session_name = U.blank(arg.args) and vim.v.this_session or arg.args
    if U.blank(session_name) then
      vim.notify('No session name specified', vim.log.levels.WARN)
      return
    end
    vim.cmd('%argdelete')
    MiniSessions.write(session_name)
  end, { desc = 'Write session', nargs = '?', complete = get_sessions })

  vim.api.nvim_create_user_command('SessionDelete', function(arg)
    MiniSessions.select('delete', { force = arg.bang })
  end, { desc = 'Delete session', bang = true })

  vim.api.nvim_create_user_command('SessionLoad', function()
    MiniSessions.select('read', { verbose = true })
  end, { desc = 'Load session' })

  vim.api.nvim_create_user_command('SessionEscape', function()
    vim.v.this_session = ''
  end, { desc = 'Escape session' })

  vim.api.nvim_create_user_command('SessionReveal', function()
    if U.blank(vim.v.this_session) then
      vim.print('No session')
      return
    end
    vim.print(vim.fs.basename(vim.v.this_session))
  end, { desc = 'Reveal session' })
end)

now(function()
  require('mini.starter').setup()
end)

later(function()
  require('mini.pairs').setup()
end)

later(function()
  require('mini.surround').setup()
end)

later(function()
  local gen_ai_spec = require('mini.extra').gen_ai_spec
  require('mini.ai').setup({
    custom_textobjects = {
      B = gen_ai_spec.buffer(),
      D = gen_ai_spec.diagnostic(),
      I = gen_ai_spec.indent(),
      L = gen_ai_spec.line(),
      N = gen_ai_spec.number(),
      J = { { '()%d%d%d%d%-%d%d%-%d%d()', '()%d%d%d%d%/%d%d%/%d%d()' } },
    }
  })
end)

later(function()
  local function mode_nx(keys)
    return { mode = 'n', keys = keys }, { mode = 'x', keys = keys }
  end
  local clue = require('mini.clue')
  clue.setup({
    triggers = {
      -- space triggers
      mode_nx('<space>'),

      -- Built-in completion
      { mode = 'i', keys = '<c-x>' },

      -- 'g' key
      mode_nx('g'),

      -- 'm' key
      { mode = 'i', keys = 'm' },

      -- Marks
      mode_nx("'"),
      mode_nx('`'),

      -- Registers
      mode_nx('"'),
      { mode = 'i', keys = '<c-r>' },
      { mode = 'c', keys = '<c-r>' },

      -- Window commands
      { mode = 'n', keys = '<c-w>' },

      -- bracketed commands
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },

      -- 'z' key
      mode_nx('z'),

      -- surround
      mode_nx('s'),

      -- text obect
      { mode = 'x', keys = 'i' },
      { mode = 'x', keys = 'a' },
      { mode = 'o', keys = 'i' },
      { mode = 'o', keys = 'a' },
    },
    clues = {
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers({ show_contents = true }),
      clue.gen_clues.windows({ submode_resize = true, submode_move = true }),
      clue.gen_clues.z(),
    },
  })
end)

later(function()
  require('mini.fuzzy').setup()
  require('mini.completion').setup({
    lsp_completion = {
      process_items = MiniFuzzy.process_lsp_items,
    },
  })
  require('mini.snippets').setup({
    mappings = {
      expand = '<m-j>',
      jump_prev = '<c-k>',
    },
  })
  -- improve fallback completion
  vim.opt.complete = { '.', 'w', 'k', 'b', 'u' }
  vim.opt.completeopt:append('fuzzy')

  -- define keycodes
  local keys = {
    cn = vim.keycode('<c-n>'),
    cp = vim.keycode('<c-p>'),
    ct = vim.keycode('<c-t>'),
    cd = vim.keycode('<c-d>'),
    cr = vim.keycode('<cr>'),
    cy = vim.keycode('<c-y>'),
  }

  -- select by <tab>/<s-tab>
  vim.keymap.set('i', '<tab>', function()
    -- popup is visible -> next item
    -- popup is NOT visible -> add indent
    return vim.bool_fn.pumvisible() and keys.cn or keys.ct
  end, { expr = true, desc = 'Select next item if popup is visible' })
  vim.keymap.set('i', '<s-tab>', function()
    -- popup is visible -> previous item
    -- popup is NOT visible -> remove indent
    return vim.bool_fn.pumvisible() and keys.cp or keys.cd
  end, { expr = true, desc = 'Select previous item if popup is visible' })

  -- complete by <cr>
  vim.keymap.set('i', '<cr>', function()
    if not vim.bool_fn.pumvisible() then
      -- popup is NOT visible -> insert newline
      return require('mini.pairs').cr()
    end
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    if item_selected then
      -- popup is visible and item is selected -> complete item
      return keys.cy
    end
    -- popup is visible but item is NOT selected -> hide popup and insert newline
    return keys.cy .. keys.cr
  end, { expr = true, desc = 'Complete current item if item is selected' })
end)

now(function()
  add('https://github.com/neovim/nvim-lspconfig')

  -- https://github.com/neovim/neovim/discussions/26571#discussioncomment-11879196
  -- https://github.com/lttb/gh-actions-language-server
  vim.filetype.add({
    pattern = {
      ['compose.*%.ya?ml'] = 'yaml.docker-compose',
      ['compose/.*%.ya?ml'] = 'yaml.docker-compose',
      ['docker%-compose.*%.ya?ml'] = 'yaml.docker-compose',
      ['.*/%.github/workflows/.*%.ya?ml'] = 'yaml.github-actions',
      ['%.env.*'] = 'sh.env',
    },
  })

  require('config.lsp')
end)

later(function()
  require('mini.tabline').setup()
end)

later(function()
  require('mini.bufremove').setup()

  vim.api.nvim_create_user_command(
    'Bufdelete',
    function()
      MiniBufremove.delete()
    end,
    { desc = 'Remove buffer' }
  )
  vim.keymap.set('n', '<space>bd', '<Cmd>Bufdelete<CR>', { desc = 'Delete current buffer' })
  vim.keymap.set('n', '<space>bo', '<Cmd>%bdelete|e#|bdelete#<CR>', { desc = 'Delete all buffers except current' })
end)

now(function()
  require('mini.files').setup()

  vim.api.nvim_create_user_command(
    'Files',
    function()
      MiniFiles.open()
    end,
    { desc = 'Open file exproler' }
  )
  vim.keymap.set('n', '<space>e', '<cmd>Files<cr>', { desc = 'Open file exproler' })
end)

later(function()
  require('mini.pick').setup()

  vim.ui.select = MiniPick.ui_select

  vim.keymap.set('n', '<space>ff', function()
    MiniPick.builtin.files({ tool = 'git' })
  end, { desc = 'mini.pick.files' })

  vim.keymap.set('n', '<space>fb', function()
    local wipeout_cur = function()
      vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
    end
    local buffer_mappings = { wipeout = { char = '<c-d>', func = wipeout_cur } }
    MiniPick.builtin.buffers({ include_current = false }, { mappings = buffer_mappings })
  end, { desc = 'mini.pick.buffers' })

  require('mini.visits').setup()
  vim.keymap.set('n', '<space>fh', function()
    require('mini.extra').pickers.visit_paths()
  end, { desc = 'mini.extra.visit_paths' })

  vim.keymap.set('c', 'h', function()
    if vim.fn.getcmdtype() .. vim.fn.getcmdline() == ':h' then
      return '<c-u>Pick help<cr>'
    end
    return 'h'
  end, { expr = true, desc = 'mini.pick.help' })
end)

later(function()
  require('mini.diff').setup({
    view = {
      signs = { add = '+', change = '~', delete = '-' },
    },
  })
end)

later(function()
  require('mini.git').setup()

  vim.keymap.set({ 'n', 'x' }, '<space>gs', MiniGit.show_at_cursor, { desc = 'Show at cursor' })
end)

later(function()
  require('mini.operators').setup({
    replace = { prefix = 'R' },
    exchange = { prefix = 'g/' },
  })

  vim.keymap.set('n', 'RR', 'R', { desc = 'Replace mode' })
end)

later(function()
  require('mini.jump2d').setup({
    allowed_lines = {
      blank = false,
      cursor_at = false,
    },
    mappings = {
      start_jumping = '<m-cr>',
    },
  })
end)

later(function()
  local animate = require('mini.animate')
  animate.setup({
    cursor = {
      -- Animate for 100 milliseconds with linear easing
      timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
    },
    scroll = {
      -- Animate for 150 milliseconds with linear easing
      timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
    }
  })
end)

later(function()
  add('https://github.com/akinsho/toggleterm.nvim')
  require('toggleterm').setup({
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    float_opts = {
      width = function()
        return math.ceil(vim.o.columns * 0.9)
      end,
      height = function()
        return vim.o.lines - 4
      end,
    },
    open_mapping = [[<c-\>]],
    insert_mappings = false,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true,
  })

  create_autocmd({ 'TermOpen' }, {
    pattern = 'term://*',
    callback = function()
      vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Easy escape', buffer = true })
      vim.keymap.set('t', '<c-[><c-[>', '<c-\\><c-n>', { desc = 'Easy escape', buffer = true })
      local keys = { 'i', 'a', 'A', 'o', 'O' }
      for _, k in ipairs(keys) do
        vim.keymap.set('n', k, 'I', { desc = 'Enter terminal mode', buffer = true })
      end
    end,
    desc = 'Terminal keymaps',
  })

  -- default 'guicursor' includes 't:block-blinkon500-blinkoff500-TermCursor'
  vim.opt.guicursor:remove('t:block-blinkon500-blinkoff500-TermCursor')
  vim.opt.guicursor:append('t:block-TermCursor')

  -- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
  local Terminal = require('toggleterm.terminal').Terminal
  local function create_tui(cmd, ex_command)
    local cmd_term = Terminal:new({
      cmd = cmd,
      dir = 'git_dir',
      direction = 'float',
      float_opts = { border = 'rounded' },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd.startinsert({ bang = true })
        local bufnr = term.bufnr
        ---@cast bufnr integer
        vim.keymap.set('n', 'q', function()
          term:close()
        end, { desc = 'close ' .. cmd, buffer = bufnr, nowait = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(_term)
        vim.cmd.startinsert({ bang = true })
      end,
    })
    vim.api.nvim_create_user_command(ex_command, function()
      vim.cmd.normal('<c-l>')
      vim.cmd.nohlsearch()
      cmd_term:toggle()
    end, { desc = 'Toggle ' .. cmd })
  end
  create_tui('lazygit', 'Lazygit')
  vim.keymap.set('n', '<space>L', '<cmd>Lazygit<cr>', { desc = 'LazyGit', silent = true })
  create_tui('lazydocker', 'Lazydocker')
  vim.keymap.set('n', '<space>D', '<cmd>Lazydocker<cr>', { desc = 'LazyDocker', silent = true })
end)

now(function()
  -- avoid error
  vim.treesitter.start = (function(wrapped)
    return function(bufnr, lang)
      lang = lang or vim.api.nvim_get_option_value('filetype', {})
      pcall(wrapped, bufnr, lang)
    end
  end)(vim.treesitter.start)
  add({
    source = 'https://github.com/nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = {
      post_checkout = U.noarg(vim.cmd.TSUpdate),
    },
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function(c)
      local filetype = c.match
      local ok = pcall(vim.treesitter.start, c.buf)
      if ok then
        return
      end

      -- on fail, retry after installing the parser
      local ts = require("nvim-treesitter")
      local lang = vim.treesitter.language.get_lang(filetype)
      if not lang then
        return
      end
      local available_langs = ts.get_available(2)

      if not vim.tbl_contains(available_langs, lang) then
        return
      end

      ts.install({ lang }):await(function(err)
        if err then
          vim.notify(err, vim.log.levels.ERROR, { title = "nvim-treesitter" })
        end
        pcall(vim.treesitter.start, c.buf)
      end)
    end,
  })
end)

later(function()
  add('https://github.com/nanotee/sqls.nvim')
		vim.keymap.set({ "n", "x" }, "<space>sr", "<Cmd>SqlsExecuteQuery<CR>", { desc = 'Run SQL on the buffer(or selected)' })
		vim.keymap.set("n", "<space>sc", "<Cmd>SqlsSwitchConnection<CR>", { desc = 'Choice a connection' })
		vim.keymap.set("n", "<space>sd", "<Cmd>SqlsSwitchDatabase<CR>", { desc = 'Choice a database' })
		vim.keymap.set("n", "<space>st", "<Cmd>SqlsShowTables<CR>", { desc = 'Show connectioins on current connection' })
end)

later(function()
  add('https://github.com/jidn/vim-dbml')
end)

later(function()
  add({
    source = 'https://github.com/Shougo/ddc.vim',
    depends = {
      'https://github.com/vim-denops/denops.vim',
      'https://github.com/vim-skk/skkeleton',
      'https://github.com/Shougo/ddc-ui-native',
      'https://github.com/Shougo/ddc-source-around',
      'https://github.com/Shougo/ddc-source-input',
      'https://github.com/matsui54/ddc-source-buffer',
      'https://github.com/Shougo/ddc-filter-sorter_rank',
      'https://github.com/tani/ddc-fuzzy',
    }
  })
  vim.fn["ddc#custom#load_config"](vim.fn.expand("~/.config/nvim/lua/plugins/ddc/init.ts"))
end)

now(function()
  add({
    source = 'https://github.com/vim-skk/skkeleton',
    depends = { 'https://github.com/vim-denops/denops.vim' },
  })
  local function skkeleton_init()
    vim.fn['skkeleton#config']({
      globalDictionaries = {
        '~/.skk/SKK-JISYO.L',
        '~/.skk/SKK-JISYO.jinmei',
        '~/.skk/SKK-JISYO.geo',
        '~/.skk/SKK-JISYO.station',
        '~/.skk/SKK-JISYO.propernoun',
      },
      completionRankFile = '~/.skk/skkeleton/rank.json',
      userDictionary = '~/.skk/skkeleton/.skkeleton',
      registerConvertResult = true,
      keepState = true,
      eggLikeNewline = true,
      immediatelyOkuriConvert = true,
    })
    vim.fn['skkeleton#register_keymap']('henkan', '<BS>', 'henkanBackward')
    vim.fn['skkeleton#register_keymap']('henkan', 'X', '')
  end
  -- 初期化
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = function()
      skkeleton_init()
    end,
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-enable-pre',
    callback = function()
      vim.b.minicompletion_disable = true
      vim.fn["ddc#enable"]()
    end,
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-disable-pre',
    callback = function()
      vim.b.minicompletion_disable = false
      vim.fn["ddc#disable"]()
    end,
  })
  vim.keymap.set({ 'i', 'c', 't' }, '<C-j>', '<Plug>(skkeleton-enable)', { noremap = false })
end)

later(function()
  add('https://github.com/delphinus/skkeleton-indicator.nvim')
  require('skkeleton_indicator').setup()
end)
