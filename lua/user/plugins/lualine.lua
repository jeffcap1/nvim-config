local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
  require("lualine").setup({
    options = {
      theme = "dracula",
      -- theme = "catppuccin",
    },
    sections = {
      lualine_y = { "copilot", "progress" },
    },
  })
end

return M
