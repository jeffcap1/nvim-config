local M = {
  "LunarVim/breadcrumbs.nvim",
  event = "VeryLazy",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
}

function M.config()
  require("breadcrumbs").setup()
end

return M
