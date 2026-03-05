return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"https://github.com/junegunn/fzf",
	},
	keys = {
		{ "<C-f>", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<C-b>", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
		{ "<Leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Search project" },
	},
	-- opts = function(_, opts)
	-- 	opts.fzf_opts = { ["--border"] = "rounded" }
	-- 	opts.winopts = {
	-- 		width = 0.8,
	-- 		height = 0.7,
	-- 		preview = { scrollchars = { "─", " " } },
	-- 	}
	-- 	opts.file_ignore_patterns = {
	-- 		"node_modules",
	-- 		".git",
	-- 		"build",
	-- 		"dist",
	-- 		"%.jpg$",
	-- 		"%.png$",
	-- 	}
	-- 	opts.fd_opts = {
	-- 		"--color=never",
	-- 		"--type=f",
	-- 		"--hidden",
	-- 		"--follow",
	-- 		"--exclude=.git",
	-- 		"--exclude=build",
	-- 		"--exclude=node_modules",
	-- 	}
	-- end,
	config = function()
		require("fzf-lua").setup({
			fzf_opts = { ["--border"] = "rounded" },
			winopts = {
				width = 0.8,
				height = 0.8,
				preview = { scrollchars = { "─", " " } },
			},
			file_ignore_patterns = {
				"node_modules",
				"target",
				"src-tauri/target",
				".git",
				".venv",
				".vscode",
				"build",
				".xmake",
				"bin",
				"dist",
				"%.jpg$",
				"%.png$",
			},
			fd_opts = {
				"--color=never",
				"--type=f",
				"--hidden",
				"--follow",
				"--exclude=.git",
				"--exclude=build",
				"--exclude=node_modules",
				"--exclude=target",
				"--exclude=src-tauri/target",
			},
			files = {
				actions = {
					["default"] = require("fzf-lua.actions").file_tabedit,
				},
			},
		})
	end,
}
