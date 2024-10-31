local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
    "MunifTanjim/nui.nvim",
  },
}

M.keys = {
  {
    "<m-[>",
    ":Neotree filesystem reveal left<cr>",
    desc = "Neotree Open Filesystem",
    silent = true,
  },
  {
    "<leader>bf",
    ":Neotree buffers reveal float<cr>",
    desc = "Neotree Open Buffers",
    silent = true,
  },
}

M.opts = {
  sources = { "filesystem", "buffers", "git_status" },
  open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  },
  window = {
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = true, -- don't wait for leader key
      },
    },
  },
}

function M.config()
  require("neo-tree").setup({
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.cmd([[
          setlocal relativenumber
        ]])
        end,
      },
      {
        event = "file_opened",
        handler = function()
          -- auto close
          vim.cmd("Neotree close")
        end,
      },
    },
  })
end

return M
