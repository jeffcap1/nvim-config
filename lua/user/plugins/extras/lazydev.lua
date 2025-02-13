-- wezterm typings
local WEZ = {
  "justinsgithub/wezterm-types",
  ft = "lua", -- only load on lua files
  dependencies = { "folke/lazydev.nvim" },
}

local LAZYDEV = {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
}

LAZYDEV.opts = {
  -- always enable unless `vim.g.lazydev_enabled = false`
  -- This is the default
  enabled = function(root_dir)
    return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
  end,
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "wezterm-types", mods = { "wezterm" } },
    { path = "snacks.nvim", words = { "Snacks" } },
    "flash.nvim",
  },
}

return {
  WEZ,
  LAZYDEV,
}
