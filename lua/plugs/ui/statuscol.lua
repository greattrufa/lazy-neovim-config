-- ~/.config/nvim/init.lua
return {
	"luukvbaal/statuscol.nvim",
	config = function()
		-- Only basic configuration without complex conditions
		require("statuscol").setup({
			setopt = true,
			ft_ignore = { "Neotree", "TelescopePrompt", "mason", "toggleterm", "floaterm", "help", "terminal" }, -- Add filetypes to ignore
			bt_ignore = { "nofile", "prompt", "terminal" }, -- Ignore by buffer type :cite[1]
			segments = {
				-- Absolute numbers
				{
					text = {
						function()
							local lnum = vim.v.lnum
							if lnum == vim.fn.line(".") then
								return string.format("-%2d-", lnum)
							else
								return string.format("%3d-", lnum)
							end
						end,
					},
					hl = "LineNr",
				},
				-- Relative numbers
				{
					text = {
						function()
							local relnum = vim.v.lnum - vim.fn.line(".")
                            if relnum == 0 then
                                return string.format("-1-")
							elseif relnum < 0 then
								return string.format("%2d ", math.abs(relnum - 1))
							elseif relnum > 0 then
								return string.format("%2d ", math.abs(relnum + 1))
							end
						end,
					},
					condition = {
						function()
							return vim.wo.relativenumber
						end,
					},
					hl = "CursorLineNr",
				},
			},
			separator = " ",
		})

		-- Basic settings
		vim.opt.number = true
		vim.opt.relativenumber = true

		-- Safe buffer handling
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				local ft = vim.bo.filetype
				if
					ft == "Neotree"
					or ft == "TelescopePrompt"
					or ft == "mason"
					or ft == "toggleterm"
					or ft == "floaterm"
				then
					vim.opt_local.statuscolumn = ""
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
				end
			end,
		})
	end,
}
