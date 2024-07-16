local M = {
  "FabijanZulj/blame.nvim",
}

M.config = function()
  require("blame").setup()

  local wk = require("which-key")

  wk.add({
    { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Blame" },
  }, {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  })
end

return M
