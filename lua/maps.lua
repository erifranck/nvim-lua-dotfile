-- keymaps leader key
local opt = vim.opt
vim.g.mapleader = ","
Map = vim.keymap.set

Nmap = function(key, cmd, conf)
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
vim.o.completeopt = "menuone,noselect"
vim.encoding = "utf-8"

-- Theme
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme "catppuccin"


-- keymaps telescope and theme
local builtin = require('telescope.builtin')
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
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

require("twilight").setup {
  dimming = {
    alpha = 0.25, -- amount of dimming
    -- we try to get the foreground from the highlight groups or fallback color
    color = { "Normal", "#ffffff" },
    term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
    inactive = false,    -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 30,          -- amount of lines we will try to show around the current line
  treesitter = true,     -- use treesitter when available for the filetype
  -- treesitter is used to automatically expand the visible text,
  -- but you can further control the types of nodes that should always be fully expanded
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
  },
  exclude = {},
}
Nmap('<leader>tg', "<cmd>lua _lazygit_toggle()<CR>", { silent = true, noremap = true })
Nmap('<leader>tt', "<cmd>ToggleTerm<CR>", { silent = true, noremap = true })


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Navigation keymaps
require("nvim-tree").setup()

Nmap('<leader>b', '<cmd>NvimTreeFindFileToggle<CR>', { silent = true, noremap = true })
Nmap('<F3>', '<cmd>BufferNext<CR>', { silent = true, noremap = true })
Nmap('<F2>', '<cmd>BufferPrevious<CR>', { silent = true, noremap = true })
Nmap('<leader>x', '<cmd>BufferCloseAllButCurrent<CR>', { silent = true, noremap = true })
Nmap('<C-w>', '<cmd>BufferClose<CR>', { silent = true, noremap = true })

require('navigator').setup()
require("nvim-surround").setup({
  -- Configuration here, or leave empty to use defaults
})


require('gitsigns').setup()

require('alpha').setup(require('alpha.themes.startify').config)
