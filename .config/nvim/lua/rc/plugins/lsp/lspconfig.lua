return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"folke/neoconf.nvim",
		"Shougo/ddc-source-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		---@param path string
		---@return string|nil
		local function findRootDirForDeno(path)
			vim.notify("findRootDirForDeno called with path: " .. path, vim.log.levels.INFO)
			local deno_markers = { "deno.json", "deno.jsonc" }
			local node_markers = { "node_modules", "package.json", "bun.lock", "yarn.lock", "pnpm-lock.yaml" }
			local root_markers = vim.iter({ ".git", deno_markers, node_markers }):flatten(math.huge):totable()

			local project_root = vim.fs.root(path, root_markers)
			project_root = project_root or vim.uv.cwd()
			-- vim.notify("  project_root found: " .. tostring(project_root), vim.log.levels.INFO)

			if not project_root then
				-- vim.notify("  No project_root found, returning nil", vim.log.levels.WARN)
				return nil
			end

			local is_deno_json_found = vim.iter(deno_markers):any(function(marker)
				return vim.uv.fs_stat(vim.fs.joinpath(project_root, marker)) ~= nil
			end)
			-- vim.notify("  is_deno_json_found: " .. tostring(is_deno_json_found), vim.log.levels.INFO)
			if is_deno_json_found then
				-- vim.notify("  Returning project_root (deno.json/deno.jsonc found)", vim.log.levels.INFO)
				return project_root
			end

			local is_node_files_found = vim.iter(node_markers):any(function(marker)
				return vim.uv.fs_stat(vim.fs.joinpath(project_root, marker)) ~= nil
			end)
--[[ 
			vim.notify(
				"  is_node_files_found (after deno check): " .. tostring(is_node_files_found),
				vim.log.levels.INFO
			)
 ]]
			-- vim.notify("  Checking neoconf settings (since no deno.json/c found)...", vim.log.levels.INFO)
			local neoconf_ok, neoconf = pcall(require, "rc.plugins.neoconf")
			if not neoconf_ok then
				vim.notify("  Failed to require 'rc.plugins.neoconf'", vim.log.levels.ERROR)
			else
				local getOptions = neoconf.getOptions
				local enable = getOptions("deno.enable")
				local enable_paths = getOptions("deno.enablePaths")
				vim.notify("  neoconf deno.enable: " .. tostring(enable), vim.log.levels.INFO)
				vim.notify("  neoconf deno.enablePaths: " .. vim.inspect(enable_paths), vim.log.levels.INFO)

				if enable == true then
					vim.notify("  Returning project_root (deno.enable is true via neoconf)", vim.log.levels.INFO)
					return project_root
				end

				if enable ~= false and type(enable_paths) == "table" then
					vim.notify("  Checking enablePaths...", vim.log.levels.INFO)
					local root_in_enable_path = vim.iter(enable_paths)
						:map(function(p)
							return vim.fs.joinpath(project_root, p)
						end)
						:find(function(absEnablePath)
							return vim.startswith(path, absEnablePath)
						end)

					if root_in_enable_path ~= nil then
						vim.notify(
							"  Returning project_root based on enablePaths match (via neoconf)",
							vim.log.levels.INFO
						)
						return project_root
					end
				end
			end
--[[ 
			if is_node_files_found then
				vim.notify(
					"  Returning nil (Node markers found, but deno not specified/enabled via neoconf)",
					vim.log.levels.WARN
				)
			else
				vim.notify(
					"  Returning nil (No specific markers found, and deno not specified/enabled via neoconf)",
					vim.log.levels.WARN
				)
			end
 ]]
			return nil
		end

		local function default_setup(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end

		local function typescript_setup(server_name)
			local current_buf_path = vim.api.nvim_buf_get_name(0)
			local deno_root = findRootDirForDeno(current_buf_path)

			if deno_root == nil then
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end
		end

		mason_lspconfig.setup_handlers({
			default_setup,

			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,

			["denols"] = function()
				lspconfig.denols.setup({
					capabilities = capabilities,
					-- カスタム root_dir 関数を使用
					root_dir = findRootDirForDeno,
					settings = {
						deno = {
							enable = true,
							lint = true,
							unstable = true,
							suggest = {
								imports = {
									hosts = {
										["https://deno.land"] = true,
										["https://cdn.nest.land"] = true,
										["https://crux.land"] = true,
										["https://esm.sh"] = true,
									},
								},
							},
						},
					},
				})
			end,

			["ts_ls"] = typescript_setup,
		})
	end,
}
