local M = {
  "chentoast/marks.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
  excluded_filetypes = {
    "alpha",
    "DiffviewFiles",
    "dirvish",
    "DressingInput",
    "DressingSelect",
    "fugitive",
    "harpoon",
    "Jaq",
    "lazy",
    "lir",
    "mason",
    "minifiles",
    "NeogitStatus",
    "netrw",
    "NvimTree",
    "oil",
    "Outline",
    "qf",
    "snacks_dashboard",
    "snacks_input",
    "snacks_picker_list",
    "snacks_select",
    "snacks_terminal",
    "spectre_panel",
    "TelescopePrompt",
    "snacks_picker_input",
    "snacks_picker_preview",
    "snacks_picker_list",
    "snacks_terminal",
    "snacks_explorer",
    "toggleterm",
    "Trouble",
  },
}

return M
