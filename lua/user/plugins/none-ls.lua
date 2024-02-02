local M = {
  "nvimtools/none-ls.nvim",
}

function M.auto_format(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("auto_format", {})
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

function M.config()
  local null_ls = require("null-ls")

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    on_attach = function(client, bufnr)
      M.auto_format(client, bufnr)
    end,
    sources = {
      -- linters
      diagnostics.phpcs,
      diagnostics.ruff,

      -- formatters
      formatting.htmlbeautifier,
      formatting.phpcsfixer,
      formatting.prettier,
      formatting.stylua,
    },
  })
  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "LSP format" })
end

return M
