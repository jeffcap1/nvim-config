-- ESLint: wraps nvim-lspconfig's eslint config (lsp/eslint.lua) instead of replacing it.
--   * root_dir: per-buffer precedence (biome > oxlint > eslint), then lspconfig's own
--               check that an eslint config exists above the buffer
--   * cmd:      lspconfig's cmd ignores `cmd_env`, so legacy projects are spawned here
--               with ESLINT_USE_FLAT_CONFIG=false
--   * before_init: lspconfig's (workspaceFolder, Yarn PnP) + flat/legacy settings
local js = require("user.js_project")

local base = vim.lsp.config.eslint -- lspconfig defaults (resolved before our override)
local base_root_dir = base.root_dir
local base_before_init = base.before_init

-- legacy (.eslintrc*) decision per client root, recorded from the buffer that started it
local legacy_by_root = {}

local server_cmd = "vscode-eslint-language-server"

return {
  settings = {
    workingDirectory = { mode = "auto" },
  },

  root_dir = function(bufnr, on_dir)
    if js.shadowed_by(bufnr, "eslint") then
      return
    end
    base_root_dir(bufnr, function(root)
      legacy_by_root[root] = js.eslint_is_legacy(bufnr)
      on_dir(root)
    end)
  end,

  cmd = function(dispatchers, config)
    local cmd = server_cmd
    local local_cmd = config.root_dir and vim.fs.joinpath(config.root_dir, "node_modules/.bin", server_cmd)
    if local_cmd and vim.fn.executable(local_cmd) == 1 then
      cmd = local_cmd
    end
    local env = legacy_by_root[config.root_dir] and { ESLINT_USE_FLAT_CONFIG = "false" } or nil
    return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers, { env = env })
  end,

  before_init = function(params, config)
    if base_before_init then
      base_before_init(params, config)
    end
    if legacy_by_root[config.root_dir] then
      config.settings.useFlatConfig = false
      config.settings.experimental =
        vim.tbl_extend("force", config.settings.experimental or {}, { useFlatConfig = false })
    end
  end,
}
