local M = {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
}

M.keys = function()
  local tc = require("todo-comments")
  return {
    { "]c", tc.jump_next, desc = "Next todo comment" },
    { "[c", tc.jump_prev, desc = "Previous todo comment" },
    { "<leader>tl", "<cmd>TodoLocList<cr>", desc = "Quickfix list for todo comments" },
    { "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Quickfix list for todo comments" },
    { "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "Quickfix list for todo comments" },
  }
end

return M
