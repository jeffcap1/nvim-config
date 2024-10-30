local M = {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
  },
  opts = {},
}

function M.config()
  local tb = require("trouble")
  local keymap = vim.keymap.set

  tb.setup({})

  keymap(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    XTND({ desc = "Buffer Diagnostics (Trouble)" })
  )
  keymap(
    "n",
    "<leader>xw",
    "<cmd>Trouble diagnostics toggle focus=true<cr>",
    XTND({ desc = "Workspace Diagnostics (Trouble)" })
  )
  keymap("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=true<cr>", XTND({ desc = "Symbols (Trouble)" }))
  keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", XTND({ desc = "Location List (Trouble)" }))
  keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", XTND({ desc = "Quickfix List (Trouble)" }))
  keymap(
    "n",
    "gR",
    "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
    XTND({ desc = "LSP Definitions / refs / ... (Trouble)" })
  )
end

return M
