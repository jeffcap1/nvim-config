local M = {
  { "justinsgithub/wezterm-types" }, -- wezterm typings
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      enable = true,
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
}

return M
