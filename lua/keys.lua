local tabby = require("plugs.ui.tabby")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Only map <Space> commands in Normal mode
map("n", "<Space>q", ":qa<CR>", opts, { desc = "Quit all" })
map("n", "<Space>s", ":wa<CR>", opts, { desc = "Save all buffers" })

map("n", "<C-q>", ":q<CR>", opts, { desc = "Quit" })
map("n", "<C-a>", "ggVG", opts, { desc = "Select All" })
map("n", "<C-s>", ":w<CR>", opts, { desc = "Save buffer" })
map("n", "<C-z>", ":u<CR>", opts, { desc = "Undo" })

-- Swtch Between windows
map("n", "<C-h>", "<C-w>h", opts, { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", opts, { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", opts, { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", opts, { desc = "switch window up" })

-- Tetris and Minesweeper
map("n", "<Space>tet", ":Tetris<CR>", opts, { desc = "Tetris" })
map("n", "<Space>mine", ":Nvimesweeper<CR>", opts, { desc = "Minesweeper" })

-- Open specific buffer
map("n", "<Space>m", ":Mason<CR>", opts, { desc = "Toggle Mason package manager" })
map("n", "<Space>t", ":Alpha<CR>", opts, { desc = "Toggle Alpha neovim" })

-- Make the code navigation work in command mode
-- map('c', '<C-BS>', '<C-w>', { noremap = true })

-- Create and close tabs
map("n", "<C-n>", ":$tabnew<CR>", opts, { desc = "Create a new tab" })
map("n", "<C-w>", ":tabclose<CR>", opts, { desc = "Close the tab you are at" })

-- Tab only mode
map("n", "<Space>to", ":tabonly<CR>", opts, { desc = "I don't know this one" })

-- Move right and left tab
map("n", "<M-Right>", ":tabn<CR>", tabby.next_visible_tab, opts, { desc = "Next Tab" })
map("n", "<M-Left>", ":tabp<CR>", opts, tabby.prev_visible_tab, { desc = "Previous Tab" })

-- move current tab to previous position
map("n", "<Space>tmp", ":-tabmove<CR>", opts, { desc = "Moves the previous tab forward" })
-- move current tab to next position
map("n", "<Space>tmn", ":+tabmove<CR>", opts, { desc = "Moves the current tab forward" })

-- telescope keymaps
map("n", "<C-f>", "<cmd>Telescope find_files<cr>", opts, { desc = "Fuzzy find files in cwd" })
map("n", "<C-g>", "<cmd>Telescope live_grep<cr>", opts, { desc = "Fuzzy find recent files" })
map("n", "<C-b>", "<cmd>Telescope buffers<cr>", opts, { desc = "Find string in cwd" })
map("n", "<Space>fs", "<cmd>Telescope git_status<cr>", opts, { desc = "Find string under cursor in cwd" })
map("n", "<Space>fc", "<cmd>Telescope git commits<cr>", opts, { desc = "Find todos" })
map("n", "<Space>ft", "<cmd>Telescope flutter commands<cr>", opts, { desc = "Find todos" })

-- Debbugins keymaps
map("n", "<C-e>", "<cmd>lua require('dap').continue()<cr>", opts, { desc = "Continue" })
map("n", "<Space>br", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts, { desc = "Toggle Breakpoint" })
map("n", "<Space>ds", "<cmd>lua require('dap').disconnect()<cr>", opts, { desc = "Stop the debugging process" })
map("n", "<Space>di", "<cmd>lua require('dap').step_into()<cr>", opts, { desc = "Step Into" })
map("n", "<Space>do", "<cmd>lua require('dap').step_over()<cr>", opts, { desc = "Step Over" })
map("n", "<Space>du", "<cmd>lua require('dap').step_out()<cr>", opts, { desc = "Step Out" })

-- Similar debugging stuff
map("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", opts)
map("n", "<Space>br", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts)
map("n", "<F10>", "<cnd>lua require('dap').step_over<cr>", opts)
map("n", "<F11>", "<cmd>lua require('dap').step_into<cr>", opts)
