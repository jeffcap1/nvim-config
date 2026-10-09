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

-- hover with expanded TS types for ts/tsx/astro, plain LSP hover otherwise
-- (shared by `gh` here and `K` in ufo.lua)
M.hover = function()
  local ts_ft = { typescript = true, typescriptreact = true, astro = true }

  if ts_ft[vim.bo.filetype] then
    local ok, ts_hover = pcall(require, "ts_expand_hover")
    if ok and ts_hover and ts_hover.hover then
      ts_hover.hover()
      return
    end
  end

  vim.lsp.buf.hover()
end

function M.config()
  local icons = require("user.icons")
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- fix line folding errors
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticError",
        [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
        [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
        [vim.diagnostic.severity.HINT] = "DiagnosticHint",
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
      source = true,
      header = "",
      prefix = "",
    },
  })

  -- JS linters: always enabled; each decides per buffer whether to attach.
  -- Precedence biome > oxlint > eslint is enforced in user.lsp_settings.{eslint,oxlint}
  -- (see user.js_project), so a project with biome + a leftover .eslintrc gets biome only.
  vim.list_extend(USERS_LSP_SERVERS, { "biome", "oxlint", "eslint" })

  -- shared on_attach, run before the server's own lspconfig on_attach
  local on_attach = function(client, bufnr)
    -- disable formatting for specific servers
    if client.name == "ruff" or client.name == "pyright" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    -- disable native LSP document color (nvim 0.12+) to prevent assertion
    -- failures in vim/lsp/document_color.lua; nvim-highlight-colors handles
    -- color rendering instead
    client.server_capabilities.colorProvider = false

    -- (optional) put your keymaps or other buffer-local stuff here
  end

  -- chain ours with lspconfig's per-server on_attach instead of replacing it
  -- (eslint/oxlint/pyright define buffer commands like :LspEslintFixAll there)
  local function with_base_on_attach(server)
    local base = vim.lsp.config[server] and vim.lsp.config[server].on_attach
    if not base then
      return on_attach
    end
    local base_fns = type(base) == "table" and base or { base }
    return function(client, bufnr)
      on_attach(client, bufnr)
      for _, fn in ipairs(base_fns) do
        fn(client, bufnr)
      end
    end
  end

  -- setup language server
  for _, lsp_server in pairs(USERS_LSP_SERVERS) do
    local opts = {
      capabilities = capabilities,
      on_attach = with_base_on_attach(lsp_server),
    }

    local require_ok, settings = pcall(require, "user.lsp_settings." .. lsp_server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    -- optionally override defaults
    vim.lsp.config(lsp_server, opts)

    -- Enable filetype-based activation of the config.
    vim.lsp.enable(lsp_server)
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
      if client and client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true)
      end

      -- stylua: ignore
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions

      -- keymap("n", "gh", lspbuf.hover, _opts({ desc = "LSP hover help" }))
      keymap("n", "gh", M.hover, _opts({ desc = "Universal LSP hover help" }))

      keymap("n", "gH", lspbuf.signature_help, _opts({ desc = "LSP function signature" }))
      keymap("n", "gd", lspbuf.definition, _opts({ desc = "LSP definition" }))
      keymap("n", "gD", lspbuf.declaration, _opts({ desc = "LSP declaration" }))
      keymap("n", "gI", lspbuf.implementation, _opts({ desc = "LSP implementation" }))
      keymap("n", "gr", lspbuf.references, _opts({ desc = "LSP references" }))
      keymap("n", "gl", vim.diagnostic.open_float, _opts({ desc = "Diagnostic line help" }))

      keymap({ "n", "v" }, "<leader>la", lspbuf.code_action, _opts({ desc = "LSP code actions" }))
      keymap("n", "]d", function()
        vim.diagnostic.jump({ count = 1 })
      end, _opts({ desc = "Goto next diagnostic" }))
      keymap("n", "[d", function()
        vim.diagnostic.jump({ count = -1 })
      end, _opts({ desc = "Goto previous diagnostic" }))

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
      -- stylua: ignore end
    end,
  })
end

return M
