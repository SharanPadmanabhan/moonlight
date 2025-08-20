-- moonlight.plugins.ui
-- Configures polished UI plugins to improve Neovim’s look and feel with themes, status lines, and icons.

--- @type LazyPluginSpec[]
--- @diagnostic disable: different-requires
return {
  -- VSCodeDark colorscheme plugin using lush.nvim for theme definition
  {
    "SharanPadmanabhan/vscodedark.nvim",
    enabled = true,
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("vscodedark")
    end,
  },

  -- VirtColumn plugin for displaying a vertical column
  {
    "lukas-reineke/virt-column.nvim",
    enabled = true,
    event = "BufReadPost",
    config = function()
      return require("moonlight.plugins.config.virtcolumn")
    end,
  },

  -- Add subtle animations to common editor actions
  {
    "rachartier/tiny-glimmer.nvim",
    enabled = true,
    event = { "BufReadPre", "InsertEnter" },
    config = function()
      return require("moonlight.plugins.config.tiny-glimmer")
    end,
  },
}
