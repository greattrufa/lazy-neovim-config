return {
	-- || THE KANAGAWA THEMES || --
	-- "rebelot/kanagawa.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	require("kanagawa").setup({
	-- 		compile = false, -- enable compiling the colorscheme
	-- 		undercurl = true, -- enable undercurls
	-- 		commentStyle = { bold = true },
	-- 		functionStyle = {},
	-- 		keywordStyle = { bold = true },
	-- 		statementStyle = { bold = true },
	-- 		typeStyle = {},
	-- 		transparent = true, -- do set background color
	-- 		dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	-- 		terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- 		colors = { -- add/modify theme and palette colors
	-- 			palette = {},
	-- 			theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 		},
	-- 		overrides = function(colors) -- add/modify highlights
	-- 			return {}
	-- 		end,
	-- 		theme = "wave", -- Load "wave" theme when 'background' option is not set
	-- 		background = { -- map the value of 'background' option to a theme
	-- 			dark = "wave", -- try "dragon" !
	-- 			light = "lotus",
	-- 		},
	-- 	})
	-- 	-- setup must be called before loading
	-- 	vim.cmd("colorscheme kanagawa")
	-- end,

	-- || THE TOKYO NIGHT GOGH THEMES || --
	-- "cesaralvarod/tokyogogh.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	require("tokyogogh").setup({
	-- 		compile = false,
	-- 		style = "storm", -- storm | night
	-- 		term_colors = true,
	-- 		transparent = true, -- do set background color
	-- 		dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	--
	-- 		-- Change code styles
	-- 		code_styles = {
	-- 			strings = { italic = true, bold = false },
	-- 			comments = { italic = true, bold = false },
	-- 			functions = { italic = false, bold = false },
	-- 			variables = { italic = false, bold = true },
	-- 		},
	-- 		diagnostics = {
	-- 			undercurl = true, -- use undercurl instead of underline
	-- 			background = true,
	-- 		},
	-- 		theme = "night", -- Load "wave" theme when 'background' option is not set
	-- 		background = { -- map the value of 'background' option to a theme
	-- 			dark = "night", -- try "dragon" !
	-- 			light = "storm",
	-- 		},
	-- 		-- Customization
	-- 		colors = {},
	-- 		highlight = {},
	-- 	})
	-- end,

	-- || THE ONE DARK THEMES || --
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				-- Main options --
				style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = false, -- Show/hide background
				term_colors = true, -- Change terminal color as per the selected theme style
				ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
				cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

				-- toggle theme style ---
				toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
				toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

				-- Change code style ---
				-- Options are italic, bold, underline, none
				-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
				code_style = {
					comments = "italic",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},

				-- Lualine options --
				lualine = {
					transparent = false, -- lualine center bar transparency
				},

				-- Custom Highlights --
				colors = {}, -- Override default colors
				highlights = {}, -- Override highlight groups

				-- Plugins Config --
				diagnostics = {
					darker = true, -- darker colors for diagnostic
					undercurl = true, -- use undercurl instead of underline for diagnostics
					background = true, -- use background color for virtual text
				},
			})
			-- Enable theme
			require("onedark").load()
		end,
	},
}
