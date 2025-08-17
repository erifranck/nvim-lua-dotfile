-- Options
local opt = vim.opt

opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0
opt.expandtab = true
opt.autoindent = true
opt.completeopt = "menuone,noselect"
opt.termguicolors = true
opt.background = "dark"

-- Clipboard
vim.cmd [[set clipboard+=unnamedplus]]

-- Encoding
vim.encoding = "utf-8"