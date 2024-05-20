local M = {
  "nvimtools/none-ls.nvim",
}

local autoformat = true

function M.auto_format(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    local augroup = vim.api.nvim_create_augroup("auto_format", { clear = true })
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if autoformat then
          vim.lsp.buf.format()
        end
      end,
    })
  end
end

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    on_attach = function(client, bufnr)
      M.auto_format(client, bufnr)
    end,
    sources = {
      -- linters
      diagnostics.phpcs,

      -- formatters
      -- formatting.htmlbeautifier,
      formatting.stylua,
      formatting.sql_formatter,
      formatting.phpcsfixer,
      formatting.prettier.with {
        filetypes = {
          "css",
          "scss",
          "less",
          "html",
          "markdown",
          "json",
          "yaml",
          "lua",
          "astro",
          "vue",
          "svelte",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
      },
    },
  }

  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format()
  end, XTND { desc = "LSP format" })
  vim.keymap.set("n", "<leader>lt", function()
    autoformat = not autoformat
  end, XTND { desc = "LSP toggle autoformat" })
end

return M
