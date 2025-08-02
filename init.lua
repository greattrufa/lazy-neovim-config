if vim.g.vscode then
    -- VSCode extension
	require("options")
	require("keys")
	--require("config.lazy")
else
    -- ordinary Neovim
	require("options")
	require("keys")
	require("config.lazy")
end
