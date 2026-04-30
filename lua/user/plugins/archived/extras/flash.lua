local M = {
  "folke/flash.nvim",
  event = "VeryLazy",
}

-- stylua: ignore
M.keys = {
  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
}
-- stylua: ignore end

---@type Flash.Config
M.opts = {
  labels = "fghjklqwetyupzcvbnm", -- no aiorx
  search = {
    -- Search for me adds a protection layer, so if you mistype a word, it
    -- doesn't exit
    mode = "search",
  },
  modes = {
    char = {
      jump_labels = true,
    },
  },
}

return M
