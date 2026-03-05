return {
	"nvim-treesitter/nvim-treesitter",
	-- dependencies = {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	"nvim-treesitter/nvim-treesitter-refactor",
	-- },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"c",
				"cpp",
				"cmake",
				"json",
				"lua",
				"python",
				"rust",
				"toml",

				"javascript",
				"typescript",
				"tsx",
				"javascriptreact",
				"typescriptreact",
				"html",
				"css",
				"json",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
				disable = {},
			},

			indent = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
		})
	end,
}
