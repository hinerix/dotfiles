local convertT = {
	denols = "deno",
	ts_ls = "tsserver",
}

---@param key string
local function getOptions(key)
	local neoconf = require("neoconf")

	local schemaT = vim.iter({ "", "vscode", "coc", "nlsp" }):map(function(configType)
		return configType == "" and key or ("%s.%s"):format(configType, key)
	end)

	---@type nil|string|table|integer|boolean
	local item = vim.iter(schemaT)
		:map(function(item)
			return neoconf.get(item)
		end)
		:find(function(item)
			return item ~= nil
		end)
	return item
end

--@param name string
local function isClientEnable(name)
	local client_name_key = convertT[name] or name
--[[ 
	vim.notify(
		"Neoconf Check: isClientEnable called for: " .. name .. " -> key: " .. client_name_key,
		vim.log.levels.INFO
	)
 ]]
	local enable = getOptions(client_name_key .. ".enable")
	local disable = getOptions(client_name_key .. ".disable")
--[[ 
	vim.notify("Neoconf Check: enable setting: " .. tostring(enable), vim.log.levels.INFO)
	vim.notify("Neoconf Check: disable setting: " .. tostring(disable), vim.log.levels.INFO)
 ]]
	if enable == nil and disable == nil then
		-- vim.notify("Neoconf Check: Result: nil (no explicit setting)", vim.log.levels.INFO)
		return nil
	end

	local isEnable = enable == true or disable == false
	-- vim.notify("Neoconf Check: Result: " .. tostring(isEnable), vim.log.levels.INFO)
	return isEnable
end

return {
	"folke/neoconf.nvim",
	opts = {},
	config = function(_, opts)
		local neoconf = require("neoconf")
		neoconf.setup(opts)
		local neoconf_augroup = vim.api.nvim_create_augroup("NeoconfLspManagement", { clear = true })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = neoconf_augroup,
			desc = "neoconf: Detach disabled LSP clients on buffer attach",
			callback = function(args)
				local bufnr = args.buf
				local client_id = args.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)

				if not client or not client.name then
--[[ 
					vim.notify(
						"Neoconf: Could not get client object or name for ID: " .. client_id,
						vim.log.levels.WARN
					)
 ]]
					return
				end

				local client_name = client.name
--[[ 
				vim.notify(
					"Neoconf Attach: Client: '" .. client_name .. "' attached to buffer: " .. bufnr,
					vim.log.levels.INFO
				)
 ]]
				local isEnable = isClientEnable(client_name)
				if isEnable == false then
--[[ 
					vim.notify(
						"Neoconf Attach: Detaching client '" .. client_name .. "' due to config (isEnable=false)",
						vim.log.levels.WARN
					)
 ]]
					vim.lsp.buf_detach_client(bufnr, client.id)
				elseif isEnable == true then
--[[ 
					vim.notify(
						"Neoconf Attach: Client '" .. client_name .. "' is explicitly enabled.",
						vim.log.levels.INFO
					)
 ]]
				else
--[[ 
					vim.notify(
						"Neoconf Attach: Client '"
							.. client_name
							.. "' has no specific enable/disable config, keeping attached.",
						vim.log.levels.INFO
					)
 ]]
				end
			end,
		})
	end,
	getOptions = getOptions,
}
