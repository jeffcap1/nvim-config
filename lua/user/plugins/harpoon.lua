local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local harpoon = require("harpoon")

  -- REQUIRED
  harpoon:setup({})
  -- REQUIRED

  local keymaps = {
    {"n", "<leader>hm", function() harpoon:list():append() end, { desc = "Harpoon Mark File" }},
    {"n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Toggle UI" }},

    -- hop to files 1-4 in the list
    {"n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" }},
    {"n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" }},
    {"n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" }},
    {"n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" }},

    -- Toggle previous & next buffers stored within Harpoon list
    {"n", "<c-s-j>", function() harpoon:list():prev() end, { desc = "Harpoon Next File" }},
    {"n", "<c-s-k>", function() harpoon:list():next() end, { desc = "Harpoon Prev File" }},

  }

  for _, keymap in ipairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], XTND(keymap[4]))
  end
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify("󱡅  marked file")
end

return M
