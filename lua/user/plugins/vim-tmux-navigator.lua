local M = {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<m-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<m-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<m-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<m-l>", "<cmd>TmuxNavigateRight<cr>" },
    { "<m-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
  },
}

M.config = function()
  vim.g.tmux_navigator_no_wrap = 1
end

return M
