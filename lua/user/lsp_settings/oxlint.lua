-- oxlint: wraps nvim-lspconfig's oxlint config (lsp/oxlint.lua).
--   * skip when biome is configured for the buffer (precedence biome > oxlint > eslint)
--   * lspconfig calls on_dir(nil) when no oxlint config is found, which would start a
--     rootless oxlint for every JS/TS buffer; only start when a root was found
local js = require("user.js_project")

local base_root_dir = vim.lsp.config.oxlint.root_dir

return {
  root_dir = function(bufnr, on_dir)
    if js.shadowed_by(bufnr, "oxlint") then
      return
    end
    base_root_dir(bufnr, function(root)
      if root then
        on_dir(root)
      end
    end)
  end,
}
