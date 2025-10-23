local M = {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
  },
}

M.keys = {
  { "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
}

---@module 'oil'
---@type oil.SetupOpts
M.opts = {
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, _)
      return name == ".."
    end,
  },
  win_options = {
    wrap = false,
    signcolumn = "yes:2",
  },
  float = {
    max_height = 40,
    max_width = 200,
  },
}

return M
