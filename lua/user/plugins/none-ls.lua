return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      on_attach = function(client, bufnr)
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
      end,
      sources = {
        -- linters
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.diagnostics.ruff,

        -- formatters
        null_ls.builtins.formatting.htmlbeautifier,
        null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
      },
    })
    vim.keymap.set("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "LSP format" })
  end,
}
