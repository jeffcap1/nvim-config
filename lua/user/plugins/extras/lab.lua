local M = {
  "0x100101/lab.nvim",
  event = { "BufReadPost", "BufNewFile" },
  build = "cd js && npm ci",
}

function M.config()
  require("lab").setup({
    code_runner = {
      enabled = true,
    },
    quick_data = {
      enabled = false,
    },
  })
end

return M
