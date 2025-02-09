local M = {
  {
    "justinsgithub/wezterm-types",
    ft = "lua", -- only load on lua files
    dependencies = { "folke/lazydev.nvim" },
  }, -- wezterm typings
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
}

return M
