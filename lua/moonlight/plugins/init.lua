-- moonlight.plugins
-- Initializes and configures all plugins for the Moonlight Neovim configuration.

local log = require("moonlight.utils.log")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed
--- @diagnostic disable-next-line: undefined-field
if not (vim.loop or vim.uv).fs_stat(lazypath) then
  local repository = "https://github.com/folke/lazy.nvim.git"
  local clone_command = {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    repository,
    lazypath,
  }

  log.info("Cloning lazy.nvim...")

  -- Run the git clone command and capture output
  local output = vim.fn.system(clone_command)
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { output, "WarningMsg" },
      { "\nPress any key to exit...", "Normal" },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  else
    log.info("lazy.nvim cloned successfully")
  end
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load and configure lazy.nvim
local ok, lazy = pcall(require, "lazy")
if not ok then
  log.error("Failed to load lazy.nvim")
  return
end

-- Setup lazy.nvim with plugin specifications and options
lazy.setup({
  spec = {
    -- Import plugins from the Moonlight configuration in recommended load order
    { import = "moonlight.plugins.ui" },
    { import = "moonlight.plugins.treesitter" },
    { import = "moonlight.plugins.lsp" },
    { import = "moonlight.plugins.git" },
    { import = "moonlight.plugins.editing" },
  },

  install = {
    -- Use the current colorscheme automatically during plugin installation
    colorscheme = { "auto" },
  },

  checker = {
    -- Enable automatic checking for plugin updates
    enabled = true,
  },

  ui = {
    -- Use no border for the lazy.nvim UI (instead of default rounded)
    border = "none",
  },
})
