return {
  'nanozuki/tabby.nvim',
  dependencies = { 
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.nvim',
    'echasnovski/mini.icons'
  },
  config = function()
    local theme = {
      fill = 'TabLineFill',
      -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = 'TabLine',
      win = 'TabLine',
      tail = 'TabLine',
    }
    require('tabby').setup({
    preset = 'active_wins_at_end',
    nerdfont = true,
    line = function(line)
      return {
        {
          { '  ', hl = theme.head },
          line.sep('', theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep('', hl, theme.fill),
            tab.is_current() and '' or '󰆣',
            tab.number(),
            tab.name(),
            tab.close_btn(''),
            line.sep('', hl, theme.fill),
            hl = hl,
            margin = ' ',
          }
        end),
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          return {
            line.sep('', theme.win, theme.fill),
            win.is_current() and '' or '',
            win.buf_name(),
            line.sep('', theme.win, theme.fill),
            hl = theme.win,
            margin = ' ',
          }
        end),
        {
          line.sep('', theme.tail, theme.fill),
          { '  ', hl = theme.tail },
        },
        hl = theme.fill,
      }
    end,
    -- option = {}, -- setup modules' option,
    })
    -- Get visible tab IDs in left-to-right order
    local function get_visible_tab_order()
      local tabs = {}
      for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
        table.insert(tabs, tabid)
      end
      return tabs
    end

    -- Navigate to next visible tab (right)
    local function next_visible_tab()
      local tabs = get_visible_tab_order()
      local current_tab = vim.api.nvim_get_current_tabpage()
      local current_index = vim.tbl_contains(tabs, current_tab) or 1
      
      for i, tabid in ipairs(tabs) do
        if tabid == current_tab then
          current_index = i
          break
        end
      end
      
      local next_index = current_index + 1
      if next_index > #tabs then next_index = 1 end
      
      vim.api.nvim_set_current_tabpage(tabs[next_index])
    end

    -- Navigate to previous visible tab (left)
    local function prev_visible_tab()
      local tabs = get_visible_tab_order()
      local current_tab = vim.api.nvim_get_current_tabpage()
      local current_index = vim.tbl_contains(tabs, current_tab) or 1
      
      for i, tabid in ipairs(tabs) do
        if tabid == current_tab then
          current_index = i
          break
        end
      end
      
      local prev_index = current_index - 1
      if prev_index < 1 then prev_index = #tabs end
      
      vim.api.nvim_set_current_tabpage(tabs[prev_index])
    end

    vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      if #vim.fn.argv() > 1 then
        for i = 2, #vim.fn.argv() do
          vim.cmd('tabedit ' .. vim.fn.argv()[i])
        end
      end
    end
  })

  vim.api.nvim_create_autocmd('BufAdd', {
    callback = function()
      if vim.bo.buftype == '' then
        vim.cmd('tabedit %')
      end
    end
  })

  end,
}

