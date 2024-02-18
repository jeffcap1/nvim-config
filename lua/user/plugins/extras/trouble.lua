local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
}

function M.config()
  local tb = require("trouble")
  local keymap = vim.keymap.set

  tb.setup({})

  keymap("n", "<leader>xx", function()
    tb.toggle()
  end, XTND({ desc = "Trouble toggle list" }))
  keymap("n", "<leader>xw", function()
    tb.toggle("workspace_diagnostics")
  end, XTND({ desc = "Trouble toggle workspace diagnostics" }))
  keymap("n", "<leader>xd", function()
    tb.toggle("document_diagnostics")
  end, XTND({ desc = "Trouble toggle document diagnostics" }))
  keymap("n", "<leader>xq", function()
    tb.toggle("quickfix")
  end, XTND({ desc = "Trouble toggle quickfix list" }))
  keymap("n", "<leader>xl", function()
    tb.toggle("loclist")
  end, XTND({ desc = "Trouble toggle loclist" }))
  keymap("n", "gR", function()
    tb.toggle("lsp_references")
  end, XTND({ desc = "Trouble toggle lsp references" }))
end

return M
