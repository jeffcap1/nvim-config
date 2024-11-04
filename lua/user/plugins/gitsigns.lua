local M = {
  "lewis6991/gitsigns.nvim",
  cmd = "Gitsigns",
}

-- stylua: ignore start
M.keys = {
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff", silent = true },
  { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", silent = true  },
  { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", silent = true  },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", silent = true  },
  { "<leader>gL", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", desc = "Blame Inline", silent = true  },
  { "<leader>gh", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", silent = true  },
  { "<leader>gH", "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>", desc = "Preview Hunk Inline", silent = true  },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", silent = true  },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", silent = true  },
  { "<leader>gS", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", silent = true  },
  { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", silent = true  },
}
-- stylua: ignore end

M.config = function()
  local icons = require("user.icons")

  require("gitsigns").setup({
    signs = {
      add = { text = icons.ui.BoldLineMiddle },
      change = { text = icons.ui.BoldLineDashedMiddle },
      delete = { text = icons.ui.TriangleShortArrowRight },
      topdelete = { text = icons.ui.TriangleShortArrowRight },
      changedelete = { text = icons.ui.BoldLineMiddle },
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
