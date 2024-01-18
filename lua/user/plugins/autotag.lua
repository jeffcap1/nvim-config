local M = {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
}

function M.config()
  require("nvim-ts-autotag").setup()
end

return M
