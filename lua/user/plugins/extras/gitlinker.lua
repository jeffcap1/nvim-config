local M = {
  "linrongbin16/gitlinker.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<leader>gy", "<cmd>GitLink!<cr>", desc = "Git link" },
    { "<leader>gY", "<cmd>GitLink! blame<cr>", desc = "Git link blame" },
  })

  require("gitlinker").setup({
    message = false,
    console_log = false,
  })
end

return M
