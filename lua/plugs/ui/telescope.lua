return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"davvid/telescope-git-grep.nvim",
		"nvim-lua/plenary.nvim",
	},
	tag = "0.1.6",
	config = function()
		require("telescope").load_extension("notify")
		require("telescope").load_extension("noice")
		require("telescope").load_extension("fidget")
		local builtin = require("telescope.builtin")

		-- Make defaults local
		local defaults = {
			file_ignore_patterns = {
				-- Hidden directories
				"%.git/",
				"%.cache/",
				"%.vs/",
				"%.local/",
				"%.vscode/",
				"%.xmake/",
				"%.idea/",
				"%.dart_tool",
				-- Project directories
				"packages/",
				"node_modules/",
				"build/",
				"bin/",
				"dist/",
				"target/",
				"vendor/",
				"media",
				-- Python cache
				"__pycache__/",
				-- Ignore Images
				"%.png",
				"%.jpg",
				"%.jpeg",
				-- Compiled files
				"%.o$",
				"%.so$",
				"%.exe$",
				"%.dll$",
				-- Lock files
				"yarn%.lock",
				"package%-lock%.json",
				-- Zip files
				"%.zip",
				"%.rar",
				"%.7zip",
			},
			-- Keep your other settings
			selection_caret = " ",
			path_display = { "smart" },
		}

		-- Make pickers local
		local pickers = {
			find_files = {
				-- Explicitly show hidden files except ignored patterns
				hidden = true,
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--glob=!.git/*",
					"--glob=!.cache/*",
					"--glob=!.local/*",
					"--glob=!.vscode/*",
					"--glob=!.idea/*",
					"--glob=!.xmake/*",
					"--glob=!.dart_tool/*",
					"--glob=!.vs/",
					"--glob=!node_modules/*",
					"--glob=!build/*",
					"--glob=!dist/*",
					"--glob=!target/*",
					"--glob=!__pycache__/*",
					"--glob=!packages/*",
					"--glob=!bin/*",
					"--glob=!vendor/*",
					"--glob=!media/*",
				},
			},
			live_grep = {
				additional_args = function(opts)
					return {
						"--hidden",
						"--glob=!.git/*",
						"--glob=!.cache/*",
						"--glob=!.local/*",
						"--glob=!.vscode/*",
						"--glob=!.xmake/*",
						"--glob=!.dart_tool/*",
						"--glob=!.idea/*",
						"--glob=!.vs/",
						"--glob=!node_modules/*",
						"--glob=!build/*",
						"--glob=!dist/*",
						"--glob=!target/*",
						"--glob=!__pycache__/*",
						"--glob=!packages/*",
						"--glob=!bin/*",
						"--glob=!vendor/*",
						"--glob=!media/*",
					}
				end,
			},
		}

		-- Pass both defaults and pickers to setup
		require("telescope").setup({
			defaults = defaults,
			pickers = pickers,
		})
	end,
}
