local M = {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = true,
}

M.config = function()
  local wk = require("which-key")
  local neogit = require("neogit")

  neogit.setup({})

  wk.add({
    { "<leader>gs", neogit.open,              desc = "Neogit Open" },
    { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
    { "<leader>gp", "<cmd>Neogit pull<cr>",   desc = "Neogit Pull" },
    { "<leader>gP", "<cmd>Neogit push<cr>",   desc = "Neogit Push" },
  }, {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  })
end

return M
