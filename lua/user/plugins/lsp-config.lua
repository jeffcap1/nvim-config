local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "saghen/blink.cmp" },
}

M.toggle_inlay_hints = function()
  if vim.lsp.inlay_hint then
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
  end
end

function M.config()
  local lspconfig = require("lspconfig")
  local icons = require("user.icons")
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- fix line folding errors
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

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
    virtual_text = false,
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

  for _, sign in ipairs(vim.tbl_get((vim.diagnostic.config() or {}), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- rounded borders for LSP
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- setup language server
  for _, lsp_server in pairs(USERS_LSP_SERVERS) do
    local opts = {
      capabilities = capabilities,
    }

    local require_ok, settings = pcall(require, "user.lsp_settings." .. lsp_server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    lspconfig[lsp_server].setup(opts)
  end

  -- lsp keybindings
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
      local keymap = vim.keymap.set
      local lspbuf = vim.lsp.buf

      local function _opts(opt)
        local buffopt = { buffer = ev.buf }
        return XTND(buffopt, opt)
      end

      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true)
      end

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      keymap("n", "gh", lspbuf.hover, _opts({ desc = "LSP hover help" }))
      keymap("n", "gH", lspbuf.signature_help, _opts({ desc = "LSP function signature" }))
      keymap("n", "gd", lspbuf.definition, _opts({ desc = "LSP definition" }))
      keymap("n", "gD", lspbuf.declaration, _opts({ desc = "LSP declaration" }))
      keymap("n", "gI", lspbuf.implementation, _opts({ desc = "LSP implementation" }))
      keymap("n", "gr", lspbuf.references, _opts({ desc = "LSP references" }))
      keymap("n", "gl", vim.diagnostic.open_float, _opts({ desc = "Diagnostic line help" }))

      keymap({ "n", "v" }, "<leader>la", lspbuf.code_action, _opts({ desc = "LSP code actions" }))
      keymap("n", "]d", vim.diagnostic.goto_next, _opts({ desc = "Goto next diagnostic" }))
      keymap("n", "[d", vim.diagnostic.goto_prev, _opts({ desc = "Goto previous diagnostic" }))
      keymap("n", "<leader>ll", vim.lsp.codelens.run, _opts({ desc = "CodeLens Action" }))
      keymap("n", "<leader>lq", vim.diagnostic.setloclist, _opts({ desc = "Diagnostic list locations" }))
      keymap("n", "<leader>lr", lspbuf.rename, _opts({ desc = "LSP rename" }))
      keymap("n", "<leader>lD", lspbuf.type_definition, _opts({ desc = "LSP type definition" }))
      keymap(
        "n",
        "<leader>lh",
        "<cmd>lua require('user.plugins.lsp-config').toggle_inlay_hints()<cr>",
        _opts({ desc = "Hints" })
      )
    end,
  })
end

return M
