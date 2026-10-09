return {
  -- lazy-load schemastore when the server starts
  -- (vim.lsp.config ignores lspconfig's legacy `on_new_config`; mutate settings in place)
  before_init = function(_, config)
    config.settings.json.schemas = config.settings.json.schemas or {}
    vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  settings = {
    json = {
      -- schemas = require "schemastore".json.schemas(),
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}
