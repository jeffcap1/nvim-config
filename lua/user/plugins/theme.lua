local M = {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
}

function M.config()
  require "catppuccin".setup {
    flavour = "mocha",
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
    term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false,             -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15,           -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,             -- Force no italic
    no_bold = false,               -- Force no bold
    no_underline = false,          -- Force no underline
    styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" },     -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = { "italic" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
      return {
        CursorLine = { ctermbg = colors.none, bg = "#242539" },
        -- ColorColumn = { ctermbg = colors.none, bg = "#242539" },
      }
    end,
    integrations = {
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
        inlay_hints = {
          background = true,
        },
      },
      harpoon = true,
      neogit = true,
      nvim_surround = true,
      lsp_trouble = true,
      mason = true,
      ufo = true,
      rainbow_delimiters = true,
      render_markdown = true,
      which_key = true,
      mini = {
        enabled = true,
        indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      },
    },
  }
  vim.cmd.colorscheme "catppuccin"
end

return M
