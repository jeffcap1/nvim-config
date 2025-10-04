local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp",
    -- fang2hou/blink-copilot
  },
}

M.opts = {
  panel = {
    keymap = {
      jump_next = "<c-j>",
      jump_prev = "<c-k>",
      accept = "<c-l>",
      refresh = "r",
      open = "<M-CR>",
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<c-l>",
      next = "<c-n>",
      prev = "<c-p>",
      dismiss = "<c-h>",
    },
  },
  filetypes = {
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/fnm/node-versions/v24.9.0/installation/bin/node",
}

-- stylua: ignore
M.keys = {
  { "<c-s>", ":lua require('copilot.suggestion').toggle_auto_trigger()<CR>" },
}
-- stylua: ignore end

return M
