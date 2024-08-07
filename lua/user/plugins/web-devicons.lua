local M = {
  "nvim-tree/nvim-web-devicons",
}

M.config = function()
  require("nvim-web-devicons").setup({
    strict = true,
    override_by_extension = {
      astro = {
        icon = "",
        color = "#EF8547",
        name = "astro",
      },
    },
  })
end

return M
