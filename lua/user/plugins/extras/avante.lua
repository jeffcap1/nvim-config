local function check_architecture()
  -- Execute the 'uname -m' command to get the system architecture
  local handle = io.popen("uname -m")

  if handle == nil then
    return "Failed to execute 'uname -m'"
  end

  local architecture = handle:read("*a")
  handle:close()

  -- Trim any trailing whitespace from the output
  architecture = architecture:gsub("%s+", "")

  -- Check if the architecture is arm64 or x86_64
  if architecture == "arm64" then
    return "arm"
  elseif architecture == "x86_64" then
    return "intel"
  else
    return "Unknown architecture: " .. architecture
  end
end

local function get_build_function()
  local arch = check_architecture()
  if arch == "intel" then
    return "make BUILD_FROM_SOURCE=true"
  else
    return "make"
  end
end

local M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = get_build_function(),
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.icons", -- or "nvim-tree/nvim-web-devicons"
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      "OXY2DEV/markview.nvim",
      enabled = true,
      lazy = false,
      ft = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
      opts = {
        filetypes = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
        buf_ignore = {},
        max_length = 99999,
      },
    },
  },
}

M.opts = {
  provider = "gemini", -- Recommend using Claude
  -- auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
  gemini = {
    -- @see https://ai.google.dev/gemini-api/docs/models/gemini
    model = "gemini-1.5-pro-exp-0827",
    -- model = "gemini-1.5-flash",
    temperature = 0,
    max_tokens = 4096,
  },
  mappings = {
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<M-y>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-e>",
    },
    sidebar = {
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
    },
  },
}

return M
