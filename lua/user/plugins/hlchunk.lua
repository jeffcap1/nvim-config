local M = {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  local icons = require("user.icons")
  local exclusions = {
    aerial = true,
    checkhealth = true,
    dashboard = true,
    fzf = true,
    gitcommit = true,
    gitrebase = true,
    help = true,
    lazy = true,
    lspinfo = true,
    man = true,
    neogitstatus = true,
    notify = true,
    NvimTree = true,
    qf = true,
    quickfix = true,
    startify = true,
    TelescopePrompt = true,
    TelescopeResults = true,
    text = true,
    Trouble = true,
    -- [""] = true,
  }

  require("hlchunk").setup({
    chunk = {
      enable = true,
      exclude_filetypes = exclusions,
      style = "#00ffff",
      chars = {
        right_arrow = icons.ui.TriangleShortArrowRightNoSpace,
      },
    },
    indent = {
      enable = true,
      exclude_filetypes = exclusions,
      chars = {
        icons.ui.BoldLineDashedMiddle,
      },
      style = {
        vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
      },
    },
    blank = {
      enable = false,
      exclude_filetypes = exclusions,
    },
    line_num = {
      enable = true,
      exclude_filetypes = exclusions,
    },
  })
end

return M
