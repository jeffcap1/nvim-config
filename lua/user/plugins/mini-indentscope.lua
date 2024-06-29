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
  },
  options = {
    try_as_border = true,
  },
  symbol = icons.ui.BoldLineDashedMiddle,
}

M.init = function()
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufNewFile" }, {
    pattern = {
      "alpha",
      "dashboard",
      "fzf",
      "help",
      "lazy",
      "lazyterm",
      "mason",
      "neo-tree",
      "notify",
      "toggleterm",
      "Trouble",
      "trouble",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end

return M
