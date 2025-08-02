require("plugs.tabby")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better word navigation (works in normal, visual, and insert modes)
-- map({'n', 'v', 'i'}, '<C-Left>', '<C-\\><C-N><Esc>bi', {noremap = true})
-- map({'n', 'v', 'i'}, '<C-Right>', '<C-\\><C-N>e<Right>i', {noremap = true})
-- map({'n', 'v', 'i'}, '<C-Up>', '<C-\\><C-N>:call cursor(line(".")-1,0)<CR>', {noremap = true})
-- map({'n', 'v', 'i'}, '<C-Down>', '<C-\\><C-N>:call cursor(line(".")+1,0)<CR>', {noremap = true})

map('n', "<C-q>", ":q<CR>", opts, { desc = "Quit" })
map('n', "<Space>q", ":qa<CR>", opts, { desc = "Quit all" })
map('n', "<C-a>", "ggVG", opts, { desc = "Select All"})
map('n', "<C-s>", ":w<CR>", { noremap = true, desc = "Save current buffer" })
map('n', "<Space>s", ":wa<CR>", { noremap = true, desc = "Save all buffers" })
map('n', "<C-z>", ":u<CR>", { noremap = true, desc = "Undo the changes with a keybind like a modern IDE" })

-- Make the code navigation work in command mode
map('c', '<C-BS>', '<C-w>', { noremap = true })

map('n', "<C-h>", "<C-w>h", opts, { desc = "switch window left" })
map('n', "<C-l>", "<C-w>l", opts, { desc = "switch window right" })
map('n', "<C-j>", "<C-w>j", opts, { desc = "switch window down" })
map('n', "<C-k>", "<C-w>k", opts, { desc = "switch window up" })

map("n", "<C-n>", ":$tabnew<CR>", opts, { desc = "Create a new tab" })
map("n", "<C-w>", ":tabclose<CR>", opts, { desc = "Close the tab you are at" })
map("n", "<Space>to", ":tabonly<CR>", opts, { desc = "I don't know this one" })
map("n", "<M-Right>", ":tabn<CR>", next_visible_tab ,opts, { desc = "Next Tab" }, '<cmd>tabnext | if tabpagenr(\'$\') == tabpagenr() | tabfirst | endif<cr>')
map("n", "<M-Left>", ":tabp<CR>", opts, prev_visible_tab, { desc = "Previous Tab" }, '<cmd>tabprevious | if tabpagenr() == 1 | tablast | endif<cr>')
-- move current tab to previous position
map("n", "<Space>tmp", ":-tabmove<CR>", opts, { desc = "Moves the previous tab forward" })
-- move current tab to next position
map("n", "<Space>tmn", ":+tabmove<CR>", opts, { desc = "Moves the current tab forward" })

-- Open Mason
map("n", "<Space>m", ":Mason", opts, { desc = "Toggle Mason package manager" })

-- Launch Tetris
map('n', "<Space>tet", ":Tetris<CR>", opts, { desc = "Start a game of Tetris" })

-- Launch Minesweeper
map('n', "<Space>mine", ":Nvimesweeper<CR>", opts, { desc = "Start a game of Minesweeper" })

