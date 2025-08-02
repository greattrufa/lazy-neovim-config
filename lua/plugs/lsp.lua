return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				max_concurrent_installers = 4,
				providers = {
					"mason.providers.registry-api",
					"mason.providers.client",
				},
				ui = {
					check_outdated_packages_on_open = true,
					PATH = "prepend",
					border = "rounded",
					backdrop = 60,
					width = 0.8,
					height = 0.9,
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				keymaps = {
					-- Keymap to expand a package
					toggle_package_expand = "<CR>",
					-- Keymap to install the package under the current cursor position
					install_package = "i",
					-- Keymap to reinstall/update the package under the current cursor position
					update_package = "u",
					-- Keymap to check for new version for the package under the current cursor position
					check_package_version = "c",
					-- Keymap to update all installed packages
					update_all_packages = "U",
					-- Keymap to check which installed packages are outdated
					check_outdated_packages = "C",
					-- Keymap to uninstall a package
					uninstall_package = "X",
					-- Keymap to cancel a package installation
					cancel_installation = "<C-c>",
					-- Keymap to apply language filter
					apply_language_filter = "<C-f>",
					-- Keymap to toggle viewing package installation log
					toggle_package_install_log = "<CR>",
					-- Keymap to toggle the help view
					toggle_help = "g?",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"cmake",
					"lua_ls",
					-- "prettier",
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

			-- Fix Windows path issues
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

			-- Get the language server to recognize the `vim` global
			lspconfig.lua_ls.setup({
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			})
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=never",
					"--query-driver=clang*,gcc*,gcc*,cl.exe", -- Add your compiler paths here if needed
					"--compile-commands-dir=build", -- Point to your build directory
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
					-- Prioritize finding build/compile_commands.json
					return lspconfig.util.root_pattern(
						"build/compile_commands.json", -- Add this pattern
						"compile_commands.json",
						"compile_flags.txt",
						".clangd",
						"CMakeLists.txt",
						"xmake.lua",
						".git"
					)(fname) or lspconfig.util.path.dirname(fname)
				end,
				capabilities = {
					offsetEncoding = "utf-8", -- Must match cmd parameter
				},
			})
			lspconfig.cmake.setup({})
			lspconfig.cssls.setup({})
			lspconfig.gopls.setup({})
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
			-- Add this to your nvim-lspconfig config function
			vim.diagnostic.config({
				virtual_text = {
					source = "always", -- Show source of diagnostic
					prefix = "●", -- Custom prefix character
					spacing = 4, -- Space before diagnostic message
				},
				signs = true, -- Show signs in gutter
				underline = true, -- Underline problematic code
				update_in_insert = false, -- Don't update while typing
				severity_sort = true, -- Sort diagnostics by severity
			})

			-- Customize diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

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
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- Goto definition in new window
					vim.keymap.set("n", "<leader>wg", ":belowright split<CR>:lua vim.lsp.buf.definition()<CR>", opts)

					-- use telescope to search for object references
					vim.keymap.set("n", "gi", require("telescope.builtin").lsp_references, opts)
				end,
			})
		end,
	},
}
