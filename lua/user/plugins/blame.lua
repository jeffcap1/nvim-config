local M = {
  "FabijanZulj/blame.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

-- stylua: ignore
M.keys = {
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Blame", silent = true, noremap = true },
}

M.config = function()
  require("blame").setup()
end

return M
