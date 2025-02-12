local M = {
  {
    "justinsgithub/wezterm-types",
    ft = "lua", -- only load on lua files
    dependencies = { "folke/lazydev.nvim" },
  }, -- wezterm typings
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      enable = true,
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}

return M
