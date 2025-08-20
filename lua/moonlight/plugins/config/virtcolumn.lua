-- moonlight.plugins.config.virtcolumn
-- Configures VirtColumn to show a visual guide at a specific column in Neovim.

require("virt-column").setup({
  -- Enable the virtual column
  enabled = true,

  -- Character used for the virtual column
  char = "│",

  -- Column at which the virtual line appears
  virtcolumn = "80",

  -- Highlight group to use for the column
  highlight = "VirtColumn",
})
