local M = {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
  { "justinsgithub/wezterm-types", lazy = true }, -- wezterm typings
}

return M
