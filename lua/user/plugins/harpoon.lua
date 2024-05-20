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
  harpoon:setup({
    settings = {
      save_on_toggle = true,
    },
  })

  harpoon:extend({
    ADD = function()
      vim.notify("󱡅  marked file")
    end,
  })

  local keymaps = {
    { "n", "<leader>hm", function() harpoon:list():add() end,                         { desc = "Harpoon Mark File" } },
    { "n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Toggle UI" } },

    -- hop to files 1-4 in the list
    { "n", "<leader>h1", function() harpoon:list():select(1) end,                     { desc = "Harpoon File 1" } },
    { "n", "<leader>h2", function() harpoon:list():select(2) end,                     { desc = "Harpoon File 2" } },
    { "n", "<leader>h3", function() harpoon:list():select(3) end,                     { desc = "Harpoon File 3" } },
    { "n", "<leader>h4", function() harpoon:list():select(4) end,                     { desc = "Harpoon File 4" } },
    { "n", "<leader>h5", function() harpoon:list():select(5) end,                     { desc = "Harpoon File 5" } },

    -- Toggle previous & next buffers stored within Harpoon list
    { "n", "<leader>hn", function() harpoon:list():next() end,                        { desc = "Harpoon Next File" } },
    { "n", "<leader>hp", function() harpoon:list():prev() end,                        { desc = "Harpoon Prev File" } },

  }

  for _, keymap in ipairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], XTND(keymap[4]))
  end
end

return M
