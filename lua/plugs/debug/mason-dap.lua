return {
	"jay-babu/mason-nvim-dap.nvim",
	event = "VeryLazy",
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"codelldb",
				"cppdbg",
				"dart-debug-adapter",
			},
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
	end,
}
