return {
	{
		"rcarriga/nvim-notify",
		lazy = true,
		config = function()
			require("notify").setup({
				-- Animation style
				stages = "fade_in_slide_out", -- Other options: "fade", "slide", "static" :cite[1]
				timeout = 3000, -- Slightly longer default timeout

				-- -- Maximum dimensions for the notification window
				max_width = function()
					return math.floor(vim.o.columns * 0.3)
				end, -- Dynamic width based on screen size
				max_height = function()
					return math.floor(vim.o.lines * 0.3)
				end,
				--
				top_down = false,
				--
				-- -- Rendering style for the notification layout
				render = "wrapped-compact", -- Other styles: "default", "minimal", "compact", "simple" :cite[1]
				--
				-- -- Default level for notifications (can be used to filter less important info) :cite[10]
				level = vim.log.levels.INFO,
				--
				-- -- Background color for floating window (transparent for better integration)
				background_colour = "NotifyBackground", -- Use a highlight group for theme consistency
				-- Enable or disable the notification history :cite[1]
				-- Setting this to true allows you to access past notifications
			})

			-- Override the default vim.notify, crucial for capturing all messages
			vim.notify = require("notify")
		end,
	},
	{
		"folke/noice.nvim",
		-- event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				-- views = {
				-- 	mini = {
				-- 		position = { col = -1, row = -1 }, -- Bottom right corner
				-- 	},
				-- },
				messages = {
					view = "mini", -- Use the mini view for messages
				},

				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				hover = {
					enabled = true,
				},
				signature = {
					enabled = true,
					-- Optional: auto-open signature help when typing triggers it
					auto_open = {
						enabled = true,
						trigger = true, -- Automatically show signature help as you type
						luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
						throttle = 50, -- Debounce lsp signature help request by 50ms
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long mssages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}
