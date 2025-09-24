return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	opts = {},
	config = function()
		local dap = require("dap")

		-- Load from vscode
		require("dap.ext.vscode").load_launchjs(nil, {
			cppdbg = { "c", "cpp", "rust" }, -- Map to C/C++/Rust filetypes
		})

		-- C/C++ Debug Configuration
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = {
					"--port",
					"${port}",
					"--settings",
					'{"showDisassembly": "auto", "displayFormat": "auto"}',
				},
				-- On Windows, you might need:
				detached = false,
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch C++ (Debug)",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
				env = {}, -- Add environment variables if needed
				terminal = "external", -- or "external"
				console = "externalTerminal",
				sourceLanguages = { "cpp" },
				-- For better debugging experience
				showDisassembly = "auto",
				disassemblyView = "auto",
			},
			{
				name = "Attach to Process",
				type = "codelldb",
				request = "attach",
				processId = require("dap.utils").pick_process,
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
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
