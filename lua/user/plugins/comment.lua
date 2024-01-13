return {
  "numToStr/Comment.nvim",
  opts = {},
  event = "VeryLazy",
  config = function()
    require("Comment").setup({
      vim.keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle comment" }),
      vim.keymap.set("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Visually toggle comment" }),
    })
  end,
}
