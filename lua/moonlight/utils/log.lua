-- moonlight.utils.log
-- Unified logging interface for Neovim user messages.

local M = {}

-- Fallback for Neovim < 0.9 where vim.log may not exist
local log_levels = vim.log and vim.log.levels
  or {
    INFO = "info",
    WARN = "warn",
    ERROR = "error",
  }

--- Print info message
--- @param msg string
function M.info(msg)
  vim.notify(msg, log_levels.INFO, { title = "Neovim" })
end

--- Print warning message
--- @param msg string
function M.warn(msg)
  vim.notify(msg, log_levels.WARN, { title = "Warning" })
end

--- Print error message
--- @param msg string
function M.error(msg)
  vim.notify(msg, log_levels.ERROR, { title = "Error" })
end

--- Show temporary message in command line (status line)
--- @param msg string
function M.status(msg)
  vim.api.nvim_echo({ { msg, "Normal" } }, false, {})
end

return M
