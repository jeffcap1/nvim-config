local M = {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
}

-- stylua: ignore
M.keys = {
  { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
  { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
  { "<leader>tl", "<cmd>TodoLocList<cr>", desc = "Location list for todo comments" },
  { "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Quickfix list for todo comments" },
  { "<leader>tt", function() Snacks.picker.todo_comments({ layout = { preset = 'ivy' } }) end, desc = "Todo" },
  { "<leader>tT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" }, layout = { preset = 'ivy' } }) end, desc = "Todo/Fix/Fixme" },
}
-- stylua: ignore end

return M
