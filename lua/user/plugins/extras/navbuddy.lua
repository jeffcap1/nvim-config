local M = {
  "SmiteshP/nvim-navbuddy",
  event = "VeryLazy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<leader>o", "<cmd>Navbuddy<cr>", desc = "Nav", icon = "󰆋 " },
  })

  local navbuddy = require("nvim-navbuddy")
  -- local actions = require("nvim-navbuddy.actions")
  navbuddy.setup({
    window = {
      border = "rounded",
    },
    icons = require("user.icons").kind,
    lsp = { auto_attach = true },
  })
end

return M
