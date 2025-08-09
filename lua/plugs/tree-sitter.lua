return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-refactor",
	},
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		require("treesitter-context")

		configs.setup({
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"json",
				"lua",
				"make",
				"python",
				"rust",
				"toml",
				"vim",
			},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			highlight = {
				-- `false` will disable the whole extension
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function(_, bufnr)
					-- Disable for large files
					return vim.api.nvim_buf_line_count(bufnr) > 10000
				end,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			indent = { enable = true },
			additional_vim_regex_highlighting = false,
			refactor = {
				highlight_definitions = { enable = true },
				highlight_current_scope = { enable = false },
				smart_rename = {
					enable = true,
					keymaps = {
						smart_rename = "grr",
					},
				},
			},
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				local line_count = vim.api.nvim_buf_line_count(buf)

				if line_count > 5000 then
					vim.notify(
						"Large file detected (" .. line_count .. " lines), disabling Tree-sitter",
						vim.log.levels.WARN
					)
					vim.treesitter.stop()
				end
			end,
		})
	end,
}
