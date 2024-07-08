local M = {
  "echasnovski/mini.indentscope",
  version = false,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
}

local icons = require("user.icons")
M.opts = {
  draw = {
    delay = 0,
    priority = 2,
    animation = function()
      return 0
    end,
  },
  options = {
    try_as_border = true,
  },
  symbol = icons.ui.BoldLineDashedMiddle,
}

M.init = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "alpha",
      "dashboard",
      "DiffviewFiles",
      "dirvish",
      "DressingInput",
      "DressingSelect",
      "fugitive",
      "fzf",
      "harpoon",
      "help",
      "Jaq",
      "lazy",
      "lazyterm",
      "lir",
      "mason",
      "minifiles",
      "neo-tree",
      "NeogitCommitMessage",
      "NeogitStatus",
      "netrw",
      "notify",
      "NvimTree",
      "oil",
      "Outline",
      "qf",
      "spectre_panel",
      "startify",
      "TelescopePrompt",
      "toggleterm",
      "Trouble",
      "trouble",
      -- "markdown"
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

return M
