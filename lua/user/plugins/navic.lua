local M = {
  "hasansujon786/nvim-navbuddy",
  event = { "BufReadPost", "BufNewFile" },
}

local icons = require("user.icons")
M.opts = {
  icons = icons.kind,
  highlight = true,
  lsp = {
    auto_attach = true,
  },
  click = true,
  separator = " " .. icons.ui.ChevronRight .. " ",
  depth_limit = 0,
  depth_limit_indicator = "..",
}

return M
