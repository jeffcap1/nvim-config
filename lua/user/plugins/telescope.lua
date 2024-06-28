local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-media-files.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  },
}

function M.config()
  local builtin = require "telescope.builtin"
  local keymap = vim.keymap.set

  keymap("n", "<leader>p", builtin.git_files, XTND { desc = "Git Files" })
  keymap("n", "<leader>bb", builtin.buffers, XTND { desc = "Buffers" })
  keymap("n", "<leader>fa", function()
    builtin.find_files { hidden = true, no_ignore = true }
  end, XTND { desc = "Find All Files" })
  keymap("n", "<leader>fb", builtin.current_buffer_fuzzy_find, XTND { desc = "Telescope Find Buffer" })
  keymap("n", "<leader>ff", builtin.find_files, XTND { desc = "Find Files" })
  keymap("n", "<leader>ft", builtin.live_grep, XTND { desc = "Find Text" })
  keymap("n", "<leader>fs", builtin.grep_string, XTND { desc = "Find String" })
  keymap("n", "<leader>fh", builtin.help_tags, XTND { desc = "Help" })
  keymap(
    "n",
    "<leader>fi",
    "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>",
    XTND { desc = "Media" }
  )
  keymap("n", "<leader>fl", builtin.resume, XTND { desc = "Resume" })
  keymap("n", "<leader>fM", builtin.man_pages, XTND { desc = "Man Pages" })
  keymap("n", "<leader>fr", builtin.oldfiles, XTND { desc = "Recent" })
  keymap("n", "<leader>fR", builtin.registers, XTND { desc = "Registers" })
  keymap("n", "<leader>fe", builtin.quickfix, XTND { desc = "Telescope Quick Fix" })

  local icons = require "user.icons"
  local actions = require "telescope.actions"

  require "telescope".setup {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      -- path_display = { "smart" },
      path_display = { "filename_first" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    extensions = {
      ["ui-select"] = {
        require "telescope.themes".get_dropdown {},
      },
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
      },

      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        previewer = false,
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      -- Enable if perf issue continues in live_grep
      preview = {
        treesitter = {
          enable = true,
          disable = { "javascript" },
        },
      },
    },
  }
  require "telescope".load_extension "ui-select"
end

return M
