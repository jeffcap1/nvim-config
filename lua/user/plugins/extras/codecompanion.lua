local M = {
  "olimorris/codecompanion.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "codecompanion" },
      },
      ft = { "markdown", "norg", "rmd", "org", "vimwiki", "codecompanion" },
    },
  },
}

M.opts = {
  strategies = {
    chat = {
      adapter = "gemini",
    },
  },
  opts = {
    -- Set debug logging
    log_level = "DEBUG",
  },
  adapters = {
    anthropic = function()
      return require("codecompanion.adapters").extend("gemini", {
        schema = {
          model = {
            default = "gemini-2.0-flash-exp",
          },
        },
      })
    end,
  },
}

return M
