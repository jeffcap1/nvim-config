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

local function xtnd(opt1, opt2)
  return vim.tbl_extend("force", opt1, opt2)
end

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

   vim.g.skip_ts_context_commentstring_module = true

  ---@diagnostic disable: missing-fields
  require("ts_context_commentstring").setup {
    enable_autocmd = false,
  }

  require("Comment").setup {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    keymap("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", xtnd(opts, { desc = "Toggle comment" })),
    keymap("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", xtnd(opts, { desc = "Visually toggle comment" })),
  }
end

return M
