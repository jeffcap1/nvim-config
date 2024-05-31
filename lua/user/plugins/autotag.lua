local M = {
  "windwp/nvim-ts-autotag",
}

function M.config()
  require "nvim-ts-autotag".setup {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
  }
end

return M
