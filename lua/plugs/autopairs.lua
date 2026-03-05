return {
	"https://github.com/windwp/nvim-autopairs",
	event = "InsertEnter", -- Only load when you enter Insert mode
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			ts_config = {
				lua = { "string" }, -- it will not add a pair on that treesitter node
				javascript = { "template_string" },
				java = false, -- don't check treesitter on java
			},
		})
	end,
}
