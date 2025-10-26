local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

local function create_clang_format()
	local cwd = vim.fn.getcwd()
	local clang_format_file = cwd .. "/.clang-format"

	if vim.fn.filereadable(clang_format_file) == 0 then
		-- Define your preferred clang-format configuration
		local config = [[
# Based on the widely recognized WebKit style for a balanced starting point.
BasedOnStyle: WebKit

# Essential Language and Standard Settings
Language: Cpp
Standard: c++20
UseTab: Never
TabWidth: 4
IndentWidth: 4
ColumnLimit: 200

# Brace breaking style - allows more code to fit vertically.
BreakBeforeBraces: Attach
Cpp11BracedListStyle: false

# Alignment and Whitespace Rules
AlignAfterOpenBracket: BlockIndent
AlignConsecutiveAssignments: true
AlignConsecutiveDeclarations: true
AlignEscapedNewlines: Left
AlignOperands: Align
AlignTrailingComments: true
AlignArrayOfStructures: None

# Handling of function and constructor arguments
AllowAllParametersOfDeclarationOnNextLine: false
AllowShortFunctionsOnASingleLine: Empty
AllowShortIfStatementsOnASingleLine: Never
AllowShortLoopsOnASingleLine: false
AlwaysBreakTemplateDeclarations: Yes
BinPackArguments: false
BinPackParameters: false

# Pointer and Reference Alignment
DerivePointerAlignment: false
PointerAlignment: Left

# Namespace and Comment Formatting
NamespaceIndentation: All
ReflowComments: true

# Includes sorting - CRITICAL: Be aware of potential performance implications:cite[3]
SortIncludes: false
        ]]

		-- Write the config to file
		local file = io.open(clang_format_file, "w")
		if file then
			file:write(config)
			file:close()
			vim.notify("Created .clang-format file in " .. cwd)
		else
			vim.notify("Failed to create .clang-format file", vim.log.levels.ERROR)
		end
		-- else
		-- 	vim.notify(".clang-format file already exists in " .. cwd)
	end
end

-- Create a command to run this function
vim.api.nvim_create_user_command("ClangFormatInit", create_clang_format, {})

-- Set autocmd for C/C++ files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
	callback = function()
		-- Only run once per directory to avoid multiple checks
		if not vim.b.clang_format_created then
			create_clang_format()
			vim.b.clang_format_created = true
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "xmake.lua",
	callback = function()
		vim.fn.jobstart("xmake project -k compile_commands", {
			on_exit = function(_, code)
				if code == 0 then
					print("Updated compile_commands.json")
				end
			end,
		})
	end,
})

-- Auto commands for C++ specific behavior
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*.cpp,*.hpp,*.cc,*.hh,*.cxx,*.hxx,*.c,*.h",
	callback = function()
		-- Refresh folds when entering C++ files
		vim.cmd("normal! zx")
	end,
})
