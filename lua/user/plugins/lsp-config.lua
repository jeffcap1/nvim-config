local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neodev.nvim",
    },
  },
}

local function xtnd(opt1, opt2)
  return vim.tbl_extend("force", opt1, opt2)
end

M.on_attach = function(client, bufnr)
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

function M.config()
  local lspconfig = require("lspconfig")
  local icons = require("user.icons")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- rounded borders for LSP
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- setup language server
  for _, lsp_server in pairs(USERS_LSP_SERVERS) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = capabilities,
    }

    local require_ok, settings = pcall(require, "user.lsp_settings." .. lsp_server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if lsp_server == "lua_ls" then
      require("neodev").setup({})
    end

    lspconfig[lsp_server].setup(opts)
  end

  -- lsp keybindings
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local keymap = vim.keymap.set
      local lspbuf = vim.lsp.buf
      local opts = { noremap = true, silent = true, buffer = ev.buf }

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      keymap("n", "gh", lspbuf.hover, xtnd(opts, { desc = "LSP hover help" }))
      keymap("n", "gs", lspbuf.signature_help, xtnd(opts, { desc = "LSP function signature" }))
      keymap("n", "gd", lspbuf.definition, xtnd(opts, { desc = "LSP definition" }))
      keymap("n", "gD", lspbuf.declaration, xtnd(opts, { desc = "LSP declaration" }))
      keymap("n", "gi", lspbuf.implementation, xtnd(opts, { desc = "LSP implementation" }))
      keymap("n", "gr", lspbuf.references, xtnd(opts, { desc = "LSP references" }))
      keymap("n", "gl", vim.diagnostic.open_float, xtnd(opts, { desc = "Diagnostic line help" }))

      keymap({ "n", "v" }, "<leader>la", lspbuf.code_action, xtnd(opts, { desc = "LSP code actions" }))
      keymap("n", "<leader>lj", vim.diagnostic.goto_next, xtnd(opts, { desc = "Goto next diagnostic" }))
      keymap("n", "<leader>lk", vim.diagnostic.goto_prev, xtnd(opts, { desc = "Goto previous diagnostic" }))
      keymap("n", "<leader>ll", vim.lsp.codelens.run, xtnd(opts, { desc = "CodeLens ACtion" }))
      keymap("n", "<leader>lq", vim.diagnostic.setloclist, xtnd(opts, { desc = "Diagnostic list locations" }))
      keymap("n", "<leader>lr", lspbuf.rename, xtnd(opts, { desc = "LSP rename" }))
      keymap("n", "<leader>ltd", lspbuf.type_definition, xtnd(opts, { desc = "LSP type definition" }))
      keymap(
        "n",
        "<leader>lh",
        "<cmd>lua require('user.plugins.lsp-config').toggle_inlay_hints()<cr>",
        xtnd(opts, { desc = "Hints" })
      )
    end,
  })
end

return M
