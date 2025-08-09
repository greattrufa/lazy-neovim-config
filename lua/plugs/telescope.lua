return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  tag = "0.1.6",
  config = function()
    local builtin = require("telescope.builtin")

    -- Make defaults local
    local defaults = {
      file_ignore_patterns = {
        -- Hidden directories
        "%.git/",
        "%.cache/",
        "%.local/",
        "%.vscode/",
        "%.xmake/",
        -- Project directories
        "packages/",
        "node_modules/",
        "build/",
        "bin/",
        "dist/",
        "target/",
        "vendor/",
        -- Python cache
        "__pycache__/",
        -- Ignore Images
        "%.png",
        "%.jpg",
        "%.jpeg",
        -- Compiled files
        "%.o$",
        "%.so$",
        "%.exe$",
        "%.dll$",
        -- Lock files
        "yarn%.lock",
        "package%-lock%.json",
        -- Zip files
        "%.zip",
        "%.rar",
        "%.7zip"
      },
      -- Keep your other settings
      selection_caret = " ",
      path_display = { "smart" },
    }

    -- Make pickers local
    local pickers = {
      find_files = {
        -- Explicitly show hidden files except ignored patterns
        hidden = true,
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--glob=!.git/*",
          "--glob=!.cache/*",
          "--glob=!.local/*",
          "--glob=!.vscode/*",
          "--glob=!.xmake/*",
          "--glob=!node_modules/*",
          "--glob=!build/*",
          "--glob=!dist/*",
          "--glob=!target/*",
          "--glob=!__pycache__/*",
          "--glob=!packages/*",
          "--glob=!bin/*",
          "--glob=!vendor/*",
        },
      },
      live_grep = {
        additional_args = function(opts)
          return {
            "--hidden",
            "--glob=!.git/*",
            "--glob=!.cache/*",
            "--glob=!.local/*",
            "--glob=!.vscode/*",
            "--glob=!.xmake/*",
            "--glob=!node_modules/*",
            "--glob=!build/*",
            "--glob=!dist/*",
            "--glob=!target/*",
            "--glob=!__pycache__/*",
            "--glob=!packages/*",
            "--glob=!bin/*",
            "--glob=!vendor/*",
          }
        end,
      },
    }

    -- Pass both defaults and pickers to setup
    require("telescope").setup({
      defaults = defaults,
      pickers = pickers,  -- This line was missing
    })
  end,
}
