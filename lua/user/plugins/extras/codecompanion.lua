local M = {
  "olimorris/codecompanion.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

-- determine which mcp file to use based on if local exists or not
local local_config = vim.fn.stdpath("config") .. "/mcp/local.servers.json"
local default_config = vim.fn.stdpath("config") .. "/mcp/servers.json"
local mcp_config = vim.fn.filereadable(local_config) == 1 and local_config or default_config

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "norg", "rmd", "org", "vimwiki", "codecompanion" },
    },
    ft = { "markdown", "norg", "rmd", "org", "vimwiki", "codecompanion" },
  },
  -- better mcp server support as native support is very limited/basic
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    opts = {
      config = mcp_config,
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
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://127.0.0.1:11434",
          },
          schema = {
            model = {
              default = "gemma4:12b",
            },
          },
        })
      end,
    },
  },
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_tools = true,
        make_vars = false,
        make_slash_commands = true,
        show_result_in_chat = true,
      },
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
