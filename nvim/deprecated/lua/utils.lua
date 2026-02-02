local M = {}
-- キーマップのよくある設定
M.keymapOpts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

M.debounce = function(func, wait)
	local timer_id
	return function(...)
		if timer_id ~= nil then
			vim.uv.timer_stop(timer_id)
		end
		local args = { ... }
		timer_id = assert(vim.uv.new_timer())
		vim.uv.timer_start(timer_id, wait, 0, function()
			func(unpack(args))
			timer_id = nil
		end)
	end
end

M.get_node_root = function(bufnr)
	local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
	return vim.fs.root(bufnr, root_markers)
end

return M
