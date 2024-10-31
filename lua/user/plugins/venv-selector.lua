local M = {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python", --optional
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  -- lazy = false,
  event = "VeryLazy",
  ft = { "python" },
  branch = "regexp", -- This is the regexp branch, use this for the new version
}

M.opts = {
  settings = {
    options = {
      notify_user_on_venv_activation = true,
    },
  },
}

M.keys = {
  { "<leader>lcv", "<cmd>:VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" },
}

return M
