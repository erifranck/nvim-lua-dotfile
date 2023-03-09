-- Coc configuration for format
require "coc-setting"
require "nvim-cmp"
require "ide-setting"
require "glance-settings"
require "aerial-settings"

vim.cmd [[packadd packer.nvim]]

-- keymaps leader key
local opt = vim.opt
vim.g.mapleader = ","
Map = vim.keymap.set

Nmap = function (key, cmd, conf)
	Map('n', key, cmd, conf)
end

-- neovim settings
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.tabstop = 2 
opt.shiftwidth = 2 
opt.softtabstop = 0 
opt.expandtab = true
opt.autoindent = true

-- Theme
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd [[colorscheme PaperColor]]


-- keymaps telescope and theme
local builtin = require ('telescope.builtin')
local telescope = require("telescope")

telescope.setup {
  pickers = {
	  find_files = {
		  theme = "dropdown",
	  },
	  git_files = {
		  theme = "dropdown",
	  }
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


telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("ui-select")

Nmap('<leader>ff', builtin.find_files, {})
Nmap('<leader>gf', builtin.git_files, {})
Nmap('<leader>fa', builtin.live_grep, {})

-- Toggle terminal keymaps

local ToggleTerminal = require('toggleterm')

ToggleTerminal.setup {
  size = 25,
  open_mapping = [[<c-,>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true,
  shell = vim.o.shell,
  terminal_mappings = true,
  insert_mappings = true,
   winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}


function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

Nmap('<leader>tg', "<cmd>lua _lazygit_toggle()<CR>", {silent = true, noremap = true})
Nmap('<leader>tt', "<cmd>ToggleTerm<CR>", {silent = true, noremap = true})

-- Autoformat code 
require("lsp-format").setup {
    typescript = {
        tab_width = function()
            return vim.opt.shiftwidth:get()
        end,
    },
    yaml = { tab_width = 2 },
}

local prettier = {
    formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:tab_width}]],
    formatStdin = true,
}

require("lspconfig").efm.setup {
    on_attach = require("lsp-format").on_attach,
    init_options = { documentFormatting = true },
    settings = {
        languages = {
            typescript = { prettier },
            yaml = { prettier },
        },
    },
}

require'lspconfig'.pyright.setup{
	on_attach=require'completion'.on_attach
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Navigation keymaps
require("nvim-tree").setup()

Nmap('<leader>b', '<cmd>NvimTreeFindFileToggle<CR>', {silent = true, noremap = true})
Nmap('<F3>', '<cmd>tabprevious<CR>', {silent = true, noremap = true})
Nmap('<F2>', '<cmd>tabNext<CR>', {silent = true, noremap = true})

require('navigator').setup()
require("nvim-surround").setup({
  -- Configuration here, or leave empty to use defaults
})

-- tab setting
local lualine = require('lualine')
lualine.setup {
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}


require('gitsigns').setup()
-- ide commands
vim.keymap.set('n', '<leader>fe', '<cmd>lua require("ide.components.explorer").toggle()<CR>')
vim.keymap.set('n', '<leader>ww', '<cmd>Workspace<CR>')

require('alpha').setup(require('alpha.themes.startify').config)

-- install dependencies
return require("packer").startup(function (use)

	use 'wbthomason/packer.nvim'
	use "NLKNguyen/papercolor-theme"
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = {{'nvim-lua/plenary.nvim'}}
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
	use {'neoclide/coc.nvim', branch = 'release'}
	use 'nvim-lua/completion-nvim'
	-- navigation plugins
	use {"akinsho/toggleterm.nvim", tag = '*', config = function()
	    require("toggleterm").setup()
	end}
	use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
	    'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
	use { "romgrk/barbar.nvim", wants = "nvim-tree/nvim-web-devicons"}
	use 'nvim-lualine/lualine.nvim'
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
	use "fatih/vim-go"                        -- https://github.com/fatih/vim-go
	use "SirVer/ultisnips"                    -- https://github.com/sirver/UltiSnips
	use "hrsh7th/cmp-nvim-lsp"                -- https://github.com/hrsh7th/cmp-nvim-lsp
	use "hrsh7th/nvim-cmp"                    -- https://github.com/hrsh7th/nvim-cmp
	use "neovim/nvim-lspconfig"               -- https://github.com/neovim/nvim-lspconfig
	use "onsails/lspkind-nvim"                -- https://github.com/onsails/lspkind-nvim
	use "quangnguyen30192/cmp-nvim-ultisnips" -- https://github.com/quangnguyen30192/cmp-nvim-ultisnips
	use "williamboman/nvim-lsp-installer"     -- https://github.com/williamboman/nvim-lsp-installer
	use "numToStr/Comment.nvim"               -- https://github.com/numToStr/Comment.nvim
	use { "kylechui/nvim-surround", tag = "*" }  -- https://github.com/kylechui/nvim-surround
	use { 'ldelossa/nvim-ide' }
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
      { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
  }

  use {
    'goolord/alpha-nvim',
  }
	-- install when start vim if not installed
	vim.cmd [[PackerInstall]]
end)
