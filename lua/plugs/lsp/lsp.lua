return {
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"glsl_analyzer",
					"cmake",
					"lua_ls",
					-- "rust_alalyzer",
					"typos_lsp",
					"pylsp",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			if vim.fn.has("win32") == 1 then
				vim.env.PATH = vim.env.PATH .. ";" .. vim.fn.stdpath("data") .. "/mason/bin"

				-- Normalize paths for LSP
				local function normalize_path(path)
					return path:gsub("\\", "/"):lower()
				end

				local lsp_util = require("lspconfig.util")
				lsp_util.path = vim.tbl_extend("force", lsp_util.path, {
					normalize = normalize_path,
					is_absolute = function(path)
						return path:match("^%a:") ~= nil
					end,
				})
			end

			vim.diagnostic.config({
				virtual_text = true, -- Disable inline text
				float = {
					border = "rounded",
					source = "always",
					format = function(diagnostic)
						return string.format(
							"%s (%s) [%s]",
							diagnostic.message,
							diagnostic.source,
							diagnostic.code or ""
						)
					end,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			lspconfig.lua_ls.setup({
				root_dir = function(fname)
					return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
				end,
				settings = {
					Lua = {
						workspace = {
							maxPreload = 1000, -- Reduce preloaded files
							preloadFileSize = 500, -- Skip large files
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Add other Lua libraries here, e.g., runtime paths for plugins
							},
						},
						diagnostics = {
							globals = {
								"vim",
							},
						},
						telemetry = { enable = false },
					},
				},
			})

			lspconfig.dartls.setup({
				-- cmd = { "dart.bat", "language-server", "--protocol=lsp" }, -- Ensure this matches your Dart executable path
				-- filetypes = { "dart" },
				-- init_options = {
				-- 	closingLabels = true,
				-- 	flutterOutline = true,
				-- 	onlyAnalyzeProjectsWithOpenFiles = false,
				-- 	outline = true,
				-- 	suggestFromUnimportedLibraries = true,
				-- },
				-- settings = {
				-- 	dart = {
				-- 		completeFunctionCalls = true,
				-- 		showTodos = true,
				-- 	},
				-- },
			})

			-- Improved Clangd setup
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=never",
					"--query-driver=clang*,gcc*,gcc*,cl.exe",
					"--compile-commands-dir=build",
					"--pch-storage=memory",
					"--all-scopes-completion",
					"--completion-style=detailed",
					"--offset-encoding=utf-8",
				},
				init_options = {
					clangdFileStatus = true,
					fallbackFlags = { "-std=c++26" },
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = function(fname)
					return lspconfig.util.root_pattern(
						"compile_commands.json",
						"build/compile_commands.json",
						"CMakeLists.txt",
						"xmake.lua"
					)(fname) or lspconfig.util.path.dirname(fname)
				end,
				capabilities = {
					offsetEncoding = "utf-8",
				},
			})
			lspconfig.cmake.setup({})

			lspconfig.pylsp.setup({
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = { enabled = false },
							pyflakes = { enabled = false },
							pylint = { enabled = true },
						},
					},
				},
			})

			lspconfig.terraformls.setup({})

			-- Customize diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<Space>ee", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<Space>qs", vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true }
					-- Add to your existing LspAttach callback
					vim.keymap.set("n", "gk", function()
						vim.diagnostic.open_float(nil, {
							border = "rounded",
							focusable = false,
							close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
							source = "always",
							prefix = function(diagnostic)
								local icons = {
									Error = " ",
									Warn = " ",
									Info = " ",
									Hint = " ",
								}
								return icons[diagnostic.severity.name]
							end,
						})
					end, opts)
					vim.keymap.set("n", "gf", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Space>fa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- Goto definition in new window
					vim.keymap.set("n", "<Space>wg", ":belowright split<CR>:lua vim.lsp.buf.definition()<CR>", opts)

					-- use telescope to search for object references
					vim.keymap.set("n", "gi", require("telescope.builtin").lsp_references, opts)
				end,
			})

			-- Show diagnostics on cursor hold
			vim.api.nvim_create_autocmd("CursorHold", {
				pattern = "*",
				callback = function()
					vim.diagnostic.open_float(nil, {
						scope = "cursor",
						focusable = false,
						close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
					})
				end,
			})
		end,
	},
}
