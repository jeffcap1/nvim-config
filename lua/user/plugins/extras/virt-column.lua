local icons = require("user.icons")

local M = {
  "lukas-reineke/virt-column.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = icons.ui.LineMiddle,
    virtcolumn = "80,120,160",
  },
}

return M
