return {
  "Mythos-404/xmake.nvim",
  version = "^3",
  lazy = true,
  event = "BufReadPost xmake.lua",
  config = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim"
  },
  -- Configuration when saving `xmake.lua`
  on_save = {
    -- Reload project information
    reload_project_info = true,
    -- Configuration for generating `compile_commands.json`
    lsp_compile_commands = {
      enable = true,
      -- Directory name (relative path) for output file
      output_dir = "build",
    },
  },

  -- Lsp related configuration
  lsp = {
    enable = true,
    language = "en", ---@type "en"|"zh-cn"
  },

  -- Debugger related configuration
  debuger = {
    -- Checks the project's build mode, and if it’s not among the modes below,
    -- it will automatically switch to `debug` mode for build/run,
    -- and then switch back to the original build mode
    rulus = { "debug", "releasedbg" },
    -- Dap configuration, please refer to Dap and the debugger's documentation
    dap = {
      name = "Xmake Debug",
      type = "codelldb",
      request = "launch",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      stopOnEntry = false,
      runInTerminal = true,
    },
  },

  -- Notification related settings
  notify = {
    -- Icons for completion
    icons = {
      error = "",
      successfully = "",
    },
    -- Icons for progress display
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    -- Refresh rate for the progress bar
    refresh_rate_ms = 100,
  },

  -- Runner configuration
  runner = {
    -- Select which backend to use
    type = "toggleterm", ---@type "toggleterm"|"terminal"|"quickfix"|"snacks"

    config = {
      toggleterm = {
        direction = "float", ---@type "vertical"|"horizontal"|"tab"|"float"
        singleton = true,
        auto_scroll = true,
        close_on_success = false,
      },
      terminal = {
        name = "Runner Terminal",
        prefix_name = "[Xmake]: ",
        split_size = 15,
        split_direction = "horizontal", ---@type "vertical"|"horizontal"
        focus = true,
        focus_auto_insert = true,
        auto_resize = true,
        close_on_success = false,
      },
      quickfix = {
        show = "always", ---@type "always"|"only_on_error"
        size = 15,
        position = "botright", ---@type "vertical"|"horizontal"|"leftabove"|"aboveleft"|"rightbelow"|"belowright"|"topleft"|"botright"
        close_on_success = false,
      },
      snacks = {
        position = "float",
        interactive = true,
      },
    },
  },
  -- Executor configuration
  execute = {
    -- Select which backend to use
    type = "quickfix", ---@type "toggleterm"|"terminal"|"quickfix"|"snacks"

    config = {
      toggleterm = {
        direction = "float", ---@type "vertical"|"horizontal"|"tab"|"float"
        singleton = true,
        auto_scroll = true,
        close_on_success = true,
      },
      terminal = {
        name = "Executor Terminal",
        prefix_name = "[Xmake]: ",
        split_size = 15,
        split_direction = "horizontal", ---@type "vertical"|"horizontal"
        focus = false,
        focus_auto_insert = true,
        auto_resize = true,
        close_on_success = true,
      },
      quickfix = {
        show = "only_on_error", ---@type "always"|"only_on_error"
        size = 15,
        position = "botright", ---@type "vertical"|"horizontal"|"leftabove"|"aboveleft"|"rightbelow"|"belowright"|"topleft"|"botright"
        close_on_success = true,
      },
      snacks = {
        position = "float",
        interactive = true,
      },
    },
  },

  vim.api.nvim_create_user_command('XmakeGenCompileDB', function()
    local handle = io.popen('xmake project -k compile_commands 2>&1')
    local result = handle:read("*a")
    handle:close()

    if result:match("error") then
      vim.notify("Failed: " .. result, vim.log.levels.ERROR)
    else
      vim.notify("Generated compile_commands.json!", vim.log.levels.INFO)
    end
  end, {}),

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "xmake.lua",
    callback = function()
      vim.fn.jobstart('xmake project -k compile_commands', {
        on_exit = function(_, code)
          if code == 0 then
            print("Updated compile_commands.json")
          end
        end
      })
    end
  }),

  -- Enable development mode
  dev_debug = true,

  files_path = vim.fn.stdpath("cache") .. "/xmake_", -- Fixed concatenation

  compile_command = {
    lsp = "clangd",
    dir = ".vscode", -- Ensure this dir exists
  },

  menu = {
    size = { width = 25, height = 20 },
    bottom_text_format = "%s(%s)",
    border_style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },

  debug = true, -- Temporarily enable for troubleshooting

  -- Get directory containing xmake.lua as root:
  work_dir = vim.fn.fnamemodify(vim.fn.findfile("xmake.lua", ".;"), ":p:h"),
}
