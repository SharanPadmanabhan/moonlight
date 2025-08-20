-- moonlight.core.options
-- Configures Neovim editor options for the Moonlight Neovim configuration.

-- UI & Visuals
vim.opt.background = "dark" -- Dark Background
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = false -- Disable line wrapping
vim.opt.scrolloff = 5 -- Keep 5 lines above/below cursor
vim.opt.signcolumn = "yes:1" -- Always show sign column
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.showmatch = true -- Highlight matching bracket
vim.opt.matchtime = 2 -- Delay (in tenths of a second) for match
vim.opt.cmdheight = 1 -- Height of command line
vim.opt.showmode = false -- Hide current mode
vim.opt.laststatus = 3 -- Global statusline
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.winblend = 0 -- Transparency for floating windows
vim.opt.pumheight = 15 -- Max number of items in popup menu
vim.opt.pumblend = 0 -- Transparency for popup menu
vim.opt.conceallevel = 0 -- Show concealed text normally
vim.opt.concealcursor = "" -- Don't conceal text in any mode
vim.opt.lazyredraw = true -- Redraw only when necessary
vim.opt.synmaxcol = 200 -- Max column for syntax highlighting
vim.opt.ruler = false -- Turn off ruler

-- Tabs & Indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- 1 tab = 2 spaces
vim.opt.shiftwidth = 2 -- Indent width = 2 spaces
vim.opt.softtabstop = 2 -- Insert/delete tab as 2 spaces
vim.opt.smartindent = true -- Smart indentation on new lines
vim.opt.autoindent = true -- Copy indent from current line

-- Searching
vim.opt.ignorecase = true -- Case-insensitive search...
vim.opt.smartcase = true -- ...unless capital letters used
vim.opt.hlsearch = true -- Highlight all search matches
vim.opt.incsearch = true -- Show matches as you type
vim.opt.inccommand = "split" -- Enable live preview for :s commands using a split

-- File Handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't write backups while editing
vim.opt.swapfile = false -- Disable swap file
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Set undo directory
vim.opt.updatetime = 300 -- Faster CursorHold event
vim.opt.timeout = true -- Enable timeout for mapped sequence
vim.opt.timeoutlen = 1000 -- Mapped sequence wait time
vim.opt.ttimeoutlen = 0 -- Time for key code sequences
vim.opt.autoread = true -- Auto-reload files if changed outside
vim.opt.autowrite = false -- Don’t auto-save when switching buffers
vim.opt.fileignorecase = true -- Ignore case while using file names

-- Editing Behavior
vim.opt.confirm = true -- Prompt for confirmation when closing or quitting with unsaved changes
vim.opt.errorbells = false -- Disable beep on errors
vim.opt.backspace = "indent,eol,start" -- Allow backspace everywhere
vim.opt.autochdir = false -- Don’t change working directory automatically
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.modifiable = true -- Buffers are modifiable
vim.opt.encoding = "utf-8" -- Default file encoding
vim.opt.completeopt = "menuone,noinsert,noselect,longest,popup,preview" -- Completion behavior
vim.opt.wildignore = "*.o" -- Ignore object files in path completion

vim.opt.foldcolumn = "1" -- Always show the fold column
vim.opt.foldenable = false -- Don't fold anything by default
vim.opt.foldlevel = 99 -- Open all folds by default
vim.opt.foldlevelstart = 99 -- Open all folds by default

vim.opt.iskeyword:append({ "-", "." }) -- Treat `-` as part of a word
vim.opt.path:append("**") -- Recursive file search

-- Clipboard
pcall(function()
  vim.opt.clipboard:append("unnamedplus") -- Use system clipboard if available
end)

-- Window Splits
vim.opt.splitbelow = true -- New splits go below
vim.opt.splitright = true -- New splits go to the right
vim.opt.splitkeep = "screen" -- Keep the text on screen in the same place

-- Show Invisible Characters
vim.opt.list = true
vim.opt.listchars:append({
  tab = "→ ",
  trail = "·",
  lead = "·",
  space = "·",
  nbsp = "␣",
  extends = "»",
  precedes = "«",
})

-- Customize window filling characters
vim.opt.fillchars:append({
  eob = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  msgsep = "─",
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vert = "│",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
})

-- Cursor Appearance
vim.opt.guicursor = {
  "n-v-c:block", -- Normal, visual, command: block
  "i-ci-ve:ver25", -- Insert, command-insert, visual-ex: vertical bar
  "r-cr:hor20", -- Replace modes: horizontal bar
  "o:hor50", -- Operator-pending: thick horizontal bar
  "t:ver25", -- Terminal: vertical bar
  "a:blinkwait700-blinkoff600-blinkon500-Cursor/lCursor", -- Cursor blinking
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch blinking
}

-- Disable the default intro screen
vim.opt.shortmess:append("acstFOSWI")

-- Filetype Mapping
vim.filetype.add({
  extension = {
    mm = "objcpp",
  },
})
