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

M.keys = {
  { "<leader>cc", ":CodeCompanionChat<CR>", desc = "Code Companion Chat" },
  { "<leader>cm", ":CodeCompanionChat<CR>", desc = "Code Companion Chat" },
  { "<leader>ci", ":CodeCompanion<CR>", desc = "Code Companion Inline" },
  { "<leader>ca", ":CodeCompanionActions<CR>", desc = "Code Companion Inline" },
  { "<leader>cr", ":CodeCompanionCmd<CR>", desc = "Code Companion Run Command" },
}

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
  interactions = {
    chat = {
      keymaps = {
        send = {
          modes = { n = "<CR>", i = "<C-CR>" },
        },
        stop = {
          modes = { n = "e" },
        },
      },
    },
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "codecompanion",
  callback = function()
    -- Defer to ensure plugin mappings are loaded first, then override
    vim.defer_fn(function()
      vim.keymap.set("n", "q", ":close<CR>", { buffer = true, noremap = true, silent = true })
    end, 50)
  end,
})

return M
