-- after.plugin.diagnostics
-- Configures diagnostic settings and behavior for Neovim plugins.

vim.diagnostic.config({
  -- Show diagnostics in floating windows on hover or CursorHold
  float = {
    -- Use no border
    border = "none",

    -- Include the diagnostic source in the message
    source = true,

    -- No header text in the floating window for a clean look
    header = "",

    -- Show diagnostics from the current cursor line
    scope = "line",

    -- Sort diagnostics by severity
    severity_sort = true,

    -- Prefix each diagnostic in the floating window
    prefix = function(diagnostic, i, total)
      local icons = {
        [vim.diagnostic.severity.ERROR] = { "", "DiagnosticError" },
        [vim.diagnostic.severity.WARN] = { "", "DiagnosticWarn" },
        [vim.diagnostic.severity.INFO] = { "", "DiagnosticInfo" },
        [vim.diagnostic.severity.HINT] = { "", "DiagnosticHint" },
      }

      local icon, group = unpack(icons[diagnostic.severity])
      return string.format("[%d/%d] %s ", i, total, icon), group
    end,

    -- Customize how each diagnostic message is formatted
    format = function(diagnostic)
      -- If there's a diagnostic code (like E1234), show it in brackets before the message
      if diagnostic.code then
        return string.format("[%s] %s", diagnostic.code, diagnostic.message)
      end

      -- Otherwise just show the diagnostic message
      return diagnostic.message
    end,

    -- Show floating only for errors, warnings and info
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },

  -- Underline diagnostics only for errors and warnings
  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },

  -- Use virtual text for diagnostics
  virtual_text = {
    -- Only show virtual text for errors, warnings and info
    severity = {
      min = vim.diagnostic.severity.INFO,
    },

    -- Show virtual text on all lines
    current_line = nil,

    -- Show diagnostic source name in virtual text if there are many
    source = "if_many",

    -- Add a bit of spacing between the code and the virtual text
    spacing = 4,

    -- Prefix with an icon per severity
    prefix = function(diagnostic, i, total)
      local icons = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.HINT] = " ",
      }

      return icons[diagnostic.severity] or " "
    end,

    -- Format the full message
    format = function(diagnostic)
      return string.format(
        "(%s) %s",
        diagnostic.source or "LSP",
        diagnostic.message
      )
    end,
  },

  -- Show signs in the gutter for quick visual feedback
  signs = {
    -- Show signs only for errors, warnings and info
    severity = {
      min = vim.diagnostic.severity.INFO,
    },

    -- Base priority for signs
    priority = 10,

    -- Use Nerd Font icons instead of plain letters for a nicer look
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },

  -- Jumping to a diagnostic
  jump = {
    -- Enable wrapping: jump from last diagnostic back to first
    wrap = true,

    -- Only jump to diagnostics with severity WARN or higher
    severity = {
      min = vim.diagnostic.severity.WARN,
    },

    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end

      -- Move cursor to diagnostic position
      vim.api.nvim_win_set_cursor(0, { diagnostic.lnum + 1, diagnostic.col })

      -- Show diagnostic info in a floating window without stealing focus
      vim.diagnostic.open_float({
        bufnr = bufnr,
        border = "none",
        scope = "cursor",
        prefix = function(diag, i, total)
          local icons = {
            [vim.diagnostic.severity.ERROR] = { "", "DiagnosticError" },
            [vim.diagnostic.severity.WARN] = { "", "DiagnosticWarn" },
            [vim.diagnostic.severity.INFO] = { "", "DiagnosticInfo" },
            [vim.diagnostic.severity.HINT] = { "", "DiagnosticHint" },
          }

          local icon, group = unpack(icons[diag.severity])
          return string.format("[%d/%d] %s ", i, total, icon), group
        end,

        format = function(diag)
          if diag.code then
            return string.format("[%s] %s", diag.code, diag.message)
          end

          return diag.message
        end,
      })

      -- Temporarily highlight diagnostic line
      local namespace = vim.api.nvim_create_namespace("DiagnosticJumpHighlight")
      vim.hl.range(
        bufnr,
        namespace,
        "Visual",
        { diagnostic.lnum, 0 },
        { diagnostic.lnum, -1 }
      )

      -- Clear highlight after 500ms
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_loaded(bufnr) then
          vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
        end
      end, 500)
    end,
  },

  -- Disable virtual lines
  virtual_lines = false,

  -- Update diagnostics in Insert mode
  update_in_insert = true,

  -- Sort diagnostics by severity
  severity_sort = true,
})
