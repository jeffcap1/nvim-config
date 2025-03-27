local M = {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}

function M.config()
  local null_ls = require("null-ls")

  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    sources = {
      -- linters
      diagnostics.phpcs,
    },
  })
end

return M
