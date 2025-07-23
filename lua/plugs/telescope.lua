return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    tag = "0.1.6",
    config = function()
        local builtin = require('telescope.builtin')
        -- local actions = require('telescope.actions')

        -- load extension into telescope
        -- require('telescope').load_extension("ui-select")
        -- require('telescope').load_extension('dap')
        require('telescope').setup()
          -- defaults = {
            -- layout_strategy = "horizontal",
           -- },
           -- pickers = {
           --   find_files = {
           --     find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
             -- },
           -- }
            -- extensions = {
              -- ["ui-select"] = {
               -- require("telescope.themes").get_dropdown {}
             -- }
           -- }

        -- set keymaps
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }

        map("n", "<C-f>", "<cmd>Telescope find_files<cr>", opts, { desc = "Fuzzy find files in cwd" })
        map("n", "<C-g>", "<cmd>Telescope live_grep<cr>", opts, { desc = "Fuzzy find recent files" })
        map("n", "<C-b>", "<cmd>Telescope buffers<cr>", opts, { desc = "Find string in cwd" })
        map("n", "<leader>fs", "<cmd>Telescope git_status<cr>", opts, { desc = "Find string under cursor in cwd" })
        map("n", "<leader>fc", "<cmd>Telescope git commits<cr>", opts, { desc = "Find todos" })
    end,
}

