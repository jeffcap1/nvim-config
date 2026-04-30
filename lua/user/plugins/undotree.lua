local M = {
  "mbbill/undotree",
}

M.keys = {
  { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle UndoTree" },
}

return M
