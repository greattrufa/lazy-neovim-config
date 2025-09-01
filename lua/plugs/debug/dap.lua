return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	opts = {},
	config = function()
		local dap = require("dap")

		-- C/C++ Debug Configuration
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

			-- On windows you may have to uncomment this:
			detached = false,
		}

		dap.configurations.cpp = {
			{
				name = "Launch xmake build",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		-- Dart and Flutter Debug Configuration
		local flutter_path = "C:/flutter/"

		dap.configurations.dart = {
			{
				type = "dart",
				request = "launch",
				name = "Launch dart",
				dartSdkPath = flutter_path, -- ensure this is correct
				flutterSdkPath = flutter_path, -- ensure this is correct
				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
				cwd = "${workspaceFolder}",
			},
			{
				type = "flutter",
				request = "launch",
				name = "Launch flutter",
				dartSdkPath = flutter_path, -- ensure this is correct
				flutterSdkPath = flutter_path, -- ensure this is correct
				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
				cwd = "${workspaceFolder}",
			},
		}

		dap.adapters.dart = {
			type = "executable",
			command = "dart.bat", -- if you're using fvm, you'll need to provide the full path to dart (dart.exe for windows users), or you could prepend the fvm command
			args = { "debug_adapter" },
			-- windows users will need to set 'detached' to false
			options = {
				detached = false,
			},
		}

		dap.adapters.flutter = {
			type = "executable",
			command = "flutter.bat", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
			args = { "debug_adapter" },
			-- windows users will need to set 'detached' to false
			options = {
				detached = false,
			},
		}
	end,
}
