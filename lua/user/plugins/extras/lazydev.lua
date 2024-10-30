local M = {
  {
    "justinsgithub/wezterm-types",
    event = "VeryLazy",
  }, -- wezterm typings
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    event = "VeryLazy",
    opts = {
      enable = true,
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
}

return M
