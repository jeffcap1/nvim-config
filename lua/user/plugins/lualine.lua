local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
  local function show_codeium_status()
    if vim.g.loaded_codeium then
      return "{…}" .. vim.fn["codeium#GetStatusString"]()
    else
      return ""
    end
  end

  require "lualine".setup {
    options = {
      -- theme = "dracula",
      theme = "catppuccin",
    },

    { show_codeium_status },
    sections = {
      lualine_y = { "copilot", show_codeium_status, "progress", "selectioncount" },
      lualine_z = { "location" },
    },
  }
end

return M
