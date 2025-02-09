local M = {
  "mawkler/modicator.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
  show_warnings = false,
  highlights = {
    defaults = {
      bold = true,
      italic = false,
    },
  },
}

return M
