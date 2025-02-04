local M = {
  "chentoast/marks.nvim",
  event = "VeryLazy",
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
    "toggleterm",
    "Trouble",
  },
}

return M
