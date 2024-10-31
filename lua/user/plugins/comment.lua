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

-- stylua: ignore
M.keys = {
  {"<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment", silent = true, noremap = true},
  {"<leader>/", "<Plug>(comment_toggle_blockwise_visual)", desc = "Toggle comment", mode = "x", silent = true, noremap = true},
}

function M.config()
  vim.g.skip_ts_context_commentstring_module = true

  ---@diagnostic disable: missing-fields
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })

  require("Comment").setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

return M
