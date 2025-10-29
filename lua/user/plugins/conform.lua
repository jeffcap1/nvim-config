local M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

local function get_js_formatter()
  if FILE_EXISTS_IN_PROJECT_ROOT("biome.json") then
    return { "biome" }
  else
    return { "prettierd", "prettier", stop_after_first = true }
  end
end

M.config = function()
  local conform = require("conform")
  local util = require("conform.util")

  ---@type conform.setupOpts
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      python = { "ruff_organize_imports", "ruff_format" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      -- Conform will run the first available formatter
      javascript = function()
        return get_js_formatter()
      end,
      typescript = function()
        return get_js_formatter()
      end,
      javascriptreact = function()
        return get_js_formatter()
      end,
      typescriptreact = function()
        return get_js_formatter()
      end,
      astro = function()
        return get_js_formatter()
      end,
      vue = function()
        return get_js_formatter()
      end,
      svelte = function()
        return get_js_formatter()
      end,
      css = function()
        return get_js_formatter()
      end,
      scss = { "prettierd", "prettier", stop_after_first = true },
      less = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      graphql = { "prettierd", "prettier", stop_after_first = true },
      sql = { "sql_formatter" },
      php = { "phpcbf", "phpcsfixer" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
    notify_on_error = true,
    notify_no_formatters = true,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        vim.notify("󰉼  formatting is disabled")
        return
      end
      -- I recommend these options. See :help conform.format for details.
      return {
        timeout_ms = 5000,
        lsp_format = "fallback",
      }
    end,
  })

  conform.formatters.sql_formatter = {
    args = {
      "-l",
      "postgresql",
    },
  }

  conform.formatters.biome = {
    prepend_args = { "check", "--write" },
  }

  vim.keymap.set({ "n", "v" }, "<leader>lff", function()
    conform.format({ timeout_ms = 500, lsp_format = "fallback" })
  end, XTND({ desc = "Format File" }))

  vim.keymap.set("n", "<leader>lfs", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.notify(
      "󰉼  formatting is "
        .. ((vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat) and "disabled" or "enabled")
    )
  end, XTND({ desc = "Format Status" }))

  vim.keymap.set("n", "<leader>lft", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd((vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat) and "FormatEnable" or "FormatDisable")
    vim.notify("󰉼  formatting is " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
  end, XTND({ desc = "Toggle Format (Global)" }))

  vim.keymap.set("n", "<leader>lfb", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd(vim.b[bufnr].disable_autoformat and "FormatEnable" or "FormatDisable!")
    vim.notify("󰉼  formatting is " .. (vim.b[bufnr].disable_autoformat and "disabled" or "enabled"))
  end, XTND({ desc = "Toggle Format (Buffer)" }))
end

-- custom commands
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })

return M
