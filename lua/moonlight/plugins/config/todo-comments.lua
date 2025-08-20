-- moonlight.plugins.config.todo-comments
-- Configures todo-comments to highlight, search, and manage annotations
-- like TODO, FIX, etc.

require("todo-comments").setup({
  -- Enable signs in the sign column
  signs = true,

  -- Set priority of the signs
  sign_priority = 8,

  -- Define custom keywords and their behavior
  keywords = {
    FIX = {
      icon = " ",
      color = "error",
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
    },
    TODO = {
      icon = " ",
      color = "info",
    },
    HACK = {
      icon = " ",
      color = "warning",
    },
    WARN = {
      icon = " ",
      color = "warning",
      alt = { "WARNING", "XXX" },
    },
    PERF = {
      icon = "󱎫 ",
      alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
    },
    NOTE = {
      icon = " ",
      color = "hint",
      alt = { "INFO" },
    },
    TEST = {
      icon = "󱓞 ",
      color = "test",
      alt = { "TESTING", "PASSED", "FAILED" },
    },
  },

  -- Set GUI style for highlights
  gui_style = {
    -- No special foreground style
    fg = "NONE",

    -- Bold background highlight
    bg = "BOLD",
  },

  -- Merge custom keywords with default ones
  merge_keywords = true,

  -- Highlight settings
  highlight = {
    -- Highlight multiline comments
    multiline = true,

    -- Match all lines
    multiline_pattern = "^.",

    -- Context lines to include
    multiline_context = 10,

    -- No prefix highlight
    before = "",

    -- Highlight the keyword with surrounding characters
    keyword = "wide",

    -- Highlight trailing characters with foreground color
    after = "fg",

    -- Pattern to match keywords followed by `:`
    pattern = [[.*<(KEYWORDS)\s*:]],

    -- Only highlight inside comments
    comments_only = true,

    -- Ignore lines longer than this
    max_line_len = 400,

    -- No filetype exclusions
    exclude = {},
  },

  -- Custom colors for each keyword category
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" },
  },

  -- Configure search behavior
  search = {
    -- Use ripgrep
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },

    -- Pattern to match keywords in search
    pattern = [[\b(KEYWORDS):]],
  },
})
