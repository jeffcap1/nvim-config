local M = {
  "refractalize/oil-git-status.nvim",
  event = "VeryLazy", -- same as oil.nvim; was loading oil at startup

  dependencies = {
    "stevearc/oil.nvim",
  },

  config = true,
}

return M
