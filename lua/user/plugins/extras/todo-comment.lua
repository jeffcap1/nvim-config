local M = {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
}

function M.config()
  local tc = require("todo-comments")
  local keymap = vim.keymap.set

  tc.setup({})

  keymap("n", "<leader>cj", tc.jump_next, XTND({ desc = "Next todo comment" }))
  keymap("n", "<leader>ck", tc.jump_prev, XTND({ desc = "Previous todo comment" }))
  keymap("n", "<leader>cl", "<cmd>TodoLocList<cr>", XTND({ desc = "Quickfix list for todo comments" }))
  keymap("n", "<leader>cq", "<cmd>TodoQuickFix<cr>", XTND({ desc = "Quickfix list for todo comments" }))
  keymap("n", "<leader>ct", "<cmd>TodoTelescope<cr>", XTND({ desc = "Quickfix list for todo comments" }))
end

return M
