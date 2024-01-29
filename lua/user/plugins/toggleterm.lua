local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
}

function M.config()
  require("toggleterm").setup({
    open_mapping = [[<C-/>]],
    direction = "float",
  })

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

  vim.api.nvim_set_keymap(
    "n",
    "<leader>tg",
    "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
    { noremap = true, silent = true, desc = "Lazy Git Terminal" }
  )
end

return M
