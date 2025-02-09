local M = {
  "FabijanZulj/blame.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

-- stylua: ignore
M.keys = {
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Blame", silent = true, noremap = true },
}
-- stylua: ignore end

M.config = function()
  require("blame").setup()
end

return M
