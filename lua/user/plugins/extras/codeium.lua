local M = {
  "monkoose/neocodeium",
  event = "VeryLazy",
}

M.config = function()
  local neocodeium = require("neocodeium")

  neocodeium.setup({
    filetypes = {
      -- markdown = true,
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
  })

  vim.keymap.set("i", "<C-l>", function()
    vim.notify("accepting codeium suggestion")
    return neocodeium.accept()
  end, { expr = true, silent = true })

  vim.keymap.set("i", "<c-n>", function()
    return neocodeium.cycle_or_complete()
  end, { expr = true, silent = true })

  vim.keymap.set("i", "<c-p>", function()
    return neocodeium.cycle_or_complete(-1)
  end, { expr = true, silent = true })

  vim.keymap.set("i", "<c-h>", function()
    return neocodeium.clear()
  end, { expr = true, silent = true })
end

return M
