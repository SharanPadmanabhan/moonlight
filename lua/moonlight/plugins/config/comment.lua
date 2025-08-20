-- moonlight.plugins.config.comment
-- Configures Comment.nvim for toggling line/block comments in normal and
-- visual modes.

require("Comment").setup({
  -- Adds a space between the comment symbol and the line content
  padding = true,

  -- Keeps the cursor in place after commenting
  sticky = true,

  -- Lines matching this will be ignored when commenting (e.g., "^$")
  ignore = nil,

  -- Toggle mappings (NORMAL mode)
  toggler = {
    line = "gcc", -- Line comment toggle
    block = "gbc", -- Block comment toggle
  },

  -- Operator-pending mappings (NORMAL and VISUAL mode)
  opleader = {
    line = "gc", -- Line comment operator
    block = "gb", -- Block comment operator
  },

  -- Extra mappings
  extra = {
    above = "gcO", -- Add comment on the line above
    below = "gco", -- Add comment on the line below
    eol = "gcA", -- Add comment at the end of the current line
  },

  -- Enables key mappings
  mappings = {
    basic = true, -- Enables basic mappings: `gcc`, `gbc`, `gc{motion}`, etc.
    extra = true, -- Enables extra mappings: `gcO`, `gco`, `gcA`
  },

  -- Optional function to call before (un)commenting
  pre_hook = nil,

  -- Optional function to call after (un)commenting
  post_hook = nil,
})
