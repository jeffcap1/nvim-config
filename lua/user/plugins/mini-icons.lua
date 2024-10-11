local M = {
  "echasnovski/mini.icons",
  version = false, -- Set to main branch, use version = '*' for stable version
  event = "VeryLazy",
}

function M.config()
  local MiniIcons = require("mini.icons")

  -- stylua: ignore
  MiniIcons.setup({
    -- Icon style: 'glyph' or 'ascii'
    style = "glyph",
    extension = {
      astro = { glyph = " ", hl = "MiniIconsOrange", },
    },
    file = {
      [".nvmrc"] = { glyph = " ", hl = "MiniIconsGreen", },
      ["tmux.conf"] = { glyph = " ", hl = "MiniIconsGreen", },

      -- js
      [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
      ["eslint.config.mjs"] = { glyph = "󰱺 ", hl = "MiniIconsPurple", },
      [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
      [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
      [".prettierignore"] = { glyph = " ", hl = "MiniIconsGray", },
      [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
      ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
      ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
      ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
      ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
      ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
    },
  })

  MiniIcons.mock_nvim_web_devicons()
end

return M
