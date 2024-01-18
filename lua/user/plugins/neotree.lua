local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
}
function M.config()
  require("neo-tree").setup({
    window = {
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = true, -- don't wait for leader key
        },
      },
    },
  })
  vim.keymap.set("n", "<A-[>", ":Neotree filesystem reveal left<CR>", { desc = "Neotree Open Filesystem" })
  vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", { desc = "Neotree Open Buffers" })
end

return M
