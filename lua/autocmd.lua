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
Standard: c++26
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

# Includes sorting - CRITICAL: Be aware of potential performance implications
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

-- Inform pyright of the .venv environment
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.py",
	callback = function()
		local venv = vim.fs.find(".venv", { upward = true, type = "directory" })[1]
		if not venv then
			return
		end

		local project_dir = vim.fn.fnamemodify(venv, ":h")
		local toml_path = project_dir .. "/pyproject.toml"
		local config_line = '[tool.pyright]\nvenvPath = "."\nvenv = ".venv"'

		local file = io.open(toml_path, "r")
		if not file then
			return
		end

		local content = file:read("*a")
		file:close()

		if content:find("%[tool%.pyright%]") then
			return
		end

		file = io.open(toml_path, "a")
		if file then
			if not content:match("\n$") then
				file:write("\n")
			end
			file:write(config_line .. "\n")
			file:close()
		end
	end,
})

-- Automatically switch to the .venv environment if there is one in the root
vim.api.nvim_create_autocmd("FileType", {
	pattern = "floaterm",
	callback = function()
		local venv = vim.fs.find(".venv", { upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
		if not venv then
			return
		end

		local venvScript = vim.fs.joinpath(vim.fn.fnamemodify(venv, ":p"), "Scripts", "activate.ps1")
		if vim.fn.filereadable(venvScript) ~= 1 then
			return
		end

		vim.defer_fn(function()
			pcall(vim.cmd, "FloatermSend " .. venvScript)
		end, 10)
	end,
})

-- Autoclose empty tabs
vim.api.nvim_create_autocmd("TabNew", {
	callback = function()
		local buffers = vim.api.nvim_list_bufs()
		for _, bufnr in ipairs(buffers) do
			if
				vim.api.nvim_buf_is_loaded(bufnr)
				and vim.api.nvim_buf_get_name(bufnr) == ""
				and vim.bo[bufnr].buftype == ""
			then
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				local total_chars = 0
				for _, line in ipairs(lines) do
					total_chars = total_chars + #line
				end
				if total_chars == 0 then
					vim.api.nvim_buf_delete(bufnr, { force = true })
				end
			end
		end
	end,
})
