-- moonlight.plugins.config.treesitter
-- Configures nvim-treesitter for advanced syntax highlighting, selection,
-- and indentation.

local treesitter = require("nvim-treesitter")

-- Setup Treesitter with custom install directory
treesitter.setup({
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- List of languages to install parsers for
local languages = {
  "bash",
  "c",
  "cpp",
  "objc",
  "cmake",
  "css",
  "gitignore",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

-- Install parsers for the specified languages
treesitter.install(languages, { force = false, summary = false })

-- Autocommand to configure Treesitter features per filetype
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterConfig", { clear = true }),
  pattern = languages,
  desc = "Enable Treesitter highlighting, folding, and indentation per language",
  callback = function(args)
    local buffer = args.buf

    -- Enable Treesitter highlighting unless file is too big
    local max_filesize = 100 * 1024
    local filepath = vim.api.nvim_buf_get_name(buffer)
    local filesize = filepath ~= "" and vim.fn.getfsize(filepath) or 0

    if filesize < max_filesize then
      vim.treesitter.start(buffer)
    end

    -- Use Treesitter folding
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    -- Use Treesitter indentation
    vim.bo[buffer].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})
