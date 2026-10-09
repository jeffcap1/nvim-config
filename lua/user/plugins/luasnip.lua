local M = {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = "make install_jsregexp",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
}

-- history/updateevents/ext_opts are set in after/plugin/luasnip.lua
M.opts = {
  delete_check_events = "TextChanged",
}

return M
