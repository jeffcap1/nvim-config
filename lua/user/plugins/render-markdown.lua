local M = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" }, -- codecompanion.lua adds its own filetypes when spec'd
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
}

M.opts = {}

return M
