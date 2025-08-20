-- moonlight.plugins.config.autopairs
-- Configures nvim-autopairs plugin with custom settings for autopair behavior.

require("nvim-autopairs").setup({
  -- disable in macros
  disable_in_macro = true,

  -- enable in visual block mode
  disable_in_visualblock = false,

  -- disable in replace mode
  disable_in_replace_mode = true,

  -- characters after which autopairs won’t trigger
  ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

  -- jump over closing bracket if next char is same
  enable_moveright = true,

  -- enable inside quotes
  enable_afterquote = true,

  -- check for brackets on current line
  enable_check_bracket_line = true,

  -- allow brackets inside quotes
  enable_bracket_in_quote = true,

  -- enable abbreviations (for faster typing)
  enable_abbr = false,

  -- create undo breakpoints after pairs
  break_undo = true,

  -- enable treesitter integration (better syntax awareness)
  check_ts = false,

  -- map <CR> to autopairs behavior (auto newline between brackets)
  map_cr = true,

  -- map backspace to autopairs (delete pairs)
  map_bs = true,

  -- map ctrl-h for smart delete (like VSCode backspace)
  map_c_h = false,

  -- map ctrl-w for deleting pairs (like VSCode ctrl+w)
  map_c_w = false,
})
