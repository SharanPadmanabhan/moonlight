# Moonlight — A Minimal & Modern Neovim Configuration

**Moonlight** is a thoughtfully crafted Neovim setup designed for developers who crave a minimal yet powerful editing experience. Built with Lua and optimized for performance, it's everything you need—and nothing you don't.

## 📚 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
  - [Installing Neovim](#-installing-neovim)
- [Installation](#-installation)
- [Directory Structure](#-directory-structure)
- [Configuration Overview](#-configuration-overview)
- [Plugin Management](#-plugin-management)
  - [Adding a Plugin](#-adding-a-plugin)
  - [Example: Adding `lualine`](#-example-adding-lualine)
- [Customizing Core Settings](#-customizing-core-settings)
  - [Example: Toggle Relative Line Numbers](#-example-toggle-relative-line-numbers)
- [Working with LSP](#-working-with-lsp)
  - [What's Included](#-whats-included)
  - [Example: Add `pyright` Support](#-example-add-pyright-support)
- [Minimal Plugin Philosophy](#-minimal-plugin-philosophy)
  - [Key Enhancements](#-key-enhancements)
  - [Why Minimal?](#-why-minimal)
- [Core Plugins at a Glance](#-core-plugins-at-a-glance)
- [License](#-license)
- [Contributing](#-contributing)

## ✨ Features

- **Minimal by design** — no unnecessary bloat, just the essentials
- **Modern Lua-based setup** — no Vimscript nightmares
- **Snappy performance** — lazy-loaded plugins and clean startup
- **Modular architecture** — easy to extend, modify, and maintain
- **Native LSP integration** — out-of-the-box language server support

## 📦 Requirements

Make sure you have the following installed:

- **Neovim** ≥ `v0.8.0`
- **Git**

### 📥 Installing Neovim

- **macOS**:

  ```bash
  brew install neovim
  ```

- **Debian/Ubuntu**:

  ```bash
  sudo apt install neovim
  ```

- **Windows**:
  Install via [winget](https://github.com/microsoft/winget-cli) or [Chocolatey](https://chocolatey.org/packages/neovim)

## 🚀 Installation

Clone the repo into your Neovim config directory:

```bash
git clone https://github.com/your-username/moonlight ~/.config/nvim
```

Launch Neovim:

```bash
nvim
```

Moonlight will take care of the rest ✨

## 📁 Directory Structure

```text
~/.config/nvim
├── init.lua                   # Entry point
├── after/                     # Overrides loaded after plugins
│   ├── ftplugin/              # Filetype-specific overrides
│   └── plugin/                # Plugin-specific overrides
├── lua/
│   └── moonlight/
│       ├── core/              # Editor core settings (keymaps, options, autocmds)
│       ├── plugins/           # Plugin declarations and configs
│       │   ├── config/        # Separate plugin configuration files (optional)
│       │   ├── ui.lua
│       │   ├── lsp.lua
│       │   └── ...            # More plugin categories (editing, git, treesitter)
│       ├── lsp/               # LSP management (mason, servers, handlers)
│       └── utils/             # Utility functions
├── README.md
└── LICENSE
```

## 🛠 Configuration Overview

Moonlight splits its config into clear, easy-to-digest modules:

- **`core/`** — Editor options, keymaps, and autocommands
- **`plugins/`** — Plugin declarations by category
- **`plugins/config/`** — Separate config files for complex plugins
- **`lsp/`** — Mason-based LSP management and server configs

## 🔌 Plugin Management

Moonlight uses the awesome [`lazy.nvim`](https://github.com/folke/lazy.nvim) plugin manager — optimized for fast startup and lazy loading.

### ➕ Adding a Plugin

1. Find the right plugin category (e.g. `ui.lua`, `git.lua`, `lsp.lua`)

2. Add the plugin spec to the returned table. For example in `git.lua`:

   ```lua
   return {
     {
       "lewis6991/gitsigns.nvim",
       event = "BufReadPre",
       config = require("moonlight.plugins.config.gitsigns")
     },
   }
   ```

3. (Optional) Create the config file:
   `lua/moonlight/plugins/config/gitsigns.lua`

   ```lua
   return function()
     require("gitsigns").setup()
   end
   ```

4. Restart Neovim — done.

### 📎 Example: Adding `lualine`

1. In `plugins/ui.lua`:

   ```lua
   return {
     {
       "nvim-lualine/lualine.nvim",
       event = "VeryLazy",
       config = require("moonlight.plugins.config.lualine"),
     },
   }
   ```

2. In `plugins/config/lualine.lua`:

   ```lua
   return function()
     require("lualine").setup({
       options = {
         theme = "auto",
         section_separators = "",
         component_separators = "",
       },
     })
   end
   ```

## 🧠 Customizing Core Settings

The `core/` folder is your sandbox for fine-tuning Moonlight.

- **Options** → `core/options.lua`
- **Keymaps** → `core/keymaps.lua`
- **Autocmds** → `core/autocmds.lua`

### 🧩 Example: Toggle Relative Line Numbers

```lua
vim.keymap.set("n", "<leader>r", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true })
```

## 💬 Working with LSP

Moonlight embraces Neovim’s built-in LSP. Everything is modular and extensible.

### 🧰 What's included

- Automatic server installation via `mason.nvim`
- Custom handlers & capabilities
- Optional per-server config files

### ➕ Example: Add `pyright` Support

1. Add `pyright` to `ensure_installed` in `lsp/init.lua`
2. Create a config file:
   `lsp/servers/pyright.lua`

   ```lua
   return {
     settings = {
       python = {
         analysis = {
           typeCheckingMode = "strict",
         },
       },
     },
   }
   ```

## 🧘 Minimal Plugin Philosophy

Moonlight isn’t about having fewer features — it’s about **choosing the right tools** and letting Neovim’s native power shine through.

Rather than bundling dozens of plugins, Moonlight focuses on a **core set of purpose-built tools** that enhance productivity without overcomplicating the setup.

### 🔧 Key Enhancements

- **LSP-first**: Uses Neovim’s **native LSP** — managed via [`mason.nvim`](https://github.com/williamboman/mason.nvim) and [`mason-lspconfig`](https://github.com/williamboman/mason-lspconfig.nvim)
- **Lazy loading**: Every plugin is loaded only when it’s actually needed — thanks to [`lazy.nvim`](https://github.com/folke/lazy.nvim)
- **Treesitter**: Fast, accurate syntax highlighting and code understanding using [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)
- **Autocompletion**: Fast and minimal with [`blink.cmp`](https://github.com/Saghen/blink.cmp), leveraging Neovim’s built-in LSP for intelligent suggestions
- **Minimal UI Polish**: Just the essentials — statusline via [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim), git signs via [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)

### 💡 Why Minimal?

- **Fast startup** and low memory usage
- **Easier maintenance** — fewer breaking updates or config rewrites
- **Less noise** — just you, your code, and your keyboard

You can still easily extend Moonlight — just follow the modular plugin setup and add only what you need.

## 🔗 Core Plugins at a Glance

| Category       | Plugin                                                                                                                                 | Purpose                         |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| Plugin Manager | [`lazy.nvim`](https://github.com/folke/lazy.nvim)                                                                                      | Efficient plugin loading        |
| LSP            | [`mason.nvim`](https://github.com/williamboman/mason.nvim) + [`mason-lspconfig`](https://github.com/williamboman/mason-lspconfig.nvim) | LSP installation & integration  |
| UI             | [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)                                                                         | Clean statusline                |
| Git            | [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)                                                                          | Git integration in gutter       |
| Completion     | [`blink.cmp`](https://github.com/Saghen/blink.cmp)                                                                                     | Subtle autocompletion UI        |
| Syntax         | [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)                                                                | Syntax parsing and highlighting |

## 📄 License

Moonlight is released under the [GPL-3.0 License](LICENSE).

## 🤝 Contributing

Contributions are welcome! Feel free to fork the repository, submit issues, or create pull requests.
