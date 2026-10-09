local M = {
  "nvim-lualine/lualine.nvim",
}

-- Only show AI status for plugins spec'd on this machine (see plugins/local_only).
-- `cond` waits until the plugin is actually loaded so lualine never forces a load.
local function is_spec(name)
  return require("lazy.core.config").plugins[name] ~= nil
end

local function is_loaded(module)
  return function()
    return package.loaded[module] ~= nil
  end
end

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

function M.opts()
  local lualine_y = {}

  -- copilot-lualine component is provided by user.plugins.extras.copilot
  if is_spec("copilot.lua") and is_spec("copilot-lualine") then
    table.insert(lualine_y, { "copilot", cond = is_loaded("copilot") })
  end

  if is_spec("neocodeium") then
    table.insert(lualine_y, { show_codeium_status, cond = is_loaded("neocodeium") })
  end

  vim.list_extend(lualine_y, { "progress", "selectioncount" })

  return {
    options = {
      -- theme = "dracula",
      theme = "catppuccin-nvim",
    },

    sections = {
      lualine_y = lualine_y,
      lualine_z = { "location" },
    },
  }
end

return M
