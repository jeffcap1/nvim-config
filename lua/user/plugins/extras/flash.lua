local M = {
  "folke/flash.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

-- stylua: ignore
M.keys = {
  { "<c-j>", function() require("flash").jump() end, mode = { "n", "x" }, desc = "Flash" },
}
-- stylua: ignore end

M.opts = {
  modes = {
    char = {
      jump_labels = true,
    },
  },
}

return M
