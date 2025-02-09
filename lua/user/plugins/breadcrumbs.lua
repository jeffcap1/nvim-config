local M = {
  "LunarVim/breadcrumbs.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  opts = true,
}

return M
