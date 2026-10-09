local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
}

-- Non-LSP-list tools (mason package names). Linter LSPs are added per-project in
-- lsp-config.lua, so install all of them up front.
local tools = {
  -- linter LSPs (biome / oxlint / eslint chosen per project)
  "biome",
  "oxlint",
  "eslint-lsp",
  -- formatters (conform.lua)
  "stylua",
  "prettierd",
  "prettier",
  "oxfmt",
  "ruff",
  "sql-formatter",
  -- debug adapters (dap_settings)
  "js-debug-adapter",
  "debugpy",
}

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = USERS_LSP_SERVERS,
    automatic_enable = false,
  })

  require("mason-tool-installer").setup({
    ensure_installed = tools,
    run_on_start = true,
    start_delay = 3000, -- don't compete with startup
  })
end

return M
