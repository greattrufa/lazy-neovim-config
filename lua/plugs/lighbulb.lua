return {
	"kosayoda/nvim-lightbulb",
	config = function()
		require("nvim-lightbulb").setup({
			sign = { priority = 10 },
			autocmd = { enabled = true },
		})
		vim.fn.sign_define("LightBulbSign", { text = "💡", texthl = "DiagnosticSignInfo" })
	end,

	-- Custom diagnostic colors and styles
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#2d1a1f", fg = "#e06c75" }),
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#2d2a1f", fg = "#e5c07b" }),
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "#1a2d2c", fg = "#61afef" }),
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "#1a1f2d", fg = "#c678dd" }),
}
