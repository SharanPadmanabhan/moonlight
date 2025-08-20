-- moonlight.plugins.config.autotag
-- Configures nvim-ts-autotag plugin for automatic HTML/XML tag management.

require("nvim-ts-autotag").setup({
  opts = {
    -- Enable automatic closing of tags like <div> -> </div>
    enable_close = true,

    -- Enable automatic renaming of paired tags when one is edited
    enable_rename = true,

    -- Enable auto-closing tags when typing </
    enable_close_on_slash = true,
  },
})
