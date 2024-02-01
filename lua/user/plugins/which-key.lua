local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
}

function M.config()
  local mappings = {
    q = { "<cmd>confirm q<CR>", "Quit" },
    h = { "<cmd>nohlsearch<CR>", "NOHL" },
    [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
    v = { "<cmd>vsplit<CR>", "Split" },
    s = { "<cmd>vsplit<CR>", "Split" },
    b = { name = "Buffers" },
    d = { name = "Debug" },
    f = { name = "Find" },
    g = { name = "Git" },
    l = { name = "LSP" },
    -- p = { name =, qwinid "Plugins" },
    -- t = { name = "Test" },
    a = {
      name = "Tab",
      n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      N = { "<cmd>tabnew %<cr>", "New Tab" },
      o = { "<cmd>tabonly<cr>", "Only" },
      h = { "<cmd>-tabmove<cr>", "Move Left" },
      l = { "<cmd>+tabmove<cr>", "Move Right" },
    },
    -- T = { name = "Treesitter" },
  }

  local which_key = require("which-key")

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end

return M
