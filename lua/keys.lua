local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Only map <Space> commands in Normal mode
map("n", "<Leader>q", ":qa<CR>", opts) -- Quit all
map("n", "<Leader>s", ":wa<CR>", opts) -- Save all buffers

map("n", "<C-q>", ":q<CR>", opts) -- Quit
map("n", "<C-a>", "ggVG", opts) -- Select All
map("n", "<C-s>", ":w<CR>", opts) -- Save buffer" })
map("n", "<C-z>", ":u<CR>", opts) -- Undo

-- Swtch Between windows
map("n", "<C-h>", "<C-w>h<CR>", opts) -- switch window left
map("n", "<C-l>", "<C-w>l<CR>", opts) -- switch window right
map("n", "<C-j>", "<C-w>j<CR>", opts) -- switch window down
map("n", "<C-k>", "<C-w>k<CR>", opts) -- switch window up

-- Tetris and Minesweeper
map("n", "<Space>tet", ":Tetris<CR>", opts) -- Tetris
map("n", "<Space>mine", ":Nvimesweeper<CR>", opts) -- Minesweeper

-- Open specific buffer
map("n", "<Space>m", ":Mason<CR>", opts) -- Toggle Mason package manager
map("n", "<Space>t", ":Alpha<CR>", opts) -- Toggle Alpha neovim

-- Create and close tabs
map("n", "<C-n>", ":$tabnew<CR>", opts) -- Create a new tab
map("n", "<C-w>", ":tabclose<CR>", opts) -- Close the tab you are at

-- Splitting functionality
map("n", "<Leader>vv", ":vsplit<CR>", opts) -- Vertically slipt the windows
map("n", "<Leader>hh", ":split<CR>", opts) -- Horizontally slipt the windows

-- Tab only mode
map("n", "<Leader>to", ":tabonly<CR>", opts) -- I don't know this one

-- Move right and left tab
map("n", "<M-Right>", ":tabn<CR>", opts) -- Next Tab
map("n", "<M-Left>", ":tabp<CR>", opts) -- Previous Tab

-- move current tab to previous position
map("n", "<Leader>tmp", ":-tabmove<CR>", opts) -- Moves the previous tab forward
-- move current tab to next position
map("n", "<Leader>tmn", ":+tabmove<CR>", opts) -- Moves the current tab forward

-- Debbugins keymaps
map("n", "<C-e>", "<cmd>lua require('dap').continue()<cr>", opts) -- Continue
map("n", "<Space>br", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts) -- Toggle Breakpoint
map("n", "<Space>ds", "<cmd>lua require('dap').disconnect()<cr>", opts) -- Stop the debugging process
map("n", "<Space>di", "<cmd>lua require('dap').step_into()<cr>", opts) -- Step Into
map("n", "<Space>do", "<cmd>lua require('dap').step_over()<cr>", opts) -- Step Over
map("n", "<Space>du", "<cmd>lua require('dap').step_out()<cr>", opts) -- Step Outline
