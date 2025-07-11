local icons = require("user.icons")

local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    "echasnovski/mini.icons",
  },
}

---@type snacks.Config
M.opts = {
  bigfile = { enabled = true },
  bufdelete = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      -- stylua: ignore start - ensure remove trailing whitespace on logo stays
      header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
      ]],
      -- stylua: ignore end
    },
    config = function(opts)
      -- stylua: ignore start
      table.insert(opts.preset.keys,#opts.preset.keys, { action = ":Mason", key = "M", desc = "Mason", icon = " " })
      -- stylua: ignore end
    end,
  },
  gitbrowse = { enabled = true },
  indent = {
    enabled = true,
    chunk = {
      enabled = true,
      char = {
        corner_top = "╭",
        corner_bottom = "╰",
        arrow = icons.ui.TriangleShortArrowRightNoSpace,
      },
    },
  },
  input = {
    enabled = true,
    icon = " ",
    icon_hl = "SnacksInputIcon",
    icon_pos = "left",
    prompt_pos = "title",
    win = { style = "input" },
    expand = true,
  },
  styles = {
    input = {
      relative = "cursor",
      row = 1,
    },
  },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  explorer = { enabled = true },
  image = {
    enabled = true,
    doc = {
      inline = false,
    },
  },
  lazygit = { enabled = true },
  picker = {
    enabled = true,
    sources = {
      explorer = {
        auto_close = true,
        hidden = true,
        follow = true,
        ignored = true,
        exclude = { "node_modules", ".git", ".venv" },
      },
    },
    matcher = {
      frecency = true,
    },
    win = {
      input = {
        keys = {
          -- to close the picker on ESC instead of going to normal mode,
          -- add the following keymap to your config
          -- ["<Esc>"] = { "close", mode = { "n", "i" } },
          -- I'm used to scrolling like this in LazyGit
          ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["<c-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
          ["<c-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
        },
      },
    },
    formatters = {
      file = {
        filename_first = true, -- display filename before the file path
        truncate = 80,
      },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  --[[ scroll = {
    enabled = true,
    -- what buffers to animate
    filter = function(buf)
      return vim.g.snacks_scroll ~= false
        and vim.b[buf].snacks_scroll ~= false
        and vim.bo[buf].buftype ~= "terminal"
        and vim.bo[buf].filetype ~= "blink-cmp-menu"
    end,
  }, ]]
  scratch = { enabled = true },
  terminal = { enabled = true, win = { style = "float", border = "rounded" } },
  words = { enabled = true },
  zen = { enabled = true },
}

-- stylua: ignore
M.keys = {
  { "<c-e>",      function() Snacks.explorer() end, desc = "File Explorer" },
  { "<leader>Z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
  { "<leader>z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
  { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
  { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
  { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  { "<leader>bd",  function() Snacks.bufdelete() end, desc = "Delete Buffer" },
  { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
  { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
  { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
  { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  -- picker
  { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
  { "<leader>fg", function() Snacks.picker.git_files({ layout = { preset = 'telescope' } }) end, desc = "Git Files" },
  { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
  { "<leader>ft", function() Snacks.picker.grep() end, desc = "Text" },
  { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "String" },
  { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
  { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },
  { "<leader>f\"", function() Snacks.picker.registers() end, desc = "Registers" },
  { "<leader>fd", function() Snacks.picker.diagnostics({ focus = "list" }) end, desc = "Diagnostics" },
  { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
  { "<leader>fk", function() Snacks.picker.keymaps({ layout = { preset = 'ivy' } }) end, desc = "Keymaps" },
  { "<leader>fl", function() Snacks.picker.loclist() end, desc = "Location List" },
  { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<leader>fM", function() Snacks.picker.man() end, desc = "Man Pages" },
  { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
  { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
  { "<leader>fs", function() Snacks.picker.lsp_symbols({ layout = { preset = 'dropdown' } }) end, desc = "LSP Symbols" },
  { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  { '<leader>f/', function() Snacks.picker.search_history() end, desc = "Search History" },
  { "<leader>bb", function()
    Snacks.picker.buffers({
      finder = "buffers",
      format = "buffer",
      hidden = false,
      unloaded = true,
      current = true,
      focus = "list",
      layout = { preset = 'ivy' },
      win = {
        list = {
          keys = {
            ["d"] = { "bufdelete", mode = { "n" }, nowait = true }
          }
        },
      },
    })
  end, desc = "Buffers" },
  -- terminal
  { "<m-;>", function() Snacks.terminal.toggle() end, desc = "Terminal",  mode = { "n", "t" } },
  -- news
  {
    "<leader>N",
    desc = "Neovim News",
    function()
      Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = "yes",
          statuscolumn = " ",
          conceallevel = 3,
        },
      })
    end,
  }
}

return M
