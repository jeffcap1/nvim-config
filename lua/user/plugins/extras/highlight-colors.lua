local M = {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  require("nvim-highlight-colors").setup({
    render = "virtual",
    virtual_symbol = "■",
    enable_named_colors = false,
    enable_tailwind = true,
    exclude_filetypes = {
      "harpoon",
      "help",
      "lazy",
      "mason",
      -- "markdown"
      "netrw",
      "oil",
      "qf",
      "snacks_dashboard",
      "snacks_explorer",
      "snacks_picker_input",
      "snacks_picker_list",
      "snacks_picker_preview",
      "snacks_terminal",
      "trouble",
    },
  })
end

return M
