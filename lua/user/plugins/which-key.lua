local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300,
  },
}

M.opts.spec = {
  { "<leader>_", "<cmd>res<CR>", desc = "Zoom horizontal split", icon = " " },
  { "<leader>|", "<cmd>vert res<CR>", desc = "Zoom vertical split", icon = " " },
  { "<leader>b", group = "Buffers" },
  { "<leader>c", group = "Comments", icon = "󰭹 " },
  { "<leader>d", group = "Debug" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "Harpoon", icon = "󱡅 " },
  {
    "<leader>l",
    group = "LSP",
    icon = "󰚩 ",
    { "<leader>lc", group = "Choose" },
    { "<leader>lf", group = "Format" },
  },
  { "<leader>p", group = "Project", icon = " " },
  { "<leader>s", "<cmd>split<CR>", desc = "Split", icon = " " },
  {
    "<leader>t",
    group = "Tab",
    { "<leader>tH", "<cmd>-tabmove<cr>", desc = "Move Left" },
    { "<leader>tL", "<cmd>+tabmove<cr>", desc = "Move Right" },
    { "<leader>tN", "<cmd>tabnew %<cr>", desc = "New Tab" },
    { "<leader>th", "<cmd>tabnext<cr>", desc = "Go to Left" },
    { "<leader>tl", "<cmd>tabprev<cr>", desc = "Go to Right" },
    { "<leader>tn", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    { "<leader>to", "<cmd>tabonly<cr>", desc = "Only" },
  },
  -- allows copying to system clipboard
  { "<leader>y", '"+y', mode = { "n", "v" }, desc = "Yank to clipboard", icon = "󰅇 " },
  { "<leader>v", "<cmd>vsplit<CR>", desc = "Split", icon = " " },
  {
    "<leader>w",
    function()
      vim.wo.wrap = not vim.wo.wrap
      vim.notify("Word wrap " .. (vim.wo.wrap and "enabled" or "disabled"))
    end,
    desc = "Toggle word wrap",
    icon = "󰖶 ",
  },
  { "<leader>x", group = "Trouble", icon = " " },
  { "<leader><leader>", group = "Settings", icon = " " },
  -- { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha" },
  -- { "<leader>t;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
  -- { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
}

return M
