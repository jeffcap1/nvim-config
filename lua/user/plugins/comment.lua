return {
  "numToStr/Comment.nvim",
  opts = {},
  event = "VeryLazy",
  config = function()
    require("Comment").setup({
      vim.keymap.set({ "n", "i" }, "<C-/>", "<Plug>(comment_toggle_linewise_current)"),
      vim.keymap.set("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)"),
    })
  end,
}
