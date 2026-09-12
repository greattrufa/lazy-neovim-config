return {
	"RRethy/base16-nvim",
	config = function()
		require("base16-colorscheme").with_config({
			fzf = true,
			indentblankline = true,
			ts_rainbow = true,
			cmp = true,
			-- dapui = true,
		})
	end,
}
