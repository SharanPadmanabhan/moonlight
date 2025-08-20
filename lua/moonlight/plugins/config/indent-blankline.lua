-- moonlight.plugins.config.indent-blankline
-- Configures indent-blankline plugin and custom rainbow delimiter highlights.

-- Define a list of custom highlight groups for rainbow delimiters
local highlight = {
  "RainbowDelimiterYellow",
  "RainbowDelimiterGreen",
  "RainbowDelimiterBlue",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

-- Import the hooks module from indent-blankline (ibl)
local hooks = require("ibl.hooks")

-- Register a hook to set up custom highlight groups when the highlighting setup event fires
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#e8ba36" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#54a857" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#359ff4" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#6e7ed9" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#179387" })
end)

-- Configure and setup indent-blankline (ibl) plugin
require("ibl").setup({
  indent = {
    -- Set the character used to display indentation guides
    char = "▏",
  },

  scope = {
    -- Use the same rainbow highlight groups for the scope highlights
    highlight = highlight,

    -- Disable showing underline
    show_start = false,
    show_end = false,
  },
})

-- Register a hook to highlight scopes using extmarks (built-in ibl method)
hooks.register(
  hooks.type.SCOPE_HIGHLIGHT,
  hooks.builtin.scope_highlight_from_extmark
)
