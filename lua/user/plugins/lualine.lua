local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
    "monkoose/neocodeium",
  },
}

-- NeoCodeium Status
-- @see https://www.reddit.com/r/neovim/comments/1fc34na/comment/lm5wr1j/?rdt=59883
local function get_codeium_status()
  local status, serverstatus = require("neocodeium").get_status()

  -- Tables to map serverstatus and status to corresponding symbols
  local server_status_symbols = {
    [0] = "󰣺 ", -- Connected
    [1] = "󱤚 ", -- Connecting
    [2] = "󰣽 ", -- Disconnected
  }

  local status_symbols = {
    [0] = "󰚩 ", -- Enabled
    [1] = "󱚧 ", -- Disabled Globally
    [3] = "󱚢 ", -- Disabled for Buffer filetype
    [5] = "󱚠 ", -- Disabled for Buffer encoding
    [2] = "󱙻 ", -- Disabled for Buffer (catch-all)
  }

  -- Handle serverstatus and status fallback (safeguard against any unexpected value)
  local luacodeium = server_status_symbols[serverstatus] or "󰣼 "
  luacodeium = luacodeium .. (status_symbols[status] or "󱚧 ")

  return luacodeium
end

local function show_codeium_status()
  local status = get_codeium_status()
  if status ~= "󰣼 󱚧 " then
    return status
  else
    return ""
  end
end

local function show_copilot_status()
  if vim.g.loaded_copilot then
    return "copilot"
  else
    return ""
  end
end

M.opts = {
  options = {
    -- theme = "dracula",
    theme = "catppuccin",
  },

  sections = {
    lualine_y = { show_copilot_status, show_codeium_status, "progress", "selectioncount" },
    lualine_z = { "location" },
  },
}

return M
