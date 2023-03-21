require('mason').setup({
  -- your configuration
})
require('mason-lspconfig').setup({
  -- your configuration
  ensure_installed = {
    "html",
    "svelte",
    "rome",
  },
  automatic_instalation = true
})
