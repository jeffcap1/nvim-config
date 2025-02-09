local M = {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}

function M.config()
  local null_ls = require("null-ls")

  -- local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    on_attach = function(client, bufnr)
      M.auto_format(client, bufnr)
    end,
    sources = {
      -- linters
      diagnostics.phpcs,
    },
  })
end

return M
