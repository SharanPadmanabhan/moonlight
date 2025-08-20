-- moonlight.plugins.editing
-- Configures essential editing plugins to streamline and enhance text manipulation.

--- @type LazyPluginSpec[]
--- @diagnostic disable: different-requires
return {
  -- Auto-pairs brackets, quotes, etc. in insert mode
  {
    "windwp/nvim-autopairs",
    enabled = true,
    event = "InsertEnter",
    config = function()
      require("moonlight.plugins.config.autopairs")
    end,
  },

  -- Highlights nested brackets and delimiters with rainbow colors
  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = true,
    event = "BufReadPost",
    config = function()
      require("moonlight.plugins.config.rainbow-delimiters")
    end,
  },

  -- Automatically close and rename HTML/JSX tags using Treesitter
  {
    "windwp/nvim-ts-autotag",
    enabled = true,
    event = "InsertEnter",
    ft = { "html", "xml", "tsx", "jsx", "javascript", "typescript" }, -- Only for tag-based filetypes
    config = function()
      require("moonlight.plugins.config.autotag")
    end,
  },

  -- Smart comment toggling for code (supports line/block comments)
  {
    "numToStr/Comment.nvim",
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("moonlight.plugins.config.comment")
    end,
  },

  -- Highlight and search TODO, FIXME, HACK, etc. comments in code
  {
    "folke/todo-comments.nvim",
    enabled = true,
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("moonlight.plugins.config.todo-comments")
    end,
  },

  -- Display Indendation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    event = "BufReadPost",
    config = function()
      require("moonlight.plugins.config.indent-blankline")
    end,
  },
}
