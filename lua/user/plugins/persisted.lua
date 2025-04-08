local M = {
  "olimorris/persisted.nvim",
  lazy = false, -- make sure the plugin is always loaded at startup
}

M.ops = {
  use_git_branch = true,
  ignored_dirs = {
    "~/Downloads/",
    { "/", exact = true },
    { "/tmp", exact = true },
  },
}

vim.api.nvim_create_autocmd("User", {
  pattern = "PersistedTelescopeLoadPre",
  callback = function(session)
    -- Save the currently loaded session using the global variable
    require("persisted").save({ session = vim.g.persisted_loaded_session })

    -- Delete all of the open buffers
    vim.api.nvim_input("<ESC>:%bd!<CR>")
  end,
})

return M
