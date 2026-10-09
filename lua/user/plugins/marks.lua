local M = {
  "chentoast/marks.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
  excluded_filetypes = {
    "harpoon",
    "lazy",
    "mason",
    "netrw",
    "oil",
    "qf",
    "snacks_dashboard",
    "snacks_explorer",
    "snacks_input",
    "snacks_picker_input",
    "snacks_picker_list",
    "snacks_picker_preview",
    "snacks_select",
    "snacks_terminal",
    "trouble",
  },
}

return M
