-- Additional plugins not covered by other plugin files
return {
  "NLKNguyen/papercolor-theme",
  "BurntSushi/ripgrep",
  
  
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require('neoclip').setup()
    end,
  },
  
  "lukas-reineke/lsp-format.nvim",
  
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
    end
  },
  
  { "romgrk/barbar.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
  { "lukas-reineke/indent-blankline.nvim", event = "BufRead" },
  { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
  
  'nvim-lualine/lualine.nvim',
  { 'tamton-aquib/staline.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  
  'lewis6991/gitsigns.nvim',
  "fatih/vim-go",
  'nvim-lua/completion-nvim',
  'nvim-treesitter/completion-treesitter',
  "ray-x/cmp-treesitter",
  "hrsh7th/cmp-buffer",
  "dcampos/cmp-emmet-vim",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind-nvim",
  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/prettier.nvim',
  "numToStr/Comment.nvim",
  "norcalli/nvim-colorizer.lua",
  "mfussenegger/nvim-dap",
  
  {
    "dnlhc/glance.nvim",
    config = function()
      require('glance').setup({})
    end,
  },
  
  {
    'stevearc/aerial.nvim',
    config = function() 
      require('aerial').setup() 
    end
  },
  
  {
    "windwp/nvim-autopairs",
    config = function() 
      require("nvim-autopairs").setup {} 
    end
  },
  
  {
    'ray-x/navigator.lua',
    dependencies = {
      { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
  },
  
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  
  { "smartpde/debuglog" },
  
  {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
    config = function()
      require("claude-code").setup()
    end
  },
  {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
  },
  
  'lommix/godot.nvim'
}
