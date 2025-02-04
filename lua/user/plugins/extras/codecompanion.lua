local M = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "CodeCompanion" },
      },
      ft = { "markdown", "norg", "rmd", "org", "vimwiki", "CodeCompanion" },
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
