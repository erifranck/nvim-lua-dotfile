return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Find files" },
    { "<leader>gf", function() require('telescope.builtin').git_files() end, desc = "Find git files" },
    { "<leader>fa", function() require('telescope.builtin').live_grep() end, desc = "Live grep" },
    { "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = "Help tags" },
    { "gr", function() require('telescope.builtin').lsp_references() end, desc = "LSP references" },
    { "gd", function() require('telescope.builtin').lsp_definitions() end, desc = "LSP definitions" },
  },
  config = function()
    local telescope = require("telescope")

    -- Keep your exact telescope configuration
    telescope.setup {
      defaults = {
        preview = {
          treesitter = false,
        },
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
        },
        git_files = {
          theme = "dropdown",
        },
        lsp_definitions = {
          theme = "cursor",
          layout_config = {
            cursor = {
              width = 0.8,
              height = 0.6,
            },
          },
          show_line = false,
        },
        lsp_references = {
          theme = "cursor",
          layout_config = {
            cursor = {
              width = 0.8,
              height = 0.6,
            },
          },
          show_line = false,
        },
      },
      extensions = {
        ["ui-select"] = {},
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        },
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
    }

    -- Load your extensions
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
  end,
}
