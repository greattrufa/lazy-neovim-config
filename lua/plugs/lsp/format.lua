return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"zapling/mason-conform.nvim",
	},
	config = function()
		local conform = require("conform")
		local conform_mason = require("mason-conform")

		conform.setup({
			formatters_by_ft = {
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				c = { "prettier" },
				cpp = { "prettier" },
			},

			format_on_save = {
				lsp_format = "fallback",
				lsp_fallback = true,
				async = false,
				quiet = false,
				timeout_ms = 3000,
			},

			formatters = {
				injected = { options = { ignore_errors = true } },
			},
		})

		conform_mason.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
			},
		})

		vim.keymap.set({ "n", "v" }, "<Space>fm", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
