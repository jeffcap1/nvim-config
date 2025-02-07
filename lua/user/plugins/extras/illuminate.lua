local M = {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
}

function M.config()
  require("illuminate").configure({
    filetypes_denylist = {
      "mason",
      "harpoon",
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
      "snacks_input",
      "snacks_select",
      "DressingInput",
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
