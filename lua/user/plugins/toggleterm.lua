local M = {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  version = "*",
}

M.keys = {
  { "m-;", "<cmd>:ToggleTerm<cr>", desc = "Toggle Floating Terminal", silent = true, noremap = true },
  -- { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazy Git Terminal", silent = true, noremap = true },
}

function M.config()
  require("toggleterm").setup({
    open_mapping = [[<m-;>]],
    direction = "float",
  })

  --[[ local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end ]]
end

return M
