local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
}

function M.config()
  require("toggleterm").setup({
    open_mapping = [[<C-/>]],
    direction = "float",
  })
end

return M
