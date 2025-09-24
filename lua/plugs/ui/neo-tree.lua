return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				filesystem = {
					filtered_items = {
						visible = true,
						show_hidden_count = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
				commands = {
					img_wezterm = function(state)
						local node = state.tree:get_node()
						if node.type == "file" then
							require("image_preview").PreviewImage(node.path)
						end
					end,
				},
				window = {
					position = "right",
					width = 35,
					mapping_options = { -- This sets global options for mappings
						noremap = true,
						nowait = true,
					},
					mappings = { -- Define your specific key mappings here
						-- ["<Space>p"] = "image_wezterm", -- " or another map
						["P"] = { -- This should be inside 'mappings'
							"toggle_preview",
							config = {
								use_float = true,
								use_image_nvim = true,
							},
						},
					},
				},
			})

			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			map("n", "<C-c>", ":Neotree toggle<CR>", opts, { desc = "Toggle the filesystem" })
		end,
	},
	{
		"adelarsq/image_preview.nvim",
		event = "VeryLazy",
		config = function()
			require("image_preview").setup()
		end,
	},
}
