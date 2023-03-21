vim.cmd [[packadd packer.nvim]]

-- install dependencies
return require("packer").startup(function(use)
  use 'wbthomason/packer.nvim'
  use "NLKNguyen/papercolor-theme"
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      -- you'll need at least one of these
      -- {'nvim-telescope/telescope.nvim'},
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup()
    end,
  }
  use "lukas-reineke/lsp-format.nvim"
  use { 'neoclide/coc.nvim', branch = 'release' }

  -- navigation plugins
  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly'                  -- optional, updated every week. (see issue #1193)
  }
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "romgrk/barbar.nvim", wants = "nvim-tree/nvim-web-devicons" }
  use { "lukas-reineke/indent-blankline.nvim", event = "BufRead" }
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }


  use 'nvim-lualine/lualine.nvim'
  use { 'tamton-aquib/staline.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }

  use {
    'nvim-telescope/telescope-ui-select.nvim',
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
  }
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  -- development plugins
  use {
    'lewis6991/gitsigns.nvim',
  }
  use "fatih/vim-go"                          -- https://github.com/fatih/vim-go
  use "SirVer/ultisnips"                      -- https://github.com/sirver/UltiSnips
  use 'nvim-lua/completion-nvim'              -- completion plugin not use at same time with cmp
  use 'nvim-treesitter/completion-treesitter' -- completion plugin not use at same time with cmp
  use "hrsh7th/nvim-cmp"                      -- https://github.com/hrsh7th/nvim-cmp
  use "quangnguyen30192/cmp-nvim-ultisnips"   -- https://github.com/quangnguyen30192/cmp-nvim-ultisnips
  use "ray-x/cmp-treesitter"
  use "hrsh7th/cmp-buffer"
  use "dcampos/cmp-emmet-vim"
  use "hrsh7th/cmp-nvim-lsp"  -- https://github.com/hrsh7th/cmp-nvim-lsp
  use "neovim/nvim-lspconfig" -- https://github.com/neovim/nvim-lspconfig
  use "onsails/lspkind-nvim"  -- https://github.com/onsails/lspkind-nvim
  --  use "williamboman/nvim-lsp-installer" -- https://github.com/williamboman/nvim-lsp-installer deprecated
  --  new lsp installer
  use 'williamboman/mason.nvim'
  use "williamboman/mason-lspconfig.nvim"
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
  use "numToStr/Comment.nvim"                 -- https://github.com/numToStr/Comment.nvim
  use { "kylechui/nvim-surround", tag = "*" } -- https://github.com/kylechui/nvim-surround
  use "norcalli/nvim-colorizer.lua"
  -- debugger
  use "mfussenegger/nvim-dap"
  -- use { 'ldelossa/nvim-ide' }
  use({
    "dnlhc/glance.nvim",
    config = function()
      require('glance').setup({
        -- your configuration
      })
    end,
  })
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use {
    'ray-x/navigator.lua',
    requires = {
      { 'ray-x/guihua.lua',     run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
  }

  use {
    'goolord/alpha-nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
  }
  use { "smartpde/debuglog" }
  use({
    "jackMort/ChatGPT.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })
  -- game development
  use 'lommix/godot.nvim'
  -- install when start vim if not installed
  vim.cmd [[PackerInstall]]
end)
