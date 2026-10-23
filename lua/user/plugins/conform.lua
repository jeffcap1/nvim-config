local M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

-- chosen per buffer (nearest config above the file), matching the linter precedence
-- in user.js_project so formatter and linter always agree
local function get_js_formatter(bufnr)
  local js = require("user.js_project")
  if js.uses(bufnr, "biome") then
    return { "biome-organize-imports", "biome" }
  elseif js.uses(bufnr, "oxfmt") then
    return { "oxfmt" }
  else
    return { "prettierd", "prettier", stop_after_first = true }
  end
end

-- non-JS filetypes oxfmt also handles; biome projects keep prettier here
local function get_prettier_or_oxfmt(bufnr)
  if require("user.js_project").uses(bufnr, "oxfmt") then
    return { "oxfmt" }
  end
  return { "prettierd", "prettier", stop_after_first = true }
end

M.config = function()
  local conform = require("conform")

  ---@type conform.setupOpts
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      python = { "ruff_organize_imports", "ruff_format" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      -- Conform will run the first available formatter
      javascript = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      typescript = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      javascriptreact = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      typescriptreact = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      astro = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      vue = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      svelte = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      css = function(bufnr)
        return get_js_formatter(bufnr)
      end,
      scss = get_prettier_or_oxfmt,
      less = get_prettier_or_oxfmt,
      html = get_prettier_or_oxfmt,
      json = get_prettier_or_oxfmt,
      jsonc = get_prettier_or_oxfmt,
      yaml = get_prettier_or_oxfmt,
      markdown = get_prettier_or_oxfmt,
      graphql = get_prettier_or_oxfmt,
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

  conform.formatters.biome = {
    args = function(self, ctx)
      if self:cwd(ctx) then
        return { "format", "--write", "--stdin-file-path", "$FILENAME" }
      end
      return {
        "format",
        "--write",
        "--stdin-file-path",
        "$FILENAME",
        "--indent-style",
        vim.bo[ctx.buf].expandtab and "space" or "tab",
        "--indent-width",
        ctx.shiftwidth,
      }
    end,
  }

  conform.formatters.sql_formatter = {
    args = {
      "-l",
      "postgresql",
    },
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
