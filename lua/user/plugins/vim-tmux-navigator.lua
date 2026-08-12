local M = {
  "christoomey/vim-tmux-navigator",

  -- Load immediately so the TmuxNavigate* commands are available
  -- when the shared navigation function needs them.
  lazy = false,

  init = function()
    -- We provide our own Alt+h/j/k/l mappings below.
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_no_wrap = 1
  end,
}

M.config = function()
  local directions = {
    left = {
      wincmd = "h",
      tmux_command = "TmuxNavigateLeft",
    },
    down = {
      wincmd = "j",
      tmux_command = "TmuxNavigateDown",
    },
    up = {
      wincmd = "k",
      tmux_command = "TmuxNavigateUp",
    },
    right = {
      wincmd = "l",
      tmux_command = "TmuxNavigateRight",
    },
  }

  local function navigate(direction)
    local config = directions[direction]
    local previous_window = vim.api.nvim_get_current_win()

    -- First try to move between Neovim windows.
    vim.cmd("wincmd " .. config.wincmd)

    if vim.api.nvim_get_current_win() ~= previous_window then
      return
    end

    -- We reached a Neovim edge. Prefer Herdr when running inside it.
    if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
      local herdr = vim.env.HERDR_BIN_PATH

      if not herdr or herdr == "" then
        herdr = "herdr"
      end

      vim.system({
        herdr,
        "pane",
        "focus",
        "--direction",
        direction,
        "--current",
      })

      return
    end

    -- Otherwise fall back to vim-tmux-navigator when inside tmux.
    if vim.env.TMUX and vim.env.TMUX ~= "" then
      vim.cmd(config.tmux_command)
    end
  end

  local mappings = {
    { "<M-h>", "left" },
    { "<M-j>", "down" },
    { "<M-k>", "up" },
    { "<M-l>", "right" },
  }

  for _, mapping in ipairs(mappings) do
    local lhs, direction = mapping[1], mapping[2]

    vim.keymap.set("n", lhs, function()
      navigate(direction)
    end, {
      silent = true,
      desc = "Navigate " .. direction .. " (Neovim/Herdr/tmux)",
    })
  end

  -- Keep your previous-pane mapping for tmux.
  -- Herdr's plugin currently exposes only directional navigation.
  vim.keymap.set("n", "<M-\\>", "<cmd>TmuxNavigatePrevious<CR>", {
    silent = true,
    desc = "Navigate to previous tmux pane",
  })
end

return M
