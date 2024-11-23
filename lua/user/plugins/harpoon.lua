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

M.keys = function()
  local harpoon = require("harpoon")

  -- stylua: ignore
  local keymaps = {
    { "<leader>hm", function() harpoon:list():add() end, desc = "Harpoon Mark File", },
    { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Toggle UI", },

    -- Toggle previous & next buffers stored within Harpoon list
    { "]f", function() harpoon:list():next() end, desc = "Next Harpoon File" },
    { "[f", function() harpoon:list():prev() end, desc = "Previous Harpoon File" },
  }

  -- hop to files 1-4 in the list
  for i = 1, 5 do
    table.insert(keymaps, {
      "<leader>h" .. i,
      function()
        harpoon:list():select(i)
      end,
      desc = "Harpoon File " .. i,
    })
  end

  return keymaps
end

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
end

return M
