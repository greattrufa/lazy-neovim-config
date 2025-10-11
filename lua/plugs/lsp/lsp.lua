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
					"rust_analyzer",
					"typos_lsp",
					"pyright",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			if vim.fn.has("win32") == 1 then
				vim.env.PATH = vim.env.PATH .. ";" .. vim.fn.stdpath("data") .. "/mason/bin"

				-- Normalize paths for LSP
				local function normalize_path(path)
					return path:gsub("\\", "/"):lower()
				end
			end

			vim.diagnostic.config({
				virtual_text = true, -- Enable inline text
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,

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
			})

			vim.lsp.config("lua_ls", {
				root_markers = { ".git", ".luarc.json", ".luarc.jsonc", ".stylua.toml" },
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
								"vim.g",
								"vim.o",
							},
						},
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("clangd", {
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
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_markers = { "compile_commands.json", "CMakeLists.txt", "xmake.lua", ".git" },
				single_file_support = true,
				capabilities = {
					offsetEncoding = { "utf-8" },
				},
			})
			vim.lsp.config("cmake", {})

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = { ".git", "pyproject.toml", "requirements.txt", "setup.py", "main.py", ".gitignore" },
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
							autoSearchPaths = true,
							autoImportCompletions = true,
							-- extraPaths = {}, -- Add if you have custom module paths
						},
					},
				},
			})

			vim.lsp.config("rust_alalyzer", {})

			vim.lsp.config("terraformls", {})

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("pyright")
			vim.lsp.enable("cmake")
			vim.lsp.enable("terraformls")
			vim.lsp.enable("rust_alalyzer")
			vim.lsp.set_log_level("debug")

			-- Customize diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<Space>ee", vim.diagnostic.open_float)
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
					vim.keymap.set("n", "<Space>d", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- Goto definition in new window
					vim.keymap.set("n", "<Space>wg", ":belowright split<CR>:lua vim.lsp.buf.definition()<CR>", opts)

					-- use telescope to search for object references
					vim.keymap.set("n", "gi", require("telescope.builtin").lsp_references, opts)
				end,
			})

			-- Activate neovim lightbulb on hold
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

			-- Show diagnostics on cursor hold
			vim.api.nvim_create_autocmd("CursorHold", {
				pattern = "*",
				vim.lsp.definition,

				callback = function()
					vim.diagnostic.open_float(nil, {
						scope = "cursor",
						focusable = true,
						close_events = { "CursorMoved", "BufHidden", "InsertEnter" },
					})
				end,
			})
		end,
	},
}
