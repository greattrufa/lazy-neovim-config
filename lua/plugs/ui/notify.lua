return {
	"rcarriga/nvim-notify",
	lazy = true,
	config = function()
		require("notify").setup({
			stages = "fade_in_slide_out", -- Animation style
			timeout = 3000, -- How long notifications stay on screen (ms)
			background_colour = "#000000",
			-- ... see `:h notify.Config` for all options
		})

		-- This is the crucial line that makes Neovim use the plugin
		vim.notify = require("notify")
	end,
}
