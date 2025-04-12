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
				local neoconf = require("rc.plugins.neoconf")
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local ft = {
            deno_files = { "deno.json", "deno.jsonc", "mod.ts", "deps.ts" },
            node_specific_files = { "package.json", "node_modules", ".npmrc", "yarn.lock", "pnpm-lock.yaml", "tsconfig.json" },
        }

        ---@param path string
        ---@return string|nil
        local function findRootDirForDeno(path)
            ---@type string|nil プロジェクトルート候補
            local project_root =
                vim.fs.root(path, vim.iter({ ".git", ft.deno_files, ft.node_specific_files }):flatten(math.huge):totable())
            project_root = project_root or vim.uv.cwd() -- 見つからなければカレントディレクトリ

            if not project_root then return nil end -- ルートが見つからない場合は終了

            -- Node.js固有のファイルが存在するかチェック
            local is_node_files_found = vim.iter(ft.node_specific_files):any(function(file)
                return vim.uv.fs_stat(vim.fs.joinpath(project_root, file)) ~= nil
            end)

            -- Node固有ファイルが見つからない場合
            if not is_node_files_found then
                -- Deno固有のファイルが存在するかチェック
                local is_deno_files_found = vim.iter(ft.deno_files):any(function(file)
                    return vim.uv.fs_stat(vim.fs.joinpath(project_root, file)) ~= nil
                end)
                if is_deno_files_found then
                    return project_root -- Denoファイルがあれば Deno プロジェクト
                else
                    return nil -- NodeもDenoのファイルも見つからなければ対象外
                end
            end

            -- Node固有ファイルが見つかった場合：neoconf の設定を確認
            -- .vscode/settings.json や .neoconf.json の deno.enable や deno.enablePaths をチェック
            local getOptions = neoconf.getOptions
            local enable = getOptions("deno.enable")
            local enable_paths = getOptions("deno.enablePaths")

            -- プロジェクト全体でDenoが明示的に有効化されているか？ (enable: true)
            if enable == true then
                return project_root
            end

            -- 特定のパスでDenoが有効化されているか？ (enablePaths)
            -- enable が false でなく、enable_paths がテーブルの場合
            if enable ~= false and type(enable_paths) == "table" then
                local current_file_path = vim.api.nvim_buf_get_name(0) -- 現在のバッファのフルパスを取得
                local root_in_enable_path = vim.iter(enable_paths)
                    :map(function(p)
                        -- 相対パスを絶対パスに変換
                        return vim.fs.joinpath(project_root, p)
                    end)
                    :find(function(absEnablePath)
                        -- 現在のファイルパスが、有効化されたパスで始まっているかチェック
                        -- NOTE: ディレクトリかどうかを確認した方がより正確かもしれない
                        -- vim.uv.fs_stat(absEnablePath).type == "directory"
                        return vim.startswith(current_file_path, absEnablePath .. "/") -- ディレクトリ区切り文字を追加して前方一致
                    end)

                if root_in_enable_path ~= nil then
                    -- マッチした有効化パスをルートとして返す (より限定的なルート)
                    -- もしくは project_root をそのまま返すか、どちらが良いかはプロジェクト構造による
                    return project_root -- ここではプロジェクト全体のルートを返すことにする
                    -- return root_in_enable_path -- 特定のサブディレクトリをルートにする場合
                end
            end

            -- Nodeファイルがあり、Denoが明示的に有効化されていない場合は nil を返す
            return nil
        end

        -- mason-lspconfig で管理されるサーバーのデフォルト設定
        local function default_setup(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end

        -- TypeScript (ts_ls) 用のセットアップ関数
        local function typescript_setup(server_name)
            -- 現在のバッファに対して denols が起動すべきか確認
            local current_buf_path = vim.api.nvim_buf_get_name(0)
            local deno_root = findRootDirForDeno(current_buf_path)

            -- denols が起動すべきでない場合のみ ts_ls を設定
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
    end
}
