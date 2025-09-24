return {
	"Exafunction/windsurf.vim",
	event = "BufEnter",
	lazy = true,
	config = function()
		-- require("windsurf").setup({})

		vim.g.codeium_enabled = false
		vim.g.codeium_filetypes_disabled_by_default = false
		vim.g.codeium_render = true

		vim.keymap.set("i", "<Space>a", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-;>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-,>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })
	end,
}
