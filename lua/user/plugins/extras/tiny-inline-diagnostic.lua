local M = {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
}

M.config = function()
  require("tiny-inline-diagnostic").setup({
    transparent_bg = true,
    options = {
      show_all_diags_on_cursorline = true,
      add_messages = {
        display_count = true,
      },
      multilines = {
        enabled = true,
      },
    },
  })
  vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
end

return M
