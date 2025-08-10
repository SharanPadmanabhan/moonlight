-- moonlight
-- Initializes global settings, editor options, autocommands, plugins, LSP, and custom commands.

-- Load essential editor settings
require("moonlight.core.globals") -- Global variables and constants
require("moonlight.core.options") -- Editor options (e.g., line numbers, search settings)
require("moonlight.core.keymaps") -- Key mappings for commands and actions
require("moonlight.core.autocmds") -- Autocommands for automating tasks

-- Load and configure plugins
require("moonlight.plugins") -- Plugin setup (UI, Git, Treesitter, etc.)

-- Initialize LSP (Language Server Protocol)
require("moonlight.lsp") -- LSP setup and server management

-- Define custom commands
require("moonlight.core.commands") -- Custom commands and user-specific functionality
