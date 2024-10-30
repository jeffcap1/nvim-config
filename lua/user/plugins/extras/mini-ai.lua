local M = {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  version = "*",
}

function M.config()
  require("mini.ai").setup()
end

return M
