-- Keymaps
local map = vim.keymap.set

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<F2>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<F3>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<C-w>", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Neo-tree
map("n", "<leader>b", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus file explorer" })

-- Telescope keymaps are defined in lua/plugins/telescope.lua

-- Terminal
map("n", "<C-,>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<cr>", { desc = "Lazygit" })

-- LSP (gd and gr are now handled by Telescope in lua/plugins/telescope.lua)
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<C-f>", vim.lsp.buf.format, { desc = "Format" })