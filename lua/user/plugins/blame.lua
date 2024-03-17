local M = {
  "FabijanZulj/blame.nvim"
}

M.config = function()
  local wk = require("which-key")

  wk.register({
    ["gb"] = { "<cmd>ToggleBlame<cr>", "Blame" }
  }, {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
  })
end

return M
