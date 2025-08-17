return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup()
    end,
  },
  
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    main = "ibl",
    config = true,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = true,
  },

  -- Color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require('colorizer').setup({
        'css',
        'javascript',
        'svelte',
        'lua',
        html = {
          mode = 'foreground',
        }
      })
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },

  -- Debug log
  {
    "smartpde/debuglog",
    cmd = "DebugLog",
    config = function()
      require("debuglog").setup({
        log_to_console = true,
        log_to_file = false,
        time_hl_group = "Comment",
      })
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = "BufRead",
    config = true,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = true,
  },

  -- Focus mode
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    config = true,
  },
}