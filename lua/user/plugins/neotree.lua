return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup({
      window = {
        mappings = {
          ["<space>"] = {
            "toggle_node",
            nowait = true, -- don't wait for leader key
          },
        }
      }
    })
    vim.keymap.set('n', '<C-[>', ':Neotree filesystem reveal left<CR>', {})
  end
}
