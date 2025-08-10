-- moonlight.utils.os
-- A minimal, platform-focused OS utility module for Neovim configuration.

local M = {}

-- Neovim 0.10+ uses vim.uv; fallback to vim.loop for older versions
local uv = vim.uv or vim.loop

-- Fallback implementation for os_uname (used if not available in uv)
local function fallback_uname()
  local function safe_popen(cmd)
    local handle = io.popen(cmd)
    if not handle then
      return "unknown"
    end

    local result = handle:read("*l") or "unknown"
    handle:close()
    return result
  end

  return {
    sysname = safe_popen("uname -s"),
    release = safe_popen("uname -r"),
    version = safe_popen("uname -v"),
    machine = safe_popen("uname -m"),
    nodename = safe_popen("uname -n"),
  }
end

-- Use uv.os_uname() if available, fallback otherwise
local uname = (uv.os_uname and uv.os_uname()) or fallback_uname()

-- Normalize system name for comparison
local sysname = uname.sysname:lower()

--- Returns the full uname info table
--- @return table
function M.uname()
  return uname
end

--- Returns the normalized platform name: "mac", "linux", "windows", or raw sysname
--- @return string
function M.name()
  if M.is_mac() then
    return "mac"
  elseif M.is_linux() then
    return "linux"
  elseif M.is_windows() then
    return "windows"
  else
    return sysname
  end
end

--- Checks if the OS is macOS (Darwin)
--- @return boolean
function M.is_mac()
  return sysname == "darwin"
end

--- Checks if the OS is Linux
--- @return boolean
function M.is_linux()
  return sysname == "linux"
end

--- Checks if the OS is Windows (Windows)
--- @return boolean
function M.is_windows()
  return sysname == "windows"
end

--- Checks if the OS is a Unix variant (macOS, Linux, BSD)
--- @return boolean
function M.is_unix()
  return M.is_mac() or M.is_linux() or M.is_bsd()
end

--- Checks if the OS is a BSD variant
--- @return boolean
function M.is_bsd()
  return sysname:find("bsd") ~= nil
end

--- Detects if running under Windows Subsystem for Linux (WSL)
--- @return boolean
function M.is_wsl()
  if not M.is_linux() then
    return false
  end
  local f = io.open("/proc/version", "r")
  if not f then
    return false
  end
  local content = f:read("*a") or ""
  f:close()
  return content:lower():find("microsoft") ~= nil
end

--- Returns the machine architecture (e.g. "x86_64", "arm64")
--- @return string
function M.arch()
  return uname.machine or "unknown"
end

--- Returns the OS kernel release (e.g. "6.8.0-rc5")
--- @return string
function M.kernel()
  return uname.release or "unknown"
end

--- Returns the system hostname
--- @return string
function M.hostname()
  if uv.os_gethostname then
    return uv.os_gethostname() or "unknown"
  end

  -- Fallback for Neovim < 0.10
  local f = io.popen("hostname")
  if not f then
    return "unknown"
  end
  local result = f:read("*l") or "unknown"
  f:close()
  return result
end

return M
