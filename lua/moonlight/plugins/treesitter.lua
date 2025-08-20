-- moonlight.plugins.treesitter
-- Configures Treesitter for superior syntax parsing and code highlighting.

--- @type LazyPluginSpec[]
--- @diagnostic disable: different-requires
return {
  -- Primary Treesitter plugin for syntax-aware code features
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("moonlight.plugins.config.treesitter")
    end,
  },

  -- Shows the current code context (e.g. function/class name) above the cursor
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("moonlight.plugins.config.treesitter-context")
    end,
  },
}
