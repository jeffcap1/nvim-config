local M = {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  require "nvim-highlight-colors".setup {
    render = "virtual",
    virtual_symbol = "■",
    enable_named_colors = false,
    enable_tailwind = true,
  }

  -- require("colorizer").setup({
  --   filetypes = {
  --     "typescript",
  --     "typescriptreact",
  --     "javascript",
  --     "javascriptreact",
  --     "css",
  --     "html",
  --     "astro",
  --     "lua",
  --   },
  --   user_default_options = {
  --     names = false,
  --     rgb_fn = true,
  --     hsl_fn = true,
  --     tailwind = "both",
  --   },
  --   buftypes = {},
  -- })
end

return M
