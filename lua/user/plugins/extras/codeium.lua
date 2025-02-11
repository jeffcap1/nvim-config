local M = {
  "monkoose/neocodeium",
}

M.config = {
  filetypes = {
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    TelescopePrompt = false,
    snacks_picker_input = false,
    snacks_picker_preview = false,
    snacks_picker_list = false,
    snacks_terminal = false,
    snacks_explorer = false,
    snacks_input = false,
    DressingInput = false,
    ["dap-repl"] = false,
    ["."] = false,
  },
}

-- stylua: ignore
M.keys = {
  { "<c-l>", function() require("neocodeium").accept() end, mode = "i", },
  { "<c-n>", function() require("neocodeium").cycle_or_complete() end, mode = "i", },
  { "<c-p>", function() require("neocodeium").cycle_or_complete() end, mode = "i", },
  { "<c-h>", function() require("neocodeium").clear() end, mode = "i", },
}
-- stylua: ignore end

return M
