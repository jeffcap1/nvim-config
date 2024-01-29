local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

local function xtnd(opt1, opt2)
  return vim.tbl_extend("force", opt1, opt2)
end

function M.config()
  local opts = { noremap = true, silent = true }
  local keymaps = {
    { "n", "<s-m>", "<cmd>lua require('user.plugins.harpoon').mark_file()<cr>", { desc = "Harpoon Mark File" } },
    { "n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Harpoon Toggle UI" } },
    { "n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { desc = "Harpoon File 1" }},
    { "n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { desc = "Harpoon File 2" }},
    { "n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { desc = "Harpoon File 3" }},
    { "n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { desc = "Harpoon File 4" }},
  }

  for _, keymap in ipairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], xtnd(opts, keymap[4]))
  end
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify("󱡅  marked file")
end

return M
