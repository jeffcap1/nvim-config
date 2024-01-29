local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = USERS_LSP_SERVERS,
  })
end

return M
