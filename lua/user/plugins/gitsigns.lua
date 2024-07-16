local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local icons = require("user.icons")

  local wk = require("which-key")
  wk.add({
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",                             desc = "Git Diff" },
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",                 desc = "Next Hunk" },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",                 desc = "Prev Hunk" },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",                desc = "Blame" },
    { "<leader>gL", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", desc = "Blame Inline" },
    { "<leader>gh", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",              desc = "Preview Hunk" },
    { "<leader>gH", "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>",       desc = "Preview Hunk Inline" },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",                desc = "Reset Hunk" },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",              desc = "Reset Buffer" },
    { "<leader>gS", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",                desc = "Stage Hunk" },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",           desc = "Undo Stage Hunk" },
  }, {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  })

  require("gitsigns").setup({
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = icons.ui.BoldLineMiddle,
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = icons.ui.BoldLineDashedMiddle,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = icons.ui.TriangleShortArrowRight,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = icons.ui.TriangleShortArrowRight,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = icons.ui.BoldLineMiddle,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    update_debounce = 200,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })
end

return M
