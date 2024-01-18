local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  local config = require("nvim-treesitter.configs")
  config.setup({
    -- these will always be installed on any system
    ensure_installed = {
      "bash",
      "css",
      "git_config",
      "git_rebase",
      "html",
      "javascript",
      "json5",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "sql",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    -- automatically install new languages
    auto_install = true,
    -- disable synchronously installation
    sync_install = false,
    modules = {},
    ignore_install = {},
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
