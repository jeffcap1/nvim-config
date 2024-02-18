local M = {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
}

function M.config()
  local keymap = vim.keymap.set

  vim.g.skip_ts_context_commentstring_module = true

  ---@diagnostic disable: missing-fields
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })

  require("Comment").setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    keymap("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", XTND({ desc = "Toggle comment" })),
    keymap("x", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", XTND({ desc = "Visually toggle comment" })),
  })
end

return M
