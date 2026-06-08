local M = {
  "nemanjamalesija/ts-expand-hover.nvim",
  ft = { "typescript", "typescriptreact", "astro" },
}

M.opts = {
  keymaps = { hover = "<leader>th" },
}

return M
