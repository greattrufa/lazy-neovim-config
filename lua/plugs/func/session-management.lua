return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<Space>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
		{ "<Space>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
		{ "<Space>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
		{ "<Space>wd", "<cmd>AutoSession deletePicker<CR>", desc = "Pick a session to delete" },
	},

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		-- The following are already the default values, no need to provide them if these are already the settings you want.
		session_lens = {
			picker = "telescope", -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also manually choose one. Falls back to vim.ui.select
			-- mappings = {
			-- 	-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
			-- 	delete_session = { "i", "<C-d>" },
			-- 	alternate_session = { "i", "<C-s>" },
			-- 	copy_session = { "i", "<C-y>" },
			-- },

			picker_opts = {
				-- For Telescope, you can set theme options here, see:
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
				--
				border = true,
				layout_config = {
					width = 0.8, -- Can set width and height as percent of window
					height = 0.5,
				},

				-- For Snacks, you can set layout options here, see:
				-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
				--
				-- preset = "dropdown",
				-- preview = false,
				-- layout = {
				--   width = 0.4,
				--   height = 0.4,
				-- },

				-- For Fzf-Lua, picker_opts just turns into winopts, see:
				-- https://github.com/ibhagwan/fzf-lua#customization
				--
				--  height = 0.8,
				--  width = 0.50,
			},

			-- Saving / restoring
			enabled = true, -- Enables/disables auto creating, saving and restoring
			auto_save = true, -- Enables/disables auto saving session on exit
			auto_restore = true, -- Enables/disables auto restoring session on start
			auto_create = false, -- Enables/disables auto creating new session files. Can be a function that returns true if a new session file should be allowed
			auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
			cwd_change_handling = false, -- Automatically save/restore sessions when changing directories
			single_session_mode = false, -- Enable single session mode to keep all work in one session regardless of cwd changes. When enabled, prevents creation of separate sessions for different directories and maintains one unified session. Does not work with cwd_change_handling
			load_on_setup = true,

			-- Default Root Dir
			root_dir = vim.fn.stdpath("data") .. "/sessions/",

			-- Git branch sessions
			git_use_branch_name = false, -- Include git branch name in session name, can also be a function that takes an optional path and returns the name of the branch
			git_auto_restore_on_branch_change = false, -- Should we auto-restore the session when the git branch changes. Requires git_use_branch_name

			-- Extra stuff
			auto_delete_empty_sessions = true,
		},
	},
}
