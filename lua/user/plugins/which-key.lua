local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
}

M.keys = {

  { "<leader>_", "<cmd>res<CR>", desc = "Zoom horizontal split" },
  { "<leader>|", "<cmd>vert res<CR>", desc = "Zoom vertical split" },
  -- { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha" },
  { "<leader>b", group = "Buffers" },
  { "<leader>c", group = "Comments" },
  { "<leader>d", group = "Debug" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "Harpoon", icon = "󱡅 " },
  { "<leader>l", group = "LSP" },
  { "<leader>lc", group = "Choose" },
  { "<leader>lf", group = "Format" },
  { "<leader>p", group = "Proect" },
  { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
  { "<leader>s", "<cmd>split<CR>", desc = "Split" },
  { "<leader>t", group = "Tab" },
  { "<leader>tH", "<cmd>-tabmove<cr>", desc = "Move Left" },
  { "<leader>tL", "<cmd>+tabmove<cr>", desc = "Move Right" },
  { "<leader>tN", "<cmd>tabnew %<cr>", desc = "New Tab" },
  { "<leader>th", "<cmd>tabnext<cr>", desc = "Go to Left" },
  { "<leader>tl", "<cmd>tabprev<cr>", desc = "Go to Right" },
  { "<leader>tn", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
  { "<leader>to", "<cmd>tabonly<cr>", desc = "Only" },
  -- { "<leader>t;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
  { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
  { "<leader>x", group = "Trouble" },
}

--[[ function M.config()
  local mappings = {
    ["|"] = { "<cmd>vert res<CR>", "Zoom vertical split" },
    ["_"] = { "<cmd>res<CR>", "Zoom horizontal split" },
    v = { "<cmd>vsplit<CR>", "Split" },
    s = { "<cmd>split<CR>", "Split" },
    q = { "<cmd>confirm q<CR>", "Quit" },
    -- h = { "<cmd>nohlsearch<CR>", "NOHL" },
    h = { name = "Harpoon" },
    a = { "<cmd>Alpha<cr>", "Alpha" },
    b = { name = "Buffers" },
    c = { name = "Comments" },
    d = { name = "Debug" },
    f = { name = "Find" },
    g = { name = "Git" },
    l = {
      name = "LSP",
      f = { name = "Format" },
      c = { name = "Choose" },
    },
    p = { name = "Project" },
    x = { name = "Trouble" },
    t = {
      name = "Tab",
      [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
      n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      N = { "<cmd>tabnew %<cr>", "New Tab" },
      o = { "<cmd>tabonly<cr>", "Only" },
      h = { "<cmd>tabnext<cr>", "Go to Left" },
      l = { "<cmd>tabprev<cr>", "Go to Right" },
      H = { "<cmd>-tabmove<cr>", "Move Left" },
      L = { "<cmd>+tabmove<cr>", "Move Right" },
    },
    -- T = { name = "Treesitter" },
  }


  local which_key = require "which-key"

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end ]]

return M
