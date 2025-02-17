local M = {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "nvim-telescope/telescope-media-files.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
  },
}

function M.config()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  local extensions = telescope.extensions

  local keymap = vim.keymap.set

  -- stylua: ignore start
  -- keymap("n", "<leader>fp", builtin.git_files, XTND({ desc = "Git Files" }))
  -- keymap("n", "<leader>bb", builtin.buffers, XTND({ desc = "Buffers" }))
  -- keymap("n", "<leader>fa", function() builtin.find_files({ hidden = true, no_ignore = true }) end, XTND({ desc = "All Files" }))
  -- keymap("n", "<leader>ff", builtin.find_files, XTND({ desc = "Files" }))
  -- keymap("n", "<leader>ft", builtin.live_grep, XTND({ desc = "Text" }))
  -- keymap("n", "<leader>fg", extensions.live_grep_args.live_grep_args, XTND({ desc = "Ripgrep" }))
  -- keymap("n", "<leader>fs", builtin.grep_string, XTND({ desc = "String" }))
  -- keymap("n", "<leader>fh", builtin.help_tags, XTND({ desc = "Help" }))
  keymap("n", "<leader>fi", extensions.media_files.media_files, XTND({ desc = "Media" }))
  -- keymap("n", "<leader>fl", builtin.resume, XTND({ desc = "Resume" }))
  -- keymap("n", "<leader>fm", builtin.man_pages, XTND({ desc = "Man Pages" }))
  -- keymap("n", "<leader>fM", builtin.marks, XTND({ desc = "Marks" }))
  -- keymap("n", "<leader>fr", builtin.oldfiles, XTND({ desc = "Recent" }))
  -- keymap("n", "<leader>fR", builtin.registers, XTND({ desc = "Registers" }))
  -- keymap("n", "<leader>fq", builtin.quickfix, XTND({ desc = "Telescope Quick Fix" }))
  keymap("n", "<leader>fQ", builtin.quickfixhistory, XTND({ desc = "Telescope QF History" }))
  --[[ keymap("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
  keymap("n", "<leader>fD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
  keymap("n", "<leader>fo", "<cmd>Telescope vim_options<cr>", { desc = "Options" }) ]]
  -- stylua: ignore end

  local icons = require("user.icons")
  local actions = require("telescope.actions")
  local lga_actions = require("telescope-live-grep-args.actions")

  telescope.setup({
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      -- path_display = { "filename_first" },
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
        require("telescope.themes").get_dropdown({}),
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            ["<C-s>"] = actions.to_fuzzy_refine,
          },
        },
      },
    },

    pickers = {
      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        previewer = false,
      },

      buffers = {
        -- theme = "dropdown",
        -- previewer = false,
        theme = "ivy",
        initial_mode = "normal",
        sort_lastused = true,
        sort_mru = true,
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
            ["q"] = actions.close,
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
  })

  -- then load the extension
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
  telescope.load_extension("live_grep_args")
end

return M
