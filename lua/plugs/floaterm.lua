return {
	"voldikss/vim-floaterm",
	config = function()
		function ToggleFloatermLayout(layout)
			if layout == "vertical" then
				vim.g.floaterm_width = 0.4
				vim.g.floaterm_height = 1.0
				vim.g.floaterm_wintype = "vsplit"
				vim.g.floaterm_position = "bottom"
			elseif layout == "horizontal" then
				vim.g.floaterm_width = 1.0
				vim.g.floaterm_height = 0.4
				vim.g.floaterm_wintype = "split"
				vim.g.floaterm_position = "right"
			else
				vim.g.floaterm_width = 0.8
				vim.g.floaterm_height = 0.8
				vim.g.floaterm_wintype = "float"
				vim.g.floaterm_position = "center"
			end

			vim.cmd("FloatermToggle")
		end

		local map = vim.keymap.set
        local opts = { noremap = true, silent = true }

		map("n", "<Space>v", function()
			ToggleFloatermLayout("vertical")
		end, opts, { desc = "Toggle vertical Floaterm" })
		map("n", "<Space>h", function()
			ToggleFloatermLayout("horizontal")
		end, opts, { desc = "Toggle horizontal Floaterm" })
		map("n", "<C-p>", function()
			ToggleFloatermLayout("float")
		end, opts, { desc = "Toggle floating Floaterm" })

		-- Exit terminal mode
		map("t", "<Esc>", [[<C-\><C-n>]], opts, { desc = "Exit terminal mode" })
	end,
}
