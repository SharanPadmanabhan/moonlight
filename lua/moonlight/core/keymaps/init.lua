-- moonlight.core.keymaps
-- Configures global and platform-specific keymaps.

local os = require("moonlight.utils.os")
local log = require("moonlight.utils.log")

-- Load common keymaps that are used across all platforms
require("moonlight.core.keymaps.common")

-- Determine the current platform (macOS, Linux/WSL, etc.)
local platform = os.is_mac() and "darwin"
  or (os.is_linux() or os.is_wsl()) and "other"
  or nil

-- Attempt to load platform-specific keymaps based on detected platform
if platform then
  local ok, err = pcall(require, "moonlight.core.keymaps." .. platform)
  if not ok then
    log.warn(("[keymaps] Failed to load '%s': %s"):format(platform, err))
  end
else
  log.info("[keymaps] Unknown OS platform: " .. os.uname().sysname)
end
