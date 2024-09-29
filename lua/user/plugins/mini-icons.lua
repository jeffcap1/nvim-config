local M = {
  "echasnovski/mini.icons",
  version = false, -- Set to main branch, use version = '*' for stable version
  -- event = "VeryLazy",
}

function M.config()
  local MiniIcons = require("mini.icons")

  MiniIcons.setup({
    -- Icon style: 'glyph' or 'ascii'
    style = "glyph",
    extension = {
      astro = {
        glyph = "",
        hl = "MiniIconsOrange",
      },
    },
  })

  MiniIcons.mock_nvim_web_devicons()
end

return M
