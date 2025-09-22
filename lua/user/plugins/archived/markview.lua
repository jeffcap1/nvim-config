local M = {
  "OXY2DEV/markview.nvim",
  enabled = true,
  -- lazy = false, -- Recommended lazy = false to stop lazy loading
  ft = { "markdown", "Avante", "quarto", "norg", "rmd", "org", "vimwiki" }, -- If you decide to lazy-load anyway
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
}

M.opts = {
  filetypes = { "markdown", "Avante", "quarto", "norg", "rmd", "org", "vimwiki" },
  debounce = 100,
  -- max_length = 99999,
  -- buf_ignore = {},
  callbacks = {
    on_enable = function(buf, win)
      NOTIFY.INFO("markview on_enable!")
    end,
  },
}

return M
