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
    "<leader><tab>",
    group = "Tab",
    { "<leader><tab>h", "<cmd>-tabmove<cr>", desc = "Move Left" },
    { "<leader><tab>l", "<cmd>+tabmove<cr>", desc = "Move Right" },
    { "<leader><tab>N", "<cmd>tabnew %<cr>", desc = "New Tab" },
    { "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Next Tab" },
    { "<leader><tab>[", "<cmd>tabprev<cr>", desc = "Previous Tab" },
    { "<leader><tab>n", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    { "<leader><tab>o", "<cmd>tabonly<cr>", desc = "Only" },
  },
  -- allows copying to system clipboard
  { "<leader>y", '"+y', mode = { "n", "v" }, desc = "Yank to clipboard", icon = "󰅇 " },
  { "<leader>v", "<cmd>vsplit<CR>", desc = "Split", icon = " " },
  {
    "<leader><space>w",
    function()
      vim.wo.wrap = not vim.wo.wrap
      vim.notify("Word wrap " .. (vim.wo.wrap and "enabled" or "disabled"))
    end,
    desc = "Toggle word wrap",
    icon = "󰖶 ",
  },
  { "<leader>x", group = "Trouble", icon = " " },
  { "<leader><leader>", group = "Settings", icon = " " },
  -- { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
}

M.keys = {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps (which-key)",
  },
  { "b]", "<cmd>bnext<cr>", desc = "Next Buffer" },
  { "b[", "<cmd>bprev<cr>", desc = "Previous Buffer" },
}

return M
