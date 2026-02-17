-- Bootstrap lazy.nvim and setup configuration
require("config.lazy")

-- Load basic configuration
require("config.options")
require("config.keymaps")

-- Load environment variables (optional)
pcall(require, "env")