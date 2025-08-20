-- moonlight.plugins.config.rainbow-delimiters
-- Configures rainbow-delimiters plugin, which provides rainbow-colored
-- brackets/parentheses for different levels of nesting.

require("rainbow-delimiters.setup").setup({
  -- Strategy determines how delimiters are applied per filetype.
  -- You can define a global default strategy and override it per filetype.
  strategy = {
    -- Global strategy used by default for all filetypes
    [""] = "rainbow-delimiters.strategy.global",

    -- Override with a local strategy for Vimscript files
    vim = "rainbow-delimiters.strategy.local",
  },

  -- Query specifies the Tree-sitter query to use per filetype.
  -- This tells the plugin which parser rules to use for detecting delimiters.
  query = {
    -- Default query for most filetypes (standard delimiter matching)
    [""] = "rainbow-delimiters",
  },

  -- Priority determines the highlight priority for delimiters per filetype.
  -- Higher priority means it overrides other highlight groups.
  priority = {
    -- Default priority level for most filetypes
    [""] = 110,

    -- Override priority for Lua files (higher value means higher priority)
    lua = 210,
  },

  -- Highlight groups to apply for nested delimiters.
  -- These highlight groups will be used cyclically for each nesting level.
  highlight = {
    "RainbowDelimiterYellow",
    "RainbowDelimiterGreen",
    "RainbowDelimiterBlue",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  },
})

-- Create an autocmd that triggers on both BufReadPost and ColorScheme events
vim.api.nvim_create_autocmd({ "BufReadPost", "ColorScheme" }, {
  group = vim.api.nvim_create_augroup("TSRainbowHighlight", { clear = true }),
  desc = "Apply rainbow delimiter highlight groups after buffer loads or when the color scheme changes",
  callback = function()
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#e8ba36" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#54a857" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#359ff4" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#6e7ed9" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#179387" })
  end,
})
