-- moonlight.plugins.config.treesitter-context
-- Configures nvim-treesitter-context to display the current code context at
-- the top of the window.

require("treesitter-context").setup({
  -- Enable this plugin.
  enable = true,

  -- Enable multiwindow support.
  multiwindow = true,

  -- How many lines the window should span.
  max_lines = 0,

  -- Minimum editor window height to enable context.
  min_window_height = 0,

  -- Display line numbers
  line_numbers = true,

  -- Maximum number of lines to show for a single context.
  multiline_threshold = 20,

  -- Which context lines to discard if `max_lines` is exceeded.
  trim_scope = "outer",

  --- Line used to calculate context.
  mode = "topline",

  -- Separator between context and content.
  separator = "",

  -- Z-Index of the window.
  zindex = 20,

  --- Callback when attaching.
  on_attach = nil,
})
