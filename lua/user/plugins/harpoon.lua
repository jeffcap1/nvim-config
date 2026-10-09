local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

M.opts = {
  settings = {
    save_on_toggle = true,
  },
}

local function list()
  return require("harpoon"):list()
end

-- stylua: ignore
M.keys = {
  { "<leader>hm", function() list():add() end, desc = "Harpoon Mark File", },
  { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(list()) end, desc = "Harpoon Toggle UI", },

  -- Toggle previous & next buffers stored within Harpoon list
  { "]f", function() list():next() end, desc = "Next Harpoon File" },
  { "[f", function() list():prev() end, desc = "Previous Harpoon File" },
}
-- stylua: ignore end

-- hop to files 1-5 in the list
for i = 1, 5 do
  table.insert(M.keys, {
    "<leader>h" .. i,
    function()
      list():select(i)
    end,
    desc = "Harpoon File " .. i,
  })
end

function M.config(_, opts)
  local harpoon = require("harpoon")

  -- REQUIRED
  harpoon:setup(opts)

  harpoon:extend({
    ADD = function()
      vim.notify("󱡅  marked file")
    end,
  })
end

return M
