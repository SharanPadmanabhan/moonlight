-- moonlight.core.autocmds
-- Defines custom autocommands for the Moonlight Neovim configuration.

-- Helper to create augroups
local function augroup(name)
  return vim.api.nvim_create_augroup("Moonlight" .. name, { clear = true })
end

-- Open help files in a vertical split on the right
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("Help"),
  pattern = "*",
  desc = "Open help files in a vertical split on the right",
  callback = function(args)
    local buffer = args.buf

    -- Only act on help buffers
    if vim.bo[buffer].filetype ~= "help" then
      return
    end

    local window = vim.fn.bufwinid(buffer)

    -- Skip if buffer isn't displayed in any window or if it's a floating window
    if window == -1 or vim.api.nvim_win_get_config(window).relative ~= "" then
      return
    end

    -- Move the help window to the far right vertical split
    vim.api.nvim_set_current_win(window)
    vim.cmd("wincmd L")
  end,
})

-- Adjust 'numberwidth' automatically based on total line count
vim.api.nvim_create_autocmd(
  { "BufEnter", "TextChanged", "TextChangedI", "BufWritePost" },
  {
    group = augroup("AdjustNumberWidth"),
    pattern = "*",
    desc = "Adjust 'numberwidth' automatically based on total line count",
    callback = function()
      local line_count = vim.fn.line("$")

      -- Reset to default width if buffer is empty or invalid
      if line_count <= 0 then
        vim.wo.numberwidth = 4
        return
      end

      -- Add 2 extra columns: one for spacing, one for cursor gutter
      local number_of_digits = math.floor(math.log10(line_count)) + 1
      local number_width = math.max(4, number_of_digits + 2)

      vim.wo.numberwidth = number_width
    end,
  }
)

-- Restore cursor to last known position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("RestoreCursor"),
  desc = "Restore last cursor position when opening file",
  callback = function(args)
    local buffer = args.buf

    -- Skip restoring in excluded filetypes
    local filetype = vim.bo[buffer].filetype
    local excluded = { "gitcommit", "gitrebase", "help", "nofile", "quickfix" }
    if vim.tbl_contains(excluded, filetype) then
      return
    end

    local window = vim.fn.bufwinid(buffer)
    if window == -1 then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(buffer, "\"")
    local line_count = vim.api.nvim_buf_line_count(buffer)

    -- Restore cursor only if mark is within valid line range
    if mark[1] > 0 and mark[1] <= line_count then
      -- Defer to avoid race conditions during window initialization
      vim.defer_fn(function()
        vim.api.nvim_win_set_cursor(window, { mark[1], mark[2] })
      end, 0)
    end
  end,
})

-- Strip trailing whitespace from lines before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("TrimWhitespace"),
  desc = "Trim trailing whitespace before saving",
  callback = function()
    -- Save the current cursor position, viewport, and folds to restore later
    local save = vim.fn.winsaveview()

    -- Remove all trailing whitespace from every line silently, suppressing errors
    vim.cmd([[silent! %s/\s\+$//e]])

    -- Restore the saved cursor position and viewport to avoid jumping around
    vim.fn.winrestview(save)
  end,
})

-- Disable automatic commenting when starting a new line
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("NoAutoComment"),
  desc = "Prevent auto comment insertion on newline",
  callback = function()
    -- Remove 'c', 'r', 'o' flags from 'formatoptions' to stop auto comment insertion:
    -- 'c' - Auto-wrap comments using textwidth
    -- 'r' - Insert comment leader after hitting Enter
    -- 'o' - Insert comment leader after 'o' or 'O' in normal mode
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Resize splits equally when terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("ResizeSplits"),
  desc = "Resize splits equally when terminal window is resized",
  callback = function()
    -- Equalize window sizes across all tabs
    vim.cmd("tabdo wincmd =")
  end,
})

-- Disable Line Numbers in Special Buffers
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("CleanSpecialBuffers"),
  pattern = { "help", "qf", "man", "gitcommit" },
  desc = "Disable line numbers in special buffers",
  callback = function()
    -- Disable absolute line numbers in these special buffers
    vim.opt_local.number = false

    -- Disable relative line numbers as well for cleaner view
    vim.opt_local.relativenumber = false
  end,
})

-- Start Insert Mode Automatically in Terminal Buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("TermInsertMode"),
  desc = "Start in insert mode for terminals",
  callback = function()
    -- When a terminal buffer opens, switch to insert mode immediately
    vim.cmd("startinsert")
  end,
})

-- Auto-format buffer on save if client supports formatting
local group = augroup("AutoFormatOnSave")
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  desc = "Auto-format buffer on save if client supports formatting",
  callback = function(args)
    -- Get the LSP client attached to the buffer
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Only set up formatting autocmd if client supports formatting but not async willSaveWaitUntil
    if
      not client:supports_method("textDocument/willSaveWaitUntil")
      and client:supports_method("textDocument/formatting")
    then
      -- Create a buffer-local autocmd to format on buffer write (before saving)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = args.buf,
        callback = function()
          -- Trigger LSP formatting for this buffer using the current client
          vim.lsp.buf.format({
            bufnr = args.buf,
            id = client.id,
            timeout_ms = 1000,
          })
        end,
      })
    end
  end,
})
