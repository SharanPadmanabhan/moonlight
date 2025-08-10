-- moonlight.after.plugin.diagnostics
-- Configures diagnostic settings and behavior for Neovim plugins.

vim.diagnostic.config({
  -- Show diagnostics in floating windows on hover or CursorHold
  float = {
    -- Use a simple single-line border like VSCode
    border = "single",

    -- Float window does not steal focus, so you can keep typing
    focusable = false,

    -- Always show which source (LSP, null-ls, etc.) produced the diagnostic
    source = true,

    -- No header text in the floating window for a clean look
    header = "",

    -- Prefix each diagnostic message in the float with a Nerd Font icon
    prefix = function(diagnostic, i, total)
      local icons = {
        [vim.diagnostic.severity.ERROR] = { " ", "DiagnosticError" },
        [vim.diagnostic.severity.WARN] = { " ", "DiagnosticWarn" },
        [vim.diagnostic.severity.INFO] = { " ", "DiagnosticInfo" },
        [vim.diagnostic.severity.HINT] = { " ", "DiagnosticHint" },
      }
      return icons[diagnostic.severity][1], icons[diagnostic.severity][2]
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
  },

  -- Underline diagnostics only for errors and warnings
  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },

  -- Show signs in the gutter for quick visual feedback
  signs = {
    -- Show signs only for errors, warnings and info
    severity = {
      min = vim.diagnostic.severity.INFO,
    },

    -- Base priority for signs
    priority = 20,

    -- Use Nerd Font icons instead of plain letters for a nicer look
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },

    -- Highlight the line number with diagnostic-specific colors for visibility
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
      [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
    },

    -- Highlight the entire line background with subtle color
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
      [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
    },
  },

  -- Update diagnostics while typing for instant feedback
  update_in_insert = true,

  -- Disable virtual lines (usually noisy)
  virtual_lines = false,

  -- Enable virtual text but only for errors, warnings and info
  virtual_text = {
    -- Only show virtual text for errors, warnings and info
    severity = {
      min = vim.diagnostic.severity.INFO,
    },

    -- Show virtual text only on the current line under the cursor
    current_line = false,

    -- Don't show diagnostic source name in virtual text
    source = "if_many",

    -- Add a bit of spacing between the code and the virtual text
    spacing = 4,

    -- Prefix with an icon per severity
    prefix = function(diagnostic, i, total)
      local icons = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      }
      return icons[diagnostic.severity] or ""
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

  -- When jumping to a diagnostic, don't open a float immediately
  jump = {
    -- Disable floating window on diagnostic jump, like VSCode's default behavior
    float = false,

    -- Enable wrapping: jump from last diagnostic back to first
    wrap = true,

    -- Only jump to diagnostics with severity WARN or higher
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },

  -- Sort diagnostics by severity (errors first)
  severity_sort = true,
})
