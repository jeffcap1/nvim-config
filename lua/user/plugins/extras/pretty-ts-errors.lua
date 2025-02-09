local M = {
  "OlegGulevskyy/better-ts-errors.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {},
}

M.keys = {
  toggle = "<leader>dd", -- default '<leader>dd'
  go_to_definition = "<leader>dx", -- default '<leader>dx'
}

return M
