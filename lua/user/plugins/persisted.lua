local M = {
  "olimorris/persisted.nvim",
  event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
}

M.ops = {
  autostart = true, -- Automatically start the plugin on load?
  use_git_branch = true, -- Include the git branch in the session file name?

  -- Table of dirs that are ignored for starting and autoloading
  ignored_dirs = {
    "~/Downloads/",
    { "/", exact = true },
    { "/tmp", exact = true },
  },
}

return M
