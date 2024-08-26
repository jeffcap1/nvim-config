local M = {
  "Exafunction/codeium.vim",
  cmd = "Codeium",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
}

M.config = function()
  vim.g.codeium_disable_bindings = 1
  vim.g.codeium_enable_chat = 1
  vim.g.codeium_filetypes = {
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  }

  vim.keymap.set("i", "<C-l>", function()
    vim.notify "accepting codeium suggestion"
    return vim.fn["codeium#Accept"]()
  end, { expr = true, silent = true })

  vim.keymap.set("i", "<c-n>", function()
    return vim.fn["codeium#CycleCompletions"](1)
  end, { expr = true, silent = true })

  vim.keymap.set("i", "<c-p>", function()
    return vim.fn["codeium#CycleCompletions"](-1)
  end, { expr = true, silent = true })

  vim.keymap.set("i", "<c-h>", function()
    return vim.fn["codeium#Clear"]()
  end, { expr = true, silent = true })
end

return M
