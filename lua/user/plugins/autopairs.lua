local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
}

M.config = function()
  require("nvim-autopairs").setup({
    check_ts = true,
    disable_filetype = {
      "TelescopePrompt",
      "spectre_panel",
      "snacks_picker_input",
      "snacks_picker_preview",
      "snacks_picker_list",
      "snacks_input",
    },
  })
end

return M
