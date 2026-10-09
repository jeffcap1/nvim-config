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
      -- accept = "<c-l>",
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
}

-- resolved when copilot loads (InsertEnter), not at startup.
-- NOTE: only used when `server = { type = "nodejs" }`; copilot.lua defaults to its native
-- copilot-language-server binary, which needs no node. Kept so switching to nodejs just works.
-- copilot.lua requires Node.js >= 22; resolver order lives in user/node.lua (fnm -> volta -> PATH)
function M.config(_, opts)
  opts.copilot_node_command = require("user.node").find({ min_major = 22 }) or "node"
  require("copilot").setup(opts)
end

-- stylua: ignore
M.keys = {
  { "<c-s>", ":lua require('copilot.suggestion').toggle_auto_trigger()<CR>" },
}
-- stylua: ignore end

return {
  M,
  -- lualine component (only puts lualine/components/copilot.lua on rtp; doesn't load copilot)
  { "AndreM222/copilot-lualine" },
}
