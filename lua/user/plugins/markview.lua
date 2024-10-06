local M = {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended
  ft = { "markdown", "Avante" }, -- If you decide to lazy-load anyway

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
}

M.opts = {
  filetypes = { "markdown", "Avante", "quarto", "rmd" },
  -- filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
  -- buf_ignore = {},
  -- max_length = 99999,
}

return M
