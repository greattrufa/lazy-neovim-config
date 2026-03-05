return {
	"voldikss/vim-floaterm",
	config = function()
		function ToggleFloatermLayout(layout)
			-- Create a local config table
			local config = {}

			if layout == "vertical" then
				config.floaterm_width = 0.4
				config.floaterm_height = 1.0
				config.floaterm_wintype = "vsplit"
				config.floaterm_position = "bottom"
			elseif layout == "horizontal" then
				config.floaterm_width = 1.0
				config.floaterm_height = 0.4
				config.floaterm_wintype = "split"
				config.floaterm_position = "right"
			else
				config.floaterm_width = 0.9
				config.floaterm_height = 0.9
				config.floaterm_wintype = "float"
				config.floaterm_position = "center"
			end

			-- ---@class FloatermConfig
			-- ---@field floaterm_width number
			-- ---@field floaterm_height number
			-- ---@field floaterm_wintype string
			-- ---@field floaterm_position string
			--
			-- ---@type FloatermConfig
			-- vim.g = vim.g

			-- Assign the entire table to vim.g in one go
			vim.g.floaterm_width = config.floaterm_width
			vim.g.floaterm_height = config.floaterm_height
			vim.g.floaterm_wintype = config.floaterm_wintype
			vim.g.floaterm_position = config.floaterm_position
			vim.g.floaterm_shell = "powershell.exe -NoLogo"

			vim.cmd("FloatermToggle")
		end

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<Space>v", function()
			ToggleFloatermLayout("vertical")
		end, opts) -- Toggle vertical Floaterm
		map("n", "<Space>h", function()
			ToggleFloatermLayout("horizontal")
		end, opts) -- Toggle horizontal Floaterm
		map("n", "<C-p>", function()
			ToggleFloatermLayout("float")
		end, opts) -- Toggle floating Floaterm

		-- Exit terminal mode
		map("t", "<Esc>", [[<C-\><C-n>]], opts) -- Exit terminal mode
	end,
}
