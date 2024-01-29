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
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.cmd([[
          setlocal relativenumber
        ]])
        end,
      },
    },
    window = {
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = true, -- don't wait for leader key
        },
      },
    },
  })
  vim.keymap.set(
    "n",
    "<m-[>",
    ":Neotree filesystem reveal left<cr>",
    { silent = true, noremap = true, desc = "Neotree Open Filesystem" }
  )
  vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<cr>", { desc = "Neotree Open Buffers" })
end

return M
