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
	"cesaralvarod/tokyogogh.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyogogh").setup({
			compile = false,
			style = "storm", -- storm | night
			term_colors = true,
			transparent = true, -- do set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`

			-- Change code styles
			code_styles = {
				strings = { italic = true, bold = false },
				comments = { italic = true, bold = false },
				functions = { italic = false, bold = false },
				variables = { italic = false, bold = true },
			},
			diagnostics = {
				undercurl = true, -- use undercurl instead of underline
				background = true,
			},
			theme = "night", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "night", -- try "dragon" !
				light = "storm",
			},
			-- Customization
			colors = {},
			highlight = {},
		})
	end,
}
