local M = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}

-- stylua: ignore start
M.keys = {
  { "]h", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", silent = true  },
  { "[h", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Previous Hunk", silent = true  },
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff", silent = true },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", silent = true  },
  { "<leader>gL", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", desc = "Blame Inline", silent = true  },
  { "<leader>gh", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", silent = true  },
  { "<leader>gH", "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>", desc = "Preview Hunk Inline", silent = true  },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", silent = true  },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", silent = true  },
  -- { "<leader>gS", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", silent = true  },
  -- { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", silent = true  },
}
-- stylua: ignore end

local icons = require("user.icons")
M.opts = {
  signs = {
    add = { text = icons.ui.BoldLineMiddle },
    change = { text = icons.ui.BoldLineDashedMiddle },
    delete = { text = icons.ui.TriangleShortArrowRight },
    topdelete = { text = icons.ui.TriangleShortArrowRight },
    changedelete = { text = icons.ui.BoldLineMiddle },
  },
  watch_gitdir = {
    follow_files = true,
  },
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  attach_to_untracked = true,
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  max_file_length = 40000,
  current_line_blame_opts = {
    delay = 300,
  },
  preview_config = {
    border = "rounded",
  },
}

return M
