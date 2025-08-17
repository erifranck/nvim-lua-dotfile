return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      { "<C-,>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>tg", "<cmd>lua _lazygit_toggle()<cr>", desc = "Lazygit", silent = true },
      { "<leader>tt", "<cmd>lua _claude_terminal_toggle()<cr>", desc = "Claude Terminal", silent = true },
    },
    config = function()
      require("toggleterm").setup({
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
          name_formatter = function(term)
            return term.name
          end
        },
      })

      -- Terminal keymaps function
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

      -- Lazygit terminal
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      -- Claude terminal
      local claude_terminal = Terminal:new({
        cmd = "claude code",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
          width = 120,
          height = 30,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
      })

      function _claude_terminal_toggle()
        claude_terminal:toggle()
      end
    end,
  },
}