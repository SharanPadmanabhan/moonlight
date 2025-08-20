-- moonlight.plugins.config.tiny-glimmer
-- Configures tiny-glimmer to show subtle animations for text changes.

require("tiny-glimmer").setup({
  -- Enable the plugin globally
  enabled = true,

  -- How often (in milliseconds) the screen refreshes during animations
  refresh_interval_ms = 1,

  -- Override animations for specific operations
  overwrite = {
    -- Highlight when yanking (copying) text
    yank = {
      enabled = true,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "IncSearch",
          max_duration = 300,
          min_duration = 300,
        },
      },
    },

    -- Highlight pasted text (after p/P)
    paste = {
      enabled = true,
      default_animation = {
        name = "reverse_fade",
        settings = {
          max_duration = 300,
          min_duration = 300,
        },
      },
    },

    -- Highlight text that was just undone
    undo = {
      enabled = true,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "DiffDelete",
          max_duration = 300,
          min_duration = 300,
        },
      },
    },

    -- Highlight text that was just redone
    redo = {
      enabled = true,
      default_animation = {
        name = "fade",
        settings = {
          from_color = "DiffAdd",
          max_duration = 300,
          min_duration = 300,
        },
      },
    },
  },
})
