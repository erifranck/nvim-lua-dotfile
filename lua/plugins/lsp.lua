return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",
          "svelte",
          "ts_ls", -- TypeScript/JavaScript
        },
        automatic_installation = true
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim", "cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      
      local capabilities = cmp_nvim_lsp.default_capabilities()
      
      -- Setup LSP servers
      local servers = { "html", "svelte", "ts_ls" }
      
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end
      
      -- Auto format on save
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    end,
  },
}