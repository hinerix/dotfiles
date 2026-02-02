local node_servers_dir = '/home/hinerix/dotfiles/nvim-mini/node_servers'
local node_bin = node_servers_dir .. '/node_modules/.bin'
if vim.fn.has('vim_starting') == 1 then
  vim.env.PATH = node_bin .. ':' .. vim.env.PATH
end

local Methods = vim.lsp.protocol.Methods

vim.api.nvim_create_user_command('LspHealth', function()
  vim.cmd.checkhealth('vim.lsp')
end, { desc = 'LSP health check' })

vim.api.nvim_create_user_command('LsUpdate', function()
  local function on_exit(obj)
    -- bun updateの結果はstderrに出力される
    local msg = obj.stderr .. obj.stdout
    if obj.code ~= 0 then
      vim.notify('Failed to update language servers:\n' .. msg, vim.log.levels.ERROR)
    else
      vim.notify('Language servers updated!\n' .. msg)
    end
  end

  vim.notify('Updating language servers in ' .. node_servers_dir .. '...')
  vim.system({ 'bun', 'update' }, { text = true, cwd = node_servers_dir }, on_exit)
end, { desc = 'Update language servers with bun update' })

local function diagnostic_format(diagnostic)
  return string.format('%s (%s)', diagnostic.message, diagnostic.source)
end
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { format = diagnostic_format },
  float = { format = diagnostic_format },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
})

-- augroup for this config file
local augroup = vim.api.nvim_create_augroup('config/lsp.lua', {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    if client:supports_method(Methods.textDocument_definition) then
      vim.keymap.set('n', 'grd', function()
        vim.lsp.buf.definition()
      end, { buffer = args.buf, desc = 'vim.lsp.buf.definition()' })
    end

    if client and client:supports_method("text/Document/inlayHint", bufnr) then
      vim.keymap.set("n", "grh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
      end, { desc = "Toggle inlayHints" })
    end

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "single" })
    end, { silent = true, buffer = bufnr })

    vim.keymap.set("n", "grs", function()
      vim.lsp.buf.signature_help({ border = "single" })
    end, { desc = "vim.lsp.buf.signature_help()", silent = true, buffer = bufnr })

    -- WIP 0.12~
    -- if client:supports_method(Methods.textDocument_documentColor) then
    --   vim.lsp.document_color.enable(true, args.buf, { style = 'virtual' })
    -- end

    -- use conform.nvim instead of this
    -- if client:supports_method('textDocument/formatting') then
    --   vim.keymap.set('n', '<space>i', function()
    --     vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
    --   end, { buffer = args.buf, desc = 'Format buffer' })
    -- end
  end,
})

vim.lsp.config('*', {
  cmd = {},
  root_markers = { '.git' },
  capabilities = require('mini.completion').get_lsp_capabilities(),
})

local lsp_names = {
  'bashls',
  'cssmodules_ls',
  'denols',
  'sqls',
  'yamlls',
  'lua_ls',
  'vtsls',
}

vim.lsp.enable(lsp_names)
