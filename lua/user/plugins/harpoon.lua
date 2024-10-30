local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

M.opts = {
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  },
  settings = {
    save_on_toggle = true,
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
    {
      "n",
      "<leader>hm",
      function()
        harpoon:list():add()
      end,
      { desc = "Harpoon Mark File" },
    },
    {
      "n",
      "<leader>hh",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      { desc = "Harpoon Toggle UI" },
    },

    -- Toggle previous & next buffers stored within Harpoon list
    {
      "n",
      "<leader>hn",
      function()
        harpoon:list():next()
      end,
      { desc = "Harpoon Next File" },
    },
    {
      "n",
      "<leader>hp",
      function()
        harpoon:list():prev()
      end,
      { desc = "Harpoon Prev File" },
    },
  }

  -- hop to files 1-4 in the list
  for i = 1, 5 do
    table.insert(keymaps, {
      "n",
      "<leader>h" .. i,
      function()
        harpoon:list():select(i)
      end,
      { desc = "Harpoon File " .. i },
    })
  end

  for _, keymap in ipairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], XTND(keymap[4]))
  end
end

return M
