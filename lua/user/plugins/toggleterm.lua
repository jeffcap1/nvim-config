local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
}

function M.config()
  require("toggleterm").setup({
    open_mapping = [[<c-;>]],
    direction = "float",
  })

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
  local keymap = vim.keymap.set

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

  keymap("n", "<leader>;", "<cmd>:ToggleTerm<cr>", XTND({ desc = "Toggle Floating Terminal" }))
  keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", XTND({ desc = "Lazy Git Terminal" }))
end

return M
