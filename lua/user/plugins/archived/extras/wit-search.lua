local M = {
  "aliqyan-21/wit.nvim",
  event = "VeryLazy",
}

M.config = function()
  require("wit").setup({
    engine = "duckduckgo",
  })
end

return M
