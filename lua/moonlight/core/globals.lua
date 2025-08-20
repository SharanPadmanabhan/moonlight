-- moonlight.core.globals
-- Defines global variables used across the Moonlight Neovim configuration.

-- Global Leader Keys
vim.g.mapleader = " " -- Space as the main leader key
vim.g.maplocalleader = " " -- Space as the local leader key

-- Disable netrw (replaced by modern file explorers)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- GUI Support
if vim.fn.has("gui_running") == 1 then
  -- Set GUI font and linespace
  vim.opt.guifont = "JetBrainsMonoNL Nerd Font:h15.5:"
  vim.opt.linespace = 11
  -- vim.opt.guifont = "Twilio Sans Mono:h15.5"
  -- vim.opt.linespace = 10

  -- Save the default guifont in a global variable if not already set
  if vim.g._default_guifont == nil then
    vim.g._default_guifont = vim.opt.guifont
  end
end
