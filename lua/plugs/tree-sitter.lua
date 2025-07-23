return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      require 'treesitter-context'

      configs.setup({
        ensure_installed = {
          'bash', 'c', 'cmake', 'cpp', 'json', 
          'lua', 'make', 'python', 'rust', 'toml', 'vim',
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
        },
        indent = { enable = true },
        additional_vim_regex_highlighting = false,
      })
    end
}

