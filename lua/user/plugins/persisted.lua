local M = {
  "olimorris/persisted.nvim",
  lazy = false,
}

M.opts = {
  autostart = true, -- Automatically start the plugin on load?
  follow_cwd = true, -- Change the session file to match any change in the cwd?
  use_git_branch = true, -- Include the git branch in the session file name?
  autoload = true, -- Automatically load the session for the cwd on Neovim startup?

  -- Function to run when `autoload = true` but there is no session to load
  on_autoload_no_session = function()
    vim.notify("No existing session to load.")
  end,

  -- Table of dirs that are ignored for starting and autoloading
  ignored_dirs = {
    "~/Downloads/",
    { "~", exact = true },
    { "/", exact = true },
    { "/tmp", exact = true },
  },

  -- fix starting session not in git root (monorepo and possibly workspaces)
  config = function(_, opts)
    local persisted = require("persisted")
    persisted.branch = function()
      local branch = vim.fn.systemlist("git branch --show-current")[1]
      return vim.v.shell_error == 0 and branch or nil
    end
    persisted.setup(opts)
  end,
}

return M
