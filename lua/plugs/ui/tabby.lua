return {
	"nanozuki/tabby.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.nvim",
		"echasnovski/mini.icons",
	},
	config = function()
		local theme = {
			fill = "TabLineFill",
			-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
			head = "TabLine",
			current_tab = "TabLineSel",
			tab = "TabLine",
			win = "TabLine",
			tail = "TabLine",
		}

		require("tabby").setup({
			preset = "active_wins_at_end",
			nerdfont = true,

			line = function(line)
				return {
					{
						{ "  ", hl = theme.head },
						line.sep("", theme.head, theme.fill),
					},
					line.tabs().foreach(function(tab)
						local hl = tab.is_current() and theme.current_tab or theme.tab
						return {
							line.sep("", hl, theme.fill),
							tab.is_current() and "" or "󰆣",
							tab.number(),
							tab.name(),
							tab.close_btn(""),
							line.sep("", hl, theme.fill),
							hl = hl,
							margin = " ",
						}
					end),
					line.spacer(),
					line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
						return {
							line.sep("", theme.win, theme.fill),
							win.is_current() and "" or "",
							win.buf_name(),
							line.sep("", theme.win, theme.fill),
							hl = theme.win,
							margin = " ",
						}
					end),
					{
						line.sep("", theme.tail, theme.fill),
						{ "  ", hl = theme.tail },
					},
					hl = theme.fill,
				}
			end,
			-- option = {}, -- setup modules' option,
		})

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Use pcall to catch errors
				local success, err = pcall(function()
					if #vim.fn.argv() > 1 then
						for i = 2, #vim.fn.argv() do
							vim.cmd("tabedit " .. vim.fn.argv()[i])
						end
					end
				end)
				if not success then
					vim.notify("Error in Tabby VimEnter: " .. err, vim.log.levels.WARN)
				end
			end,
		})

		vim.api.nvim_create_autocmd("BufAdd", {
			callback = function()
				local success, err = pcall(function()
					if vim.bo.buftype == "" then
						vim.cmd("tabedit %")
					end
				end)
				if not success then
					-- vim.notify("Error in Tabby BufAdd: " .. err, vim.log.levels.WARN)
					-- ... Hear me out this is not going to stay like this probably
					return
				end
			end,
		})
	end,
}
