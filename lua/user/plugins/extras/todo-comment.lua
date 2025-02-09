local M = {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
}

M.keys = function()
  local tc = require("todo-comments")
  -- stylua: ignore
  return {
    { "]t", tc.jump_next, desc = "Next todo comment" },
    { "[t", tc.jump_prev, desc = "Previous todo comment" },
    { "<leader>tl", "<cmd>TodoLocList<cr>", desc = "Quickfix list for todo comments" },
    { "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Quickfix list for todo comments" },
    { "<leader>tt", function() Snacks.picker.todo_comments({ layout = { preset = 'ivy' } }) end, desc = "Todo" },
    { "<leader>tT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" }, layout = { preset = 'ivy' } }) end, desc = "Todo/Fix/Fixme" },
  }
  -- stylua: ignore end
end

return M
