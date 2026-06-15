local M = {
  "LunarVim/breadcrumbs.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  opts = true,
}

function M.config()
  local breadcrumbs = require("breadcrumbs")
  vim.list_extend(breadcrumbs.winbar_filetype_exclude, { "fff_input", "fff_list", "fff_preview", "fff_file_info" })
  breadcrumbs.setup()
end

return M
