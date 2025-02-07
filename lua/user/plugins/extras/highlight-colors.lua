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
      "mason",
      "help",
      "startify",
      "dashboard",
      -- "markdown"
      "harpoon",
      "DressingInput",
      "NeogitCommitMessage",
      "qf",
      "dirvish",
      "oil",
      "minifiles",
      "fugitive",
      "alpha",
      "NvimTree",
      "lazy",
      "NeogitStatus",
      "Trouble",
      "netrw",
      "lir",
      "DiffviewFiles",
      "Outline",
      "Jaq",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
      "snacks_picker_input",
      "snacks_picker_preview",
      "snacks_picker_list",
      "snacks_terminal",
      "snacks_explorer",
    },
  })
end

return M
