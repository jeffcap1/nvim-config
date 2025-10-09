local M = {
  "olimorris/codecompanion.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "norg", "rmd", "org", "vimwiki", "codecompanion" },
      },
      ft = { "markdown", "norg", "rmd", "org", "vimwiki", "codecompanion" },
    },
  },
}

local copilot_dir = vim.fn.expand("~/.config/github-copilot")
local copilot_available = vim.fn.isdirectory(copilot_dir) == 1

M.opts = {
  strategies = {
    chat = {
      adapter = copilot_available and "copilot" or "gemini",
    },
    inline = {
      adapter = copilot_available and "copilot" or "gemini",
    },
  },
  opts = {
    -- Set debug logging
    log_level = "DEBUG",
  },
  adapters = {
    http = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-2.0-flash-exp",
            },
          },
        })
      end,
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {})
      end,
    },
  },
}

return M
