local global = vim.g
local o = vim.opt

-- Editor options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
o.mouse = 'a'                       -- Enable mouse support
o.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
o.swapfile = false                  -- Don't use swapfile
o.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
o.encoding = "UTF-8" -- Don't know what this is
o.syntax = on -- Syntax highlight by default
o.ma = true
o.modifiable = true
o.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
o.number = true           -- Show line number
o.showmatch = true        -- Highlight matching parenthesis
o.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
o.colorcolumn = '120'      -- Line lenght marker at 80 columns
o.splitright = true       -- Vertical split to the right
o.splitbelow = true       -- Horizontal split to the bottom
o.ignorecase = true       -- Ignore case letters when search
o.smartcase = true        -- Ignore lowercase for the whole pattern
o.linebreak = true        -- Wrap on word boundary
o.termguicolors = true    -- Enable 24-bit RGB colors
o.laststatus=3            -- Set global statusline
o.cursorline = true    -- Sets the line cursor
o.termguicolors = true

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
o.expandtab = true        -- Use spaces instead of tabs
o.shiftwidth = 4          -- Shift 4 spaces when tab
o.tabstop = 4             -- 1 tab == 4 spaces
o.smartindent = true      -- Autoindent new lines
o.showtabline = 2       -- Show the tapline

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
o.hidden = true           -- Enable background buffers
o.history = 100           -- Remember N lines in history
o.lazyredraw = true       -- Faster scrolling
o.synmaxcol = 240         -- Max column for syntax highlight
o.updatetime = 250        -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
o.shortmess:append "sI"

-- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
   global["loaded_" .. plugin] = 1
end



vim.g.wordmotion_prefix = '<C>'  -- Use Ctrl instead of default leader
vim.g.wordmotion_mappings = {
  ['<C-Right>'] = 'w',  -- Next word
  ['<C-Left>'] = 'b',   -- Previous word
  ['<C-Up>'] = 'gk',    -- Up line (visual)
  ['<C-Down>'] = 'gj',  -- Down line (visual)
}

