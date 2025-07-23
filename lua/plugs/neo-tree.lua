return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
      close_if_last_window = false,
			filesystem = {
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
			window = {
				position = "right",
				width = 35,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
			},
		})
    
    local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<C-c>", ":Neotree toggle<CR>", opts, { desc = "Toggle the filesystem" })

  end,
}
