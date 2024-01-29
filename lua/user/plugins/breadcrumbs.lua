local M = {
  "LunarVim/breadcrumbs.nvim",
  dependancies = {
    "SmiteshP/nvim-navic",
  },
}

function M.config()
  require("breadcrumbs").setup()
end

return M
