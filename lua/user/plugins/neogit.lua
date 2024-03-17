local M = {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = true
}

M.config = function()
  local wk = require "which-key"
  local neogit = require "neogit"

  neogit.setup({})

  wk.register({
    ["gs"] = { neogit.open, "Neogit Open" },
    ["gc"] = { "<cmd>Neogit commit<cr>", "Neogit Commit" },
    ["gp"] = { "<cmd>Neogit pull<cr>", "Neogit Pull" },
    ["gP"] = { "<cmd>Neogit push<cr>", "Neogit Push" },
  }, {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  })
end


return M
